-- autotype.lua
-- Copyright 2020-2024 Stephan Hennig and Keno Wehr
--[[
This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.
]]

-- luacheck: globals font luatexbase node tex

luatexbase.provides_module({
  name        = "autotype",
  version     = "0.5",
  date        = "2024-01-05",
  description = "automatic language-specific typography"
})

local Ncopy = node.copy
local NLcopy = node.copy_list
local Ninsert_after = node.insert_after
local Ninsert_before = node.insert_before
local Nnew = node.new
local Nhas_attribute = node.has_attribute
local Uchar = utf8.char

local kern_templ = Nnew('kern', 1) -- subtype 1 means userkern

local function get_kern_node(dim)
  local n = Ncopy(kern_templ)
  n.kern = dim
  return n
end

local HYPHEN = 0x2D -- ASCII/Unicode codepoint of a hyphen

-- Penalty values for primary, secondary, and tertiary hyphenation points
local PENALTY_I = 30
local PENALTY_II = 60
local PENALTY_III = 90

local LEFTHYPHENMIN = 2
local RIGHTHYPHENMIN = 2

local long_s_codepoint = {}
local round_s_codepoint = {}
local final_round_s_codepoint = {}

local function normalize_font(TeX_font_name)
  -- We have to do some normalization of the name of the current font.
  -- Examples: The yfrak font at 11pt is called "yfrak at 10.95pt" by TeX, but we need only "yfrak".
  -- The yfrak font becomes something like "yfrak+100ls" if it is letterspaced (e.g. with microtype's \textls commmand),
  -- but again, we only need "yfrak".
  return string.gsub(TeX_font_name, "[ :%+].*", "")
end

local function set_long_s_codepoint(font, codepoint)
  long_s_codepoint[normalize_font(font)] = codepoint
end

local function set_round_s_codepoint(font, codepoint)
  round_s_codepoint[normalize_font(font)] = codepoint
end

local function set_final_round_s_codepoint(font, codepoint)
  final_round_s_codepoint[normalize_font(font)] = codepoint
end

local function get_long_s_codepoint(font_id)
  local font = normalize_font(tex.fontname(font_id))
  local codepoint
  if long_s_codepoint[font] then
    codepoint = long_s_codepoint[font] -- for fonts with irregular encodings
  else
    codepoint = 0x17F -- Unicode codepoint of ſ
  end
  return codepoint
end

local function get_round_s_codepoint(font_id)
  local font = normalize_font(tex.fontname(font_id))
  local codepoint
  if round_s_codepoint[font] then
    codepoint = round_s_codepoint[font] -- for fonts with irregular encodings
  else
    codepoint = 0x73 -- ASCII/Unicode codepoint of s
  end
  return codepoint
end

local function get_final_round_s_codepoint(font_id)
  local font = normalize_font(tex.fontname(font_id))
  local codepoint
  if final_round_s_codepoint[font] then
    codepoint = final_round_s_codepoint[font] -- for fonts like wesu14
  else
    codepoint = get_round_s_codepoint(font_id)
  end
  return codepoint
end

local function get_current_long_s_codepoint()
  return get_long_s_codepoint(font.current())
end

local function get_current_round_s_codepoint()
  return get_round_s_codepoint(font.current())
end

local function insert_discretionary(head, first, second, penalty, pre_char)
  -- Create discretionary node
  local d = Nnew('disc', 0)
  d.attr = first.attr
  d.penalty = penalty
  -- Set pre-break text
  if pre_char then
    local pre = Ncopy(first)
    pre.char = pre_char
    d.pre = pre
  end
  -- Insert discretionary before second node
  Ninsert_before(head, second, d)
end


-- @param head  Head of a node list.
local function insert_primary_hyphenation_points(head, scan_node_list)
  -- Do pattern matching.
  local words = scan_node_list(head)
  -- Iterate over words.
  for _, word in ipairs(words) do
    if not word.exhyphenchars then
      -- Process words not containing explicit hyphens
      for i, level in ipairs(word.levels) do
        -- Spot with surrounding top-level nodes?
        if (level % 2 == 1) and not word.parents[i-1] and not word.parents[i] then
          insert_discretionary(head, word.nodes[i-1], word.nodes[i], PENALTY_I, HYPHEN)
        end
      end
    else
      -- Process words containing explicit hyphens
      local exhyphenchar_num = #word.exhyphenchars -- the number of explicit hyphens in the word
      local char_num = #word.nodes -- the number of characters of the word
      for j, k in ipairs(word.exhyphenchars) do
        -- Primary hyphenation point at the explicit hyphen
        if k > 1 and k < char_num and (j == exhyphenchar_num or word.exhyphenchars[j+1] > k+1) then
          insert_discretionary(head, word.nodes[k], word.nodes[k+1], PENALTY_I)
        end
      end
    end
  end
end

-- The following function is needed for the parts of a word with explicit hyphens.
-- @param head  Head of a node list.
local function insert_tertiary_hyphenation_points(head, original_word, start_number, end_number, scan_node_list)
  local node_list = NLcopy(original_word.nodes[start_number], original_word.nodes[end_number].next)
  local words = scan_node_list(node_list)
  if #words > 0 then
    for i, level in ipairs(words[1].levels) do
      local j = start_number + i - 1
      -- Spot with surrounding top-level nodes?
      if (level % 2 == 1) and not original_word.parents[j-1] and not original_word.parents[j] then
        insert_discretionary(head, original_word.nodes[j-1], original_word.nodes[j], PENALTY_III, HYPHEN)
      end
    end
  end
end

-- @param head  Head of a node list.
local function insert_weighted_hyphenation_points(head, scan_node_list_i, scan_node_list_ii, scan_node_list_iii)
  -- Do pattern matching
  local words_i = scan_node_list_i(head)
  local words_ii = scan_node_list_ii(head)
  local words_iii = scan_node_list_iii(head)
  -- Iterate over words
  for i, word in ipairs(words_i) do
    if not word.exhyphenchars then
      -- Process words not containing explicit hyphens
      for k, level_i in ipairs(word.levels) do
        -- Surrounding top-level nodes?
        if not word.parents[k-1] and not word.parents[k] then
          -- Primary spot?
          if level_i % 2 == 1 then
            insert_discretionary(head, word.nodes[k-1], word.nodes[k], PENALTY_I, HYPHEN)
          else
            local level_ii = words_ii[i].levels[k]
            -- Secondary spot?
            if level_ii % 2 == 1 then
              insert_discretionary(head, word.nodes[k-1], word.nodes[k], PENALTY_II, HYPHEN)
            else
              local level_iii = words_iii[i].levels[k]
              -- Tertiary spot?
              if level_iii % 2 == 1 then
                insert_discretionary(head, word.nodes[k-1], word.nodes[k], PENALTY_III, HYPHEN)
              end
            end
          end
        end
      end
    else
      -- Process words containing explicit hyphens
      local exhyphenchar_num = #word.exhyphenchars -- the number of explicit hyphens in the word
      local char_num = #word.nodes -- the number of characters of the word
      for j, k in ipairs(word.exhyphenchars) do
        -- Tertiary hyphenation points for the word part before the next explicit hyphen
        if j == 1 then
          if k > 1 then -- k == 1 means that the first character is a hyphen.
            insert_tertiary_hyphenation_points(head, word, 1, k-1, scan_node_list_iii)
          end
        elseif word.exhyphenchars[j-1] + 1 < k then
          insert_tertiary_hyphenation_points(head, word, word.exhyphenchars[j-1]+1, k-1, scan_node_list_iii)
        end
        -- Primary hyphenation point at the explicit hyphen
        if k > 1 and k < char_num and (j == exhyphenchar_num or word.exhyphenchars[j+1] > k+1) then
          insert_discretionary(head, word.nodes[k], word.nodes[k+1], PENALTY_I)
        end
      end
      -- Tertiary hyphenation points for the word part after the last explicit hyphen
      if word.exhyphenchars[exhyphenchar_num] < char_num then
        insert_tertiary_hyphenation_points(head, word,
                                           word.exhyphenchars[exhyphenchar_num]+1,
                                           char_num, scan_node_list_iii)
      end
    end
  end
end

-- converts scaled points to big points, rounded to one decimal place
local function sp_to_bp(num)
  return math.floor(num / 65782 * 10) / 10
end

-- The following function marks hyphenation points by a small coloured bar.
-- The code is based on the showhyphens package written by Patrick Gundlach.
local function mark_hyphenation_points(head, lang_name)
  local current_lang
  local current = head
  while current do
    if current.id == node.id('hlist') or current.id == node.id('vlist') then
      mark_hyphenation_points(current.list, lang_name)
    elseif current.id == node.id('glyph') then
      current_lang = current.lang
    elseif current.id == node.id('disc')
           and Nhas_attribute(current, luatexbase.registernumber("autotype_"..lang_name.."_mark_hyph_attr"))
           and current_lang == luatexbase.registernumber('l@'..lang_name) then
      local colour = "1 0 0" -- red
      if current.penalty == PENALTY_I then
        colour = "0 0.6 0" -- dark green
      elseif current.penalty == PENALTY_II then
        colour = "0 0.2 0.8" -- blue
      elseif current.penalty == PENALTY_III then
        colour = "1 0.5 0" -- orange
      end
      if current.replace and current.replace.id == node.id('glyph') and current.replace.components then
        local wd = sp_to_bp(current.replace.width) or 0
        local ht = sp_to_bp(current.replace.height) + 1 or 0
        local r = node.new("whatsit", "pdf_literal")
        r.data = "q "..colour.." RG 0.7 w 0 "
                 .. tostring(ht) .. " m "
                 .. tostring(-wd) .. " " .. tostring(ht) .. " l S Q"
        Ninsert_after(current.replace, current.replace, r)
      else
        local n = node.new("whatsit", "pdf_literal")
        n.mode = 0
        if current.penalty == PENALTY_I then
          n.data = "q "..colour.." RG 0.7 w 0 -1 m 0 8 l S Q"
        elseif current.penalty == PENALTY_II then
          n.data = "q "..colour.." RG 0.7 w 0 -1 m 0 3 l S Q"
        else
          n.data = "q "..colour.." RG 0.7 w 0 4 m 0 8 l S Q"
        end
        n.next = current.next
        current.next.prev = n
        n.prev = current
        current.next = n
        current = n
      end
    end
    current = current.next
  end
end

--- Manipulation that prevents selected ligatures.
-- This manipulation inserts a 0pt kern between glyph nodes at every position
-- indicated by the ligature breaking patterns.  The manipulation has to be
-- applied before TeX's ligaturing stage.  The pos variable points to the glyph
-- node after a spot.  The kern is inserted after the preceeding glyph node.
-- Which is not the same as inserting before the glyph node pointed to as there
-- may be, e.g., a discretionary between two glyph nodes.
--
-- @param head  Head of a node list.
local function break_ligatures(head, scan_node_list, lang_name)
  -- Do pattern matching.
  local words = scan_node_list(head)
  -- Iterate over words.
  for _, word in ipairs(words) do
    -- Debug output.
    local w = {}
    for _, n in ipairs(word.nodes) do
      table.insert(w, Uchar(n.char))
    end
    -- Check all valid spots.
    for pos, level in ipairs(word.levels) do
      -- Valid spot?
      if (level % 2) == 1 then
        -- Apply manipulation to glyph nodes at indices pos-1 and pos.
        -- Only plain top-level glyph nodes are handled currently.
        if not word.parents[pos-1] and not word.parents[pos] then
          local first_node = word.nodes[pos-1]
          if Nhas_attribute(first_node, luatexbase.registernumber("autotype_"..lang_name.."_ligbreak_attr")) then
            local kern_node = get_kern_node(0)
            Ninsert_after(head, first_node, kern_node)
          end
        end
      end
    end
  end
end

--- Manipulation that inserts long s glyphs.
-- All round s glyphs (char code 0x73, LATIN SMALL LETTER S) not
-- followed by a spot are replaced by a long s glyph (char code 0x017f,
-- LATIN SMALL LETTER LONG S).
--
-- @param head  Head of a node list.
local function insert_long_s(head, scan_node_list, lang_name)
  -- Do pattern matching.
  local words = scan_node_list(head)
  -- Iterate over words.
  for _, word in ipairs(words) do
    -- Replace all round s glyphs not followed by a spot by a long s
    -- glyph except for the last character of a word.
    for i, n in ipairs(word.nodes) do
      if n.char == 0x73 and Nhas_attribute(n, luatexbase.registernumber("autotype_"..lang_name.."_long_s_attr")) then
        if i == #word.levels - 1 then -- last character of the word
          n.char = get_final_round_s_codepoint(n.font)
        elseif word.levels[i+1] % 2 == 1 then
          n.char = get_round_s_codepoint(n.font)
        else
          n.char = get_long_s_codepoint(n.font)
        end
      end
    end
  end
end


-- Call-back registering.
--
-- Load padrinoma module.

local padrinoma = require('autotype-pdnm_nl_manipulation')

local function get_hyphenation_pattern_file(lang_name, lang_num, suffix)
  local pattern_file
  if lang_num then
    if lang_num == luatexbase.registernumber('l@german') then
      pattern_file = 'hyph-de-1901'..suffix..'.pat.txt'
    elseif lang_num == luatexbase.registernumber('l@swissgerman') then
      pattern_file = 'hyph-de-CH-1901'..suffix..'.pat.txt'
    else
      pattern_file = 'hyph-de-1996'..suffix..'.pat.txt'
    end
  elseif lang_name == 'german' or lang_name == 'austrian' then
    pattern_file = 'hyph-de-1901'..suffix..'.pat.txt'
  elseif lang_name == 'swissgerman' then
    pattern_file = 'hyph-de-CH-1901'..suffix..'.pat.txt'
  else
    pattern_file = 'hyph-de-1996'..suffix..'.pat.txt'
  end
  if suffix ~= '' then
    pattern_file = 'autotype-'..pattern_file
  elseif pattern_file == 'hyph-de-CH-1901.pat.txt' then
    pattern_file = 'hyph-de-ch-1901.pat.txt' -- hyph-utf8 only uses lower-case letters in file names
  end
  return pattern_file
end

local original_patterns = {}

local function clear_patterns(lang_name)
  local lang_num = luatexbase.registernumber('l@'..lang_name)
  local luatex_lang = lang.new(lang_num)
  if not original_patterns[lang_num] then
    original_patterns[lang_num] = lang.patterns(luatex_lang)
  end
  lang.clear_patterns(luatex_lang)
end

local function restore_patterns(lang_name)
  local lang_num = luatexbase.registernumber('l@'..lang_name)
  if original_patterns[lang_num] then
    lang.patterns(lang.new(lang_num), original_patterns[lang_num])
  end
end

local function default_hyph(lang_name)
  -- Remove primary or weighted hyphenation from hyphenate callback
  if luatexbase.in_callback('hyphenate', 'autotype primary hyphenation for '..lang_name) then
    luatexbase.remove_from_callback('hyphenate', 'autotype primary hyphenation for '..lang_name)
  elseif luatexbase.in_callback('hyphenate', 'autotype weighted hyphenation for '..lang_name) then
    luatexbase.remove_from_callback('hyphenate', 'autotype weighted hyphenation for '..lang_name)
  end
  -- Restore original patterns to be used by TeX's default hyphenation algorithm
  restore_patterns(lang_name)
end

local function primary_hyph(lang_name, lang_num)
  -- Clear the language's patterns to avoid insertion of hyphenation points by TeX
  clear_patterns(lang_name)
  local scan_node_list = padrinoma.create_node_list_scanner(
                           lang_num or lang_name,
                           get_hyphenation_pattern_file(lang_name, lang_num, '-primary'),
                           LEFTHYPHENMIN, RIGHTHYPHENMIN
                         )
  -- Remove weighted hyphenation from hyphenate callback
  if luatexbase.in_callback('hyphenate', 'autotype weighted hyphenation for '..lang_name) then
    luatexbase.remove_from_callback('hyphenate', 'autotype weighted hyphenation for '..lang_name)
  end
  -- Register callback for primary hyphenation
  if not luatexbase.in_callback('hyphenate', 'autotype primary hyphenation for '..lang_name) then
    luatexbase.add_to_callback('hyphenate',
                               function (head, _)
                                 -- Apply default hyphenation (this is important for other languages).
                                 lang.hyphenate(head)
                                 -- Apply node list manipulation.
                                 insert_primary_hyphenation_points(head, scan_node_list)
                               end,
                               'autotype primary hyphenation for '..lang_name)
  end
end

local function weighted_hyph(lang_name, lang_num)
  -- Clear the language's patterns to avoid insertion of hyphenation points by TeX
  clear_patterns(lang_name)
  local scan_node_list_i = padrinoma.create_node_list_scanner(
                             lang_num or lang_name,
                             get_hyphenation_pattern_file(lang_name, lang_num, '-primary'),
                             LEFTHYPHENMIN, RIGHTHYPHENMIN
                           )
  local scan_node_list_ii = padrinoma.create_node_list_scanner(
                              lang_num or lang_name,
                              get_hyphenation_pattern_file(lang_name, lang_num, '-secondary'),
                              LEFTHYPHENMIN, RIGHTHYPHENMIN
                            )
  -- The tertiary hyphenation patterns are the default patterns of LuaTeX, e.g. "hyph-de-1996.pat.txt".
  local scan_node_list_iii = padrinoma.create_node_list_scanner(
                               lang_num or lang_name,
                               get_hyphenation_pattern_file(lang_name, lang_num, ''),
                               LEFTHYPHENMIN, RIGHTHYPHENMIN
                             )
  -- Remove primary hyphenation from hyphenate callback
  if luatexbase.in_callback('hyphenate', 'autotype primary hyphenation for '..lang_name) then
    luatexbase.remove_from_callback('hyphenate', 'autotype primary hyphenation for '..lang_name)
  end
  -- Register callback for weighted hyphenation
  if not luatexbase.in_callback('hyphenate', 'autotype weighted hyphenation for '..lang_name) then
    luatexbase.add_to_callback('hyphenate',
                               function (head, _)
                                 -- Apply default hyphenation (this is important for other languages).
                                 lang.hyphenate(head)
                                 -- Apply node list manipulation.
                                 insert_weighted_hyphenation_points(head, scan_node_list_i,
                                                                    scan_node_list_ii, scan_node_list_iii)
                               end,
                               'autotype weighted hyphenation for '..lang_name)
  end
end

local function mark_hyph(lang_name)
  luatexbase.add_to_callback('post_linebreak_filter',
                             function(head, _)
                               mark_hyphenation_points(head, lang_name)
                               return true
                             end,
                             'autotype marking of hyphenation points for '..lang_name)
end

local function ligbreak(lang_name, lang_num)
  local pattern_file = 'autotype-ligbreak-de.pat.txt' -- TO DO: adapt to language
  local scan_node_list = padrinoma.create_node_list_scanner(lang_num or lang_name, pattern_file, 2, 2)

  -- Remove callback for regular ligaturing if present
  if luatexbase.in_callback('ligaturing', 'TeX ligaturing') then
    luatexbase.remove_from_callback('ligaturing', 'TeX ligaturing')
  end

  -- Register callback for preventing ligatures
  luatexbase.add_to_callback('ligaturing',
                    function (head, _)
                      -- Apply node list manipulation.
                      break_ligatures(head, scan_node_list, lang_name)
                    end,
                    'autotype ligaturing for '..lang_name)

  -- Register callback for regular ligaturing
  luatexbase.add_to_callback('ligaturing',
                             function (head, _)
                               node.ligaturing(head)
                             end,
                             'TeX ligaturing')
end

local function long_s(lang_name, lang_num)
  local pattern_file = 'autotype-round-s-de.pat.txt' -- TO DO: adapt to language
  local scan_node_list = padrinoma.create_node_list_scanner(lang_num or lang_name, pattern_file, 0, 0)

  -- Remove callback for regular ligaturing if present
  if luatexbase.in_callback('ligaturing', 'TeX ligaturing') then
    luatexbase.remove_from_callback('ligaturing', 'TeX ligaturing')
  end

  -- Register callback for long s insertion
  luatexbase.add_to_callback('ligaturing',
                             function (head, _)
                               -- Apply node list manipulation.
                               insert_long_s(head, scan_node_list, lang_name)
                             end,
                             'autotype long s replacement for '..lang_name)

  -- Register callback for regular ligaturing
  luatexbase.add_to_callback('ligaturing',
                             function (head, _)
                               node.ligaturing(head)
                             end,
                             'TeX ligaturing')
end

local function get_penalty(i)
  if i==1 then return PENALTY_I
  elseif i==2 then return PENALTY_II
  elseif i==3 then return PENALTY_III
  end
end


local autotype = {}

autotype.default_hyph = default_hyph
autotype.primary_hyph = primary_hyph
autotype.weighted_hyph = weighted_hyph
autotype.mark_hyph = mark_hyph
autotype.ligbreak = ligbreak
autotype.long_s = long_s
autotype.set_long_s_codepoint = set_long_s_codepoint
autotype.set_round_s_codepoint = set_round_s_codepoint
autotype.set_final_round_s_codepoint = set_final_round_s_codepoint
autotype.get_current_long_s_codepoint = get_current_long_s_codepoint
autotype.get_current_round_s_codepoint = get_current_round_s_codepoint
autotype.get_penalty = get_penalty

return autotype
