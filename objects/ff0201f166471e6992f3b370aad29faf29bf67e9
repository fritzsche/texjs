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
local KERN = ID ( "kern" )
local WI = ID ( "whatsit" )
local HLIST = ID ( "hlist" )
local VLIST = ID ( "vlist" )

local PDF_LITERAL = table.swapped ( node.whatsits () )["pdf_literal"]

local NEW = node.new
local PREV = node.prev
local NEXT = node.next
local TAIL = node.tail
local INS_B = node.insert_before
local INS_A = node.insert_after
local HAS_GLYPH = node.has_glyph
local T = node.traverse
local T_ID = node.traverse_id

local FLOOR = math.floor
local ABS = math.abs

local ATC = luatexbase.add_to_callback

-----

local on_top = false
local DIR = PREV
local AB = INS_B
local f = 1

function showkerning_on_top ()
    on_top = true
    DIR = NEXT
    AB = INS_A
    f = - 1
end

local function round ( num, dec )
    return FLOOR ( num * 10^dec + 0.5 ) / 10^dec
end

local function calc_value ( value )
    value = round ( value / 65781, 3 )
    return value
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

local function find_glyph ( n, d )
    local kern_value = 0
    if d ( n ) then
        n = d ( n )
        while not ( n.id == GLYPH or n.replace and HAS_GLYPH ( n.replace ) ) do
            if not d ( n ) then return false end
            if n.id == GLUE then
                kern_value = kern_value + n.width
            end
            n = d ( n )
        end
    else
        return false
    end
    local return_value = n
    if n.id == DISC then
        return_value = find_first_last ( n.replace, GLYPH, d == PREV )
        for kern_node in T_ID ( KERN, n.replace ) do
            kern_value = kern_value + kern_node.kern
        end
    end
    return return_value, n, kern_value
end

local function check_glyph ( n, d, has_prev_next_glyph, prev_next_glyph, insert_prev_next )
    local kern_value
    if find_glyph ( n, d ) then
        prev_next_glyph, insert_prev_next, kern_value = find_glyph ( n, d )
        has_prev_next_glyph = true
    end
    return has_prev_next_glyph, prev_next_glyph, insert_prev_next, kern_value
end

local function get_x_value ( n, x_value )
    local exp_fac = 1
    if n.expansion_factor then
        exp_fac = n.expansion_factor / 1000000 + 1
    end
    if n.width then
        x_value = x_value + calc_value ( n.width ) * exp_fac
    elseif n.kern then
        x_value = x_value + calc_value ( n.kern ) * exp_fac
    end
    return x_value
end

local function find_kern ( n, d )
    local kern_value = 0
    local disc = false
    if d ( n ) then
        n = d ( n )
        while n and not ( n.id == GLYPH or disc ) do
            if n.id == KERN then
                kern_value = get_x_value ( n, kern_value )
            elseif n.replace then
                local start_point = n.replace
                if d == PREV then
                    start_point = TAIL ( n.replace )
                end
                if start_point.id == KERN then
                    kern_value = get_x_value ( start_point, kern_value )
                end
                disc = true
            end
            if d ( n ) then
                n = d ( n )
            else
                break
            end
        end
        if not ( kern_value == 0 ) then
            return kern_value
        end
    end
    return false
end

