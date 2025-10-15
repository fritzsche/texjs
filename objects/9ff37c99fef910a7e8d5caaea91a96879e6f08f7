-- Copyright (c) 2022-2023 Thomas Kelkel kelkel@emaileon.de

-- This file may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either
-- version 1.3c of this license or (at your option) any later
-- version. The latest version of this license is in

--    http://www.latex-project.org/lppl.txt

-- and version 1.3c or later is part of all distributions of
-- LaTeX version 2009/09/24 or later.

-- Version: 0.3

local ID = node.id
local GLYPH = ID ( "glyph" )
local DISC = ID ( "disc" )
local GLUE = ID ( "glue" )
local PENALTY = ID ( "penalty" )
local HLIST = ID ( "hlist" )
local INS = ID ( "ins" )

local SWAPPED = table.swapped
local SUBTYPES = node.subtypes
local SPACESKIP = SWAPPED ( SUBTYPES ("glue") )["spaceskip"]
local LEADERS = SWAPPED ( SUBTYPES ("glue") )["leaders"]
local LBPENALTY = SWAPPED ( SUBTYPES ("penalty") )["linebreakpenalty"]

local NEW = node.new
local REM = node.remove
local PREV = node.prev
local NEXT = node.next
local TAIL = node.tail
local INS_B = node.insert_before
local HAS_GLYPH = node.has_glyph
local T = node.traverse
local T_GLYPH = node.traverse_glyph

local pairs = pairs
local type = type

local U = unicode.utf8
local SUB = U.sub
local GSUB = U.gsub
local FIND = U.find

local FLOOR = math.floor

local GET_FONT = font.getfont

local ATC = luatexbase.add_to_callback

-----

local no_iw_kern = false

function spacekern_no_iw_kern ()
    no_iw_kern = true
end

local function round ( num, dec )
    return FLOOR ( num * 10^dec + 0.5 ) / 10^dec
end

local function find_first_last ( n, node_type, last )
    local d = NEXT
    if last then
        d = PREV
        n = TAIL ( n )
    end
    while true do
        if n and n.id == node_type then
            return n
        end
        if d ( n ) then
            n = d ( n )
        else
            return false
        end
    end
end

local function check_node ( n, space_check, disc_check, last )
    if n.replace then
        return find_first_last ( n.replace, GLYPH, last ), space_check, disc_check
    end
    return n, space_check, disc_check
end

local function find_glyph ( n, d, hlist_check, macro )
    if n then
        local space_check = false
        local disc_check = false
        if hlist_check and ( n.id == GLYPH or n.replace and HAS_GLYPH ( n.replace ) ) then
            return check_node ( n, space_check, disc_check, d == PREV )
        elseif not hlist_check then
            if d ( n ) then
                n = d ( n )
            else
                return false
            end
        end
        while not ( n.id == GLYPH or n.replace and HAS_GLYPH ( n.replace ) ) do
            if n.id == HLIST and n.head then
                local point = n.head
                if d == PREV then
                    point = TAIL ( point )
                end
                return find_glyph ( point, d, true, macro )
            end
            if not d ( n ) or n.id == INS or macro and n.id == GLUE and n.width == 0 then
                return false
            else
                if n.id == GLUE and n.subtype == SPACESKIP then
                    space_check = n
                elseif n.subtype == LEADERS or n.id == GLUE and n.stretch > 0 then
                    return false
                end
            end
            if n.id == DISC then
                disc_check = n
            end
            n = d ( n )
        end
        return check_node ( n, space_check, disc_check, d == PREV )
    end
    return false
end

local function make_kern ( head, font, first_glyph, second_glyph, insert_point )
    local tfmdata = GET_FONT ( font )
    if tfmdata and tfmdata.resources then
        local resources = tfmdata.resources
        if resources.sequences then
            local seq = resources.sequences
            for _, t in pairs ( seq ) do
                if t.steps and ( table.swapped ( t.order )["kern"] or tfmdata.specification.features.raw[t.name] ) then
                    local steps = t.steps
                    for _, k in pairs ( steps ) do
                        if k.coverage and k.coverage[first_glyph] then
                            local glyph_table = k.coverage[first_glyph]
                            if type ( glyph_table ) == "table" then
                                for key, value in pairs ( glyph_table ) do
                                    if key == second_glyph and type ( value ) == "number" then
                                        if not ( ( first_glyph == 32 or second_glyph == 32 ) and table.swapped ( t.order )["kern"] ) then
                                            insert_point.width = insert_point.width + value / tfmdata.units_per_em * tfmdata.size
                                        end
                                        if first_glyph == 32 or second_glyph == 32 then
                                            insert_point.stretch = insert_point.stretch + value / tfmdata.units_per_em * tfmdata.size * 0.5
                                            insert_point.shrink = insert_point.shrink + value / tfmdata.units_per_em * tfmdata.size * 0.33333
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return head, disc_node
end

local function check_glyph ( n, d, has_prev_next_glyph, prev_next_glyph )
    if find_glyph ( n, d ) then
        prev_next_glyph = find_glyph ( n, d )
        has_prev_next_glyph = true
    end
    return has_prev_next_glyph, prev_next_glyph
end

local function make_kerns ( head, n )
    local has_prev_glyph = false
    local has_next_glyph = false
    local prev_glyph = n
    local next_glyph = n
    has_prev_glyph, prev_glyph = check_glyph ( n, PREV, has_prev_glyph, prev_glyph )
    has_next_glyph, next_glyph = check_glyph ( n, NEXT, has_next_glyph, next_glyph )
    if has_prev_glyph and prev_glyph.char and prev_glyph.font then
        head = make_kern ( head, prev_glyph.font, prev_glyph.char, 32, n )
    end
    if has_next_glyph and next_glyph.char and next_glyph.font then
        head = make_kern ( head, next_glyph.font, 32, next_glyph.char, n )
    end
    if not no_iw_kern and has_prev_glyph and has_next_glyph and prev_glyph.char and next_glyph.char and prev_glyph.font and next_glyph.font then
        local tfmdata = GET_FONT ( prev_glyph.font )
        if tfmdata and tfmdata.name then
            local font_id = GSUB ( SUB ( tfmdata.name, 1, FIND ( tfmdata.name, ":" ) - 1 ), "\"", "" )
            local second_tfmdata = GET_FONT ( next_glyph.font )
            if second_tfmdata and second_tfmdata.name then
                local second_font_id = GSUB ( SUB ( second_tfmdata.name, 1, FIND ( second_tfmdata.name, ":" ) - 1 ), "\"", "" )
                if font_id == second_font_id then
                    head = make_kern ( head, prev_glyph.font, prev_glyph.char, next_glyph.char, n )
                end
            end
        end
    end
    return head
end

local function make_short_spaces ( head )
    for n in T_GLYPH ( head ) do
        if n.char and n.char == 59 and ( not find_glyph ( n, PREV ) or find_glyph ( n, PREV ).char ~= 59 ) then
            if find_glyph ( n, NEXT, false, true ) then
                local next_glyph = n
                next_glyph = find_glyph ( n, NEXT, false, true )
                if next_glyph.char and next_glyph.char == 59 then
                    REM ( head, next_glyph )
                    local SIZE = 0
                    if n.font then
                        local tfmdata = GET_FONT ( n.font )
                        if tfmdata.size then
                            SIZE = tfmdata.size
                        end
                    end
                    INS_B ( head, n, NEW ( GLUE ) )
                    local glue_node = PREV ( n )
                    glue_node.subtype = SPACESKIP
                    glue_node.width = round ( SIZE * .16667, 0 )
                    glue_node.stretch = glue_node.width * 0.5
                    glue_node.shrink = glue_node.width * 0.33333
                    local has_next_glyph = false
                    if find_glyph ( n, NEXT, false, true ) then
                        next_glyph = find_glyph ( n, NEXT, false, true )
                        has_next_glyph = true
                    end
                    if has_next_glyph and next_glyph.char and next_glyph.char == 59 then
                        INS_B ( head, glue_node, NEW ( PENALTY ) )
                        PREV ( glue_node ).subtype = LBPENALTY
                        PREV ( glue_node ).penalty = 10000
                        REM ( head, next_glyph )
                    end
                    REM ( head, n )
                end
            end
        end
    end
end

local function make_glues_and_kerns ( head )
    for n in T ( head ) do
        if n.id == GLUE and n.subtype == SPACESKIP then
            head = make_kerns ( head, n )
        end
    end
    return head
end

ATC ( "ligaturing", make_short_spaces, "make short spaces", 1 )
ATC ( "pre_linebreak_filter", make_glues_and_kerns, "kern between words and against space preline", 1 )
ATC ( "hpack_filter", make_glues_and_kerns, "kern between words and against space hpack" )