--
--  longmath.lua is part of longmath version 1.0. 
--
--  (c) 2024 Hans-Jürgen Matschull
--
--  This work may be distributed and/or modified under the
--  conditions of the LaTeX Project Public License, either version 1.3
--  of this license or (at your option) any later version.
--  The latest version of this license is in
--    http://www.latex-project.org/lppl.txt
--  and version 1.3 or later is part of all distributions of LaTeX
--  version 2005/12/01 or later.
-- 
--  This work has the LPPL maintenance status 'maintained'.
--  
--  The Current Maintainer of this work is Hans-Jürgen Matschull
-- 
--  see README for a list of files belonging to longmath.
--

-- Attribute numbers. 
local attr_info = luatexbase.registernumber( 'longmath@info' )
local attr_limits = luatexbase.registernumber( 'longmath@limits' )

-- Character for tagging parent groups. 
local parent = '+'


-- Check for specific node types. 
local ntypes = node.types()
local function is_noad( nd )  return nd and ntypes[ nd.id ] == 'noad' and nd.subtype end 
local function is_fence( nd ) return nd and ntypes[ nd.id ] == 'fence' and nd.subtype end 
local function is_hlist( nd ) return nd and ntypes[ nd.id ] == 'hlist' and nd.subtype end 
local function is_style( nd ) return nd and ntypes[ nd.id ] == 'style' and nd.subtype end 
local function is_whatsit( nd ) return nd and ntypes[ nd.id ] == 'whatsit' and nd.subtype end 

-- Read a command whatsit. 
local function get_comm( nd ) 
  if is_whatsit( nd ) == 3 and node.has_attribute( nd, attr_info ) then 
    local comm, data = nd.data:match( '^([^:]+):?(.*)$' )
    if data == '' then data = nil end 
    return comm, data, node.get_attribute( nd, attr_info )   
  end 
end 

-- Iterator over all fields of a node to be copied. 
-- Returns the field name and a boolean indicating if a deep copy is needed.
-- If the node already has fixed dimensions, its head field is ignored.  
-- If the limits attribute is set on a large operator, scripts are ignored in display style. 
local function fields( nd, disp )
  local list, oper = {}, is_noad( nd )   
  for _, fld in ipairs( node.fields( nd.id, nd.subtype ) ) do 
    list[fld] = not not node.is_node( nd[fld] ) 
  end 
  list.id, list.subtype, list.attr = nil, nil, list.attr and false 
  if list.height ~= nil and list.depth ~= nil then list.head = nil end
  if ( disp and oper == 1 or oper == 2 ) and node.has_attribute( nd, attr_limits ) then 
    list.sub, list.sup = nil, nil 
  end
  return pairs( list ) 
end 

-- Tables representing special delimiters. 
local delim_null = { small_fam = 0, small_char = 0, large_fam = 0, large_char = 0 }
local delim_auto = { small_fam = 0xF, small_char = 0xEF, large_fam = 0xE, large_char = 0xFE }

-- Check if two delimiters (either real nodes or tables) are equal. 
local function delim_eq( da, db ) 
  for i in pairs( delim_null ) do if da[i] ~= db[i] then return false end end 
  return true
end 

-- Make the delimiter node or table da equal to db.  
local function delim_set( da, db ) 
  for i in pairs( delim_null ) do da[i] = db[i] end 
  return da 
end 

-- Metatable for delimiter sequences. Internalises the overflow check.  
local meta_delims = {}
function meta_delims.__index( tab, ix ) 
  if type( ix ) ~= 'number' then return nil end 
  if ix > #tab then ix = #tab end 
  if ix < 1 then ix = 1 end 
  return rawget( tab, ix ) 
end 

-- Stack to store auto delimiters. 
-- The last entry in this table is the current one.
-- It contains two tables "opn" and "cls". 
-- Each contains a sequence of delimiter data for each level.   
local delimiters = {} 

-- Scans a sample of auto delimiters. 
-- Inserts the opening and closing delimites into the "opn" and "cls" tables in "tab". 
local function scan_sample( head, tab )
  local opn, cls  
  for pos in node.traverse( head ) do
    if is_fence( pos ) == 1 then opn = delim_set( {}, pos.delim )  
    elseif is_fence( pos ) == 3 then cls = delim_set( {}, pos.delim )
    elseif is_noad( pos ) == 9 then scan_sample( pos.nucleus.head, tab ) end 
  end 
  if opn and cls then table.insert( tab.opn, opn ) table.insert( tab.cls, cls ) end 
end 

-- This function is triggered by a "set" command. 
-- The "sample" is a node containing a nested list if delimiter groups. 
-- Push a new item on the stack and scan the sample. 
local function set_auto( sample )
  local tab = { opn = setmetatable( {}, meta_delims ), cls = setmetatable( {}, meta_delims ) }
  table.insert( delimiters, tab )
  scan_sample( sample, tab )
end 

-- This function is triggered by a "res" command.
-- Remove the topmost item from the stack. 
local function res_auto()
  table.remove( delimiters )
end 

-- Adapt a fake delimiter group to the given data. 
-- "head" is the node containing the "\math___{}" object. 
-- "level" is the nesting level to be used if this is an auto delimiter. 
-- "ht" and "dp" are the height and depth of the content of the group. 
-- Returns the level if this was an auto delimiter 
--    or a fixed one equal to the auto delimiter of some level.  
local function set_delim( head, level, ht, dp ) 
  local type, delim, hbox = head.subtype == 6 and 'opn' or head.subtype == 7 and 'cls'
  while is_noad( head ) do 
    node.unset_attribute( head, attr_info ) head = head.nucleus
    node.unset_attribute( head, attr_info ) head = head.head
  end 
  for pos in node.traverse( head ) do 
    node.unset_attribute( pos, attr_info ) 
    if is_fence( pos ) == 3 then delim = pos.delim end 
    if is_noad( pos ) == 0 then hbox = pos.nucleus.head end
  end 
  if not ( delim and hbox ) then return end 
  local auto = delim_eq( delim, delim_auto )
  local brks = delimiters[#delimiters]
  if brks then brks = brks[type] end 
  if type and auto and brks then 
    delim_set( delim, brks[level] ) 
  else
    level = nil 
  end  
  local scale = node.get_attribute( hbox, attr_info ) 
  hbox.height, hbox.depth = ht * scale // 1000, dp * scale // 1000
  if delim_eq( delim, delim_null ) then
    hbox.width = -2 * tex.dimen.nulldelimiterspace 
  else 
    hbox.width = -tex.dimen.nulldelimiterspace   
  end 
  return level 
end

-- This creates a deep copy of the node list from start to stop (inclusive).
-- Ignores whatsits and the content of nodes that have fixed dimension.
-- Ignores limits of large operators if flagged and "disp" is true.   
-- Ignores nodes that have the info attribute set. These are unprocessed delimiters.  
-- Tries to keep track of the current math style. 
local function copy_list( start, stop, disp ) 
  local old, new, copy, last = start 
  while old do    
    if is_style( old ) then disp = old.style:match( 'display' ) end 
    local ign = is_noad( old ) and node.has_attribute( old, attr_info ) or is_whatsit( old )  
    if not ign then   
      new = node.new( old.id, old.subtype )
      for field, deep in fields( old, disp ) do 
        if deep then 
          local disp = disp and ( field == 'nucleus' or field == 'head' or field == 'display' ) 
          new[field] = copy_list( old[field], nil, disp )
        else 
          new[field] = old[field]   
        end
      end 
      if not copy then last, copy = new, new
      else last, copy = new, node.insert_after( copy, last, new ) end 
    end 
    if old == stop then break end 
    old = node.next( old )
  end 
  return copy 
end 

-- Creates a math style node. 
local function style_node( style )
  local nd = node.new( "style" )
  nd.style = style 
  return nd 
end 

-- Copies the node list from "start" to "stop" and packs it into a temporary hbox. 
-- Returns the height and depth of that box when typeset in "style". 
local function dimensions( start, stop, style )
  local disp = style == 'display' or style == 0 or style == 1 
  local copy = copy_list( start, stop, disp )
  if not copy then return 0, 0 end 
  if style then copy = node.insert_before( copy, copy, style_node( style ) ) end 
  local box = node.mlist_to_hlist( copy, 'text', false )
  if not box then return 0, 0 end 
  local wd, ht, dp = node.dimensions( box )
  node.flush_list( box )
  return ht, dp 
end

-- Table containing information read from the aux file.
local oldgroups = {}
-- Table containing information to be written to the aux file.
local newgroups = {}
-- Table containing tables of tags that are synonyms for the same group. 
local equals = {} 

-- Merge information of a group with the inforation from the aux file 
--   and store the new information to be written to the aux file. 
-- A group table contains the following information: 
-- "tags": table of tags attached to the group (as keys with value "true").
-- "ht", "dp": dimensions
-- "lv": the maximal level of automatic delimiters used for subgroups.  
local function max( a, b ) return a and b and math.max( a, b ) or a or b end 
local function merge( group ) 
  local tags = group.tags
  if not tags or not next( tags ) then return end 
  if next( tags, ( next( tags ) ) ) then table.insert( equals, tags ) end 
  for tag in pairs( tags ) do 
    local ngrp = newgroups[tag] or {}
    newgroups[tag] = ngrp
    ngrp.ht = max( ngrp.ht, group.ht )
    ngrp.dp = max( ngrp.dp, group.dp )
    ngrp.lv = max( ngrp.lv, group.lv )
  end
  for tag in pairs( tags ) do 
    local ogrp = oldgroups[tag]
    if ogrp then 
      group.ht = max( group.ht, ogrp.ht )
      group.dp = max( group.dp, ogrp.dp )
      group.lv = max( group.lv, ogrp.lv )
    end 
  end
end 


-- Parses a math list and process all delimiters.
-- "pargrp" is the parent group. 
-- "head" is the head of the math list. 
-- "open" is the opening delimiter if this is a recursive call. 
-- "pos" is the position where to start the scan. 
-- "style" is the current math style, if known. 
--   This will otherwise be set when th first command is detected. 
-- "group" is the group table for this group. 
-- Returns a modified head, and sets information in the parent group. 
-- "delims" collects all delimiters belonging to this group. 
-- When a longmath special is detected, it is removed and the next node is processed: 
--   set/res: set or reset auto delimiters.
--   opn: an opening delimiter follows. The function is called recursively. 
--   cls: a closing delimiter follows. The current group ends 
--   mid: an inner delimiter follows. 
-- For every other node in the list, its subnodes are parsed recursively. 
local function parse( pargrp, head, open, pos, style, group ) 
  if not head then return end
  local delims, subgrp = { open }
  group = group or {}
  pos = pos or head 
  while pos do
    local comm, data, info = get_comm( pos )
    if comm then head, pos = node.remove( head, pos )
      if comm == 'set' then set_auto( pos ) return head end 
      if comm == 'res' then res_auto() return head end 
      style = style or info 
      group.tags = group.tags or {}
      if comm == 'opn' then
        local subgrp = { tags = {} }
        if data then subgrp.tags[data] = true end  
        head, pos = parse( group, head, pos, node.next( pos ), info, subgrp ) 
      elseif comm == 'mid' then 
        if data then group.tags[data] = true end  
        table.insert( delims, pos )
        pos = node.next( pos )
      elseif comm == 'cls' then 
        if data then group.tags[data] = true end  
        table.insert( delims, pos )
        break
      end 
    else  
      for field, deep in fields( pos ) do if deep then 
        pos[field] = parse( group, pos[field] )
      end end 
      pos = node.next( pos )
    end     
  end 
  -- if this is an actual delimiter group, measure its demensions. 
  if group.tags then group.ht, group.dp = dimensions( open or head, pos, style ) end 
  -- merge information with aux file 
  merge( group )
  -- finally set the delimiters and parse any scripts attached to them.
  local level, auto = group.lv or 0  
  for _, del in ipairs( delims ) do
    auto = set_delim( del, level+1, group.ht, group.dp ) or auto 
    del.sub = parse( group, del.sub )
    del.sup = parse( group, del.sup )
  end
  if pos and not open then 
    -- this group started without an opening delimiter. 
    -- we use a tail call and proceed as if there was one and this function was called from a parent. 
    pargrp = { lv = auto or group.lv, tags = {} }
    if group.tags then for tag in pairs( group.tags ) do pargrp.tags[tag..parent] = true end end 
    return parse( {}, head, nil, node.next( pos ), style, pargrp )   
  else  
    -- inform the parent about the auto delimiter level and any tags used in subgroups.  
    pargrp.lv = max( pargrp.lv, auto or group.lv ) 
    if pargrp.tags and group.tags then for tag in pairs( group.tags ) do pargrp.tags[tag..parent] = true end end 
    return head, pos  
  end 
end 
  
-- Callback that scans a math list. 
local function scan( head, style, pen )
  head = parse( {}, head, nil, nil, style ) 
  return node.mlist_to_hlist( head, style, true ) 
end 
luatexbase.add_to_callback( 'mlist_to_hlist', scan, 'longmath parse' )

-- Creates a glue node. 
local function glue_node( wd )
  local nd = node.new( "glue", 8 )
  nd.width = wd 
  return nd 
end 

-- Applies a stepwise shift to the hlists in a vlist if "extra" is non-zero.   
local function shift( head )
  local extra = tex.dimen['longmath@extra'] 
  if extra == 0 then return true end  
  local lines = {} 
  for nd in node.traverse( head ) do 
    if is_hlist( nd ) == 1 then table.insert( lines, nd ) end
  end 
  local n = #lines - 1
  if n > 0 then 
    for i, nd in ipairs( lines ) do  
      nd.width = nd.width + extra 
      nd.head = node.insert_before( nd.head, nd.head, glue_node( (i-1) * extra / n ) )
      nd.head = node.insert_after( nd.head, node.tail( nd.head ), glue_node( (n-i+1) * extra / n ) )
    end
  end 
  return true
end
luatexbase.add_to_callback( 'post_linebreak_filter', shift, 'longmath shift' )

-- Table for functions to be called from TeX. 
longmath = {}

-- Read data for a collection of identical groups. 
function longmath.read_group( tags, tab ) 
  for _, tag in ipairs( tags ) do oldgroups[tag] = tab end  
end

-- Check if a tag is not already in a set. 
-- If a subgroup or parent is in the set, inserts it into a the "loops" table. 
local loops = {}
local loop_patt = '[' .. parent .. ']*$'
local function is_new( tag, set )
  if set[tag] then return false end 
  tag = tag:gsub( loop_patt, '' )
  for tagg in pairs( set ) do if tag == tagg:gsub( loop_patt, '' ) then 
    loops[ tag:gsub( '@$', '' ) ] = true 
    return false 
  end end 
  return true 
end 

-- Given a set of tags attached to the same group, 
--   add all other tags attached to the same group to the set. 
local function find_eq( set )
  local new = {}
  for tag in pairs( set ) do 
    local app = ''
    while true do   
      for _, w in ipairs( equals ) do if w[tag] then for tagg in pairs( w ) do 
          if is_new( tagg..app, set ) then new[tagg..app] = true end 
      end end end 
      if tag:sub(-1) ~= parent then break end 
      tag, app = tag:sub(1,-2), app .. parent 
    end 
  end 
  if not next( new ) then return set end
  for tag in pairs( new ) do set[tag] = true end 
  return find_eq( set )
end

local loop_mess = '\\PackageWarningNoLine{longmath}{Cyclic delimiter group%s %s detected}'
local data_mess = '\\PackageWarningNoLine{longmath}{Delimiters may have changed. Rerun to get them right}'

-- Save all groups to the aux file.
-- Tags that belong to the same group are collected into a single entry.
function longmath.save_groups( aux )
  local check, done = true, {} 
  for tag, grp in pairs( newgroups ) do if not done[tag] then 
    local tags, vals, eqs = {}, {}, find_eq( { [tag] = true } ) 
    for tagg in pairs( eqs ) do 
      check, done[tagg] = check and oldgroups[tagg], true 
      table.insert( tags, string.format( '%q', tagg ) )
      while tagg do 
        if newgroups[tagg] then 
          grp.ht, grp.dp = max( grp.ht, newgroups[tagg].ht ), max( grp.dp, newgroups[tagg].dp )
          grp.lv = max( grp.lv, newgroups[tagg].lv )
        end 
        tagg = tagg:match( '^(.*)[' .. parent .. ']$' )
      end 
    end 
    for k, v in pairs( grp ) do  
      table.insert( vals, string.format( '%s=%d', k, v ) )
      for tagg in pairs( eqs ) do check = check and v == oldgroups[tagg][k] end 
    end
    tags, vals = table.concat( tags, ',' ), table.concat( vals, ',' ) 
    texio.write( aux, string.format( '\\longmath@group{%s}{%s}\n', tags, vals ) )
  end end 
  local lps = {}
  for l in pairs( loops ) do 
    if #lps > 5 then table.insert( lps, '...' ) break end 
    table.insert( lps, l )
  end 
  if #lps > 0 then 
    tex.print( string.format( loop_mess, #lps > 1 and 's' or '', table.concat( lps, ', ' ) ) )
  end 
  if not check then tex.print( data_mess ) end  
end 

return 