local function make_rule ( head, n, kern_node, current_head, disc_list )
    local color = "0 0 0"
    local has_prev_glyph = false
    local has_next_glyph = false
    local prev_glyph = n
    local next_glyph = n
    local insert_prev = n
    local insert_next = n
    local insert_point = n
    local x_value = 0
    local height = 0
    local depth = 0
    local prev_kern_value = 0
    local next_kern_value = 0
    local thickness = calc_value ( kern_node.kern )
    has_prev_glyph, prev_glyph, insert_prev, prev_kern_value = check_glyph ( n, PREV, has_prev_glyph, prev_glyph, insert_prev )
    has_next_glyph, next_glyph, insert_next, next_kern_value = check_glyph ( n, NEXT, has_next_glyph, next_glyph, insert_next )
    if disc_list and not ( TAIL ( current_head ) == kern_node ) and not ( current_head == kern_node ) then
        has_prev_glyph, prev_glyph, insert_prev, prev_kern_value = check_glyph ( kern_node, PREV, has_prev_glyph, kern_node, kern_node )
        has_next_glyph, next_glyph, insert_next, next_kern_value = check_glyph ( kern_node, NEXT, has_next_glyph, kern_node, kern_node )
    end
    if not on_top and has_prev_glyph then
        insert_point = insert_prev
        x_value = get_x_value ( prev_glyph, x_value )
        x_value = x_value + calc_value ( prev_kern_value )
        if disc_list and HAS_GLYPH ( current_head ) and TAIL ( current_head ) == kern_node then
            for some_node in T ( current_head ) do
                if some_node == TAIL ( current_head ) then break end
                x_value = get_x_value ( some_node, x_value )
            end
        end
    elseif on_top then
        insert_point = insert_next
        if has_next_glyph then
            x_value = get_x_value ( next_glyph, x_value )
            x_value = x_value + calc_value ( next_kern_value )
        end
        if disc_list and HAS_GLYPH ( current_head ) and current_head == kern_node then
            local kern_counter = 0
            for some_node in T ( current_head ) do
                if some_node.id == KERN then
                    kern_counter = kern_counter + 1
                end
                if not ( some_node == current_head ) then
                    x_value = get_x_value ( some_node, x_value )
                end
            end
            if find_kern ( n, NEXT ) then
                x_value = x_value + find_kern ( n, NEXT )
            end
        end
    end
    if disc_list and HAS_GLYPH ( current_head ) then
        if TAIL ( current_head ) == kern_node then
            has_prev_glyph = false
            has_prev_glyph, prev_glyph = check_glyph ( kern_node, PREV, has_prev_glyph, prev_glyph, insert_prev )
        end
        if current_head == kern_node then
            has_next_glyph = false
            has_next_glyph, next_glyph = check_glyph ( kern_node, NEXT, has_next_glyph, next_glyph, insert_next )
        end
    end
    if has_prev_glyph then
        height = calc_value ( prev_glyph.height )
        depth = calc_value ( prev_glyph.depth )
        if has_next_glyph then
            if next_glyph.height > prev_glyph.height then height = calc_value ( next_glyph.height ) end
            if next_glyph.depth > prev_glyph.depth then depth = calc_value ( next_glyph.depth ) end
        end
    elseif has_next_glyph then
        height = calc_value ( next_glyph.height )
        depth = calc_value ( next_glyph.depth )
    end
    if find_kern ( n, PREV ) then
        thickness = thickness + find_kern ( n, PREV )
    end
    if thickness ~= 0 and thickness > calc_value ( tex.hsize ) * - 1 then
        if thickness > 0 then
            color = "0 1 0"
        else
            color = "1 0 0"
        end
        if disc_list and not ( TAIL ( current_head ) == kern_node ) and not ( current_head == kern_node ) then
            current_head = AB ( current_head, insert_point, NEW ( WI, PDF_LITERAL ) )
        else
            head = AB ( head, insert_point, NEW ( WI, PDF_LITERAL ) )
        end
        x_value = ( x_value + calc_value ( kern_node.expansion_factor ) + thickness * 0.5 ) * f
        DIR ( insert_point ).mode = 0
        DIR ( insert_point ).data = "q " .. ABS ( thickness )  .. " w " .. x_value .. " " .. - depth  .. " m  " .. x_value .. " " .. height .. " l " .. color .. " RG S Q"
    end
    return head, current_head
end

local function show_kerns ( head )
    for n in T ( head ) do
        if n.id == HLIST or n.id == VLIST then
            n.head = show_kerns ( n.head )
        elseif n.id == KERN and not find_kern ( n, NEXT ) then
            head = make_rule ( head, n, n, head, false )
        elseif n.replace then
            local REPLACE = n.replace
            for kern_node in T_ID ( KERN, REPLACE ) do
                if not find_kern ( kern_node, NEXT ) then
                    head, REPLACE = make_rule ( head , n, kern_node, REPLACE, true )
                end
            end
            n.replace = REPLACE
        end
    end
    return head
end

ATC ( "post_linebreak_filter", show_kerns, "show kerns in postline" )
ATC ( "hpack_filter", show_kerns, "show kerns in hpack" )