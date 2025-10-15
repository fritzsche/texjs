DEBUG_FLAG = 0

CARTONAUGH_COLORS = {'red', 'green', 'yellow', 'cyan', 'blue', 'magenta'}
CARTONAUGH_DEFAULT_COLOR = 'cyan'

cartonaugh_env_settings = {}
used_cells = {}

-- Function that is used to either print to LaTeX or to the console
-- Used for debugging mode
function localPrint(str)
    if DEBUG_FLAG==1 then
        print(str)
    end
    tex.sprint(str)
end

-- Function that takes a string and splits it be delimiter, then returns it back
-- From https://stackoverflow.com/questions/19262761/lua-need-to-split-at-comma
function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value;  end);
    return elements
end

-- Function that converts a decimal number to binary
function decimalToBin(num, numb_bits, return_concat)
    if return_concat == nil then return_concat=true end
    num = tonumber(num)
    numb_bits = tonumber(numb_bits)
    local t={}
    for b=numb_bits,1,-1 do
        rest=math.floor(math.fmod(num,2))
        t[b]=rest
        num=(num-rest)/2
    end
    if return_concat == true then
        return table.concat(t)
    else
        return t
    end
end

-- Function that converts a decimal number to grey code
function decimalToGreyBin(num, numb_bits)
    -- Get the binary array
    num = num ~ (num >> 1)
    local t = decimalToBin(num, numb_bits, false)
    return table.concat(t)
end

function greyBinToDecimal(num)
--     num = tonumber(num,2)
    local mask = num
    while mask > 0 do
        mask = mask >> 1
        num = num ~ mask
    end
    return tonumber(num)
end

-- Function to pad a string by a amount with b string
function padString(str, pad_to, pad_with)
    local ret = str
    for l=1, (pad_to-string.len(str)) do
        ret = pad_with .. ret
    end
    return ret
end

function getColor(index)
    if index <= 0 then return CARTONAUGH_DEFAULT_COLOR end
    if CARTONAUGH_COLORS[index] ~= nil then
        return CARTONAUGH_COLORS[index]
    else
        return CARTONAUGH_DEFAULT_COLOR
    end
end

function customColor(color)
    -- Some high number so it's not in the CARTONAUGH_COLORS array
    cartonaugh_env_settings.color_index = 100
    CARTONAUGH_DEFAULT_COLOR = color
end

-- Function to generate a kmap template
function generateKMap(column, row, grid_numb)
    local outside_column_bits = 1
    local outside_row_bits = 1
    local outside_grid_numb_bits = 2
    local return_str = ''
    if row >= 4 then
        outside_row_bits = 2
    end
    if column >= 4 then
        outside_column_bits = 2
    end
    for c=1,column,1 do
        for r=1,row,1 do
            if r == 0 then
                if c == 0 then
                    -- Do Nothing...
                elseif c == (column+1) then
                    return_str = return_str .. ("\\phantom{" .. decimalToBin(0, outside_column_bits) .. "}")
                else
                    return_str = return_str .. (decimalToGreyBin(c-1, outside_column_bits))
                end
            elseif r==(row+1) then
                if c==0 then
                    return_str = return_str .. ("\\phantom{" .. decimalToBin(0, outside_column_bits) .. "}")
                end
            else
                if c == 0 then
                    return_str = return_str .. (decimalToGreyBin(r-1, outside_row_bits))
                elseif c == (column+1) then

                else
                    return_str = return_str ..("|(" .. padString((decimalToGreyBin(grid_numb, outside_grid_numb_bits) .. decimalToGreyBin(c-1, outside_column_bits) .. decimalToGreyBin(r-1, outside_row_bits)), 6, 0) ..  ")|" .. "\\phantom{0}")
                    --TODO: Look into why reversing c and r from where they should be makes it work
                end
            end

            if r == (row) then
                return_str = return_str .. ("\\\\")
            else
                return_str = return_str .. ("\\&")
            end
        end
    end
    return return_str
end

function init_cartonaught_env(numb_cols, numb_row, numb_submaps, is_bw, var12_str, var34_str, var56_str, is_submap_seperated)
    -- Change the default texts depending on the number of submaps if not custom name has been given
    -- TODO: Get this to actually work
    if var12_str == 'X_1X_0' and var34_str == 'X_3X_2' and var56_str == 'X_5X_4' then
        if numb_submaps == 1 then
            var56_str = 'X_3'
        end
        if numb_cols == 1 then
            var12_str = 'X_0'
        end
    end
    cartonaugh_env_settings = {
        cols = numb_cols,
        rows = numb_row,
        submaps = numb_submaps,
        bw = tonumber(is_bw),
        var_string = {
                v12 = var12_str,
                v34 = var34_str,
                v56 = var56_str,
        },
        color_index = 1,
        implicant_settings = {
            inner_sep = 0.35,
            outer_sep = 0.55,
        }
    }
    used_cells = {}

    if is_submap_seperated == 0 then
        is_submap_seperated = false
    else
        is_submap_seperated = true
    end

    draw_pgf_kmap(numb_cols, numb_row, numb_submaps, var12_str, var34_str, var56_str, is_submap_seperated)
end

function change_implicant_inner_spread(new_amount)
    cartonaugh_env_settings.implicant_settings.inner_sep = new_amount
end

function change_implicant_outer_spread(new_amount)
    cartonaugh_env_settings.implicant_settings.outer_sep = new_amount
end

-- Function to generate the k-maps
-- NOTE: Each variable/cell in the k-map is 1cm. This is so that everything alings with each other just be adding
-- the number of row and column. It's a bit of hack, but for now it will stay this way. Resizing of the matrix
-- will be done with the scale option in the future
function draw_pgf_kmap(column, row, submaps_n, var1, var2, var3, is_submap_seperated)
    submaps_n = submaps_n-1
    -- TODO: Transform the following settings variables into arguments
    local is_multitable_seperated = is_submap_seperated    -- Setting to determine if the graphs are drawn with a sperator line or distanced out
    local graph_seperator = 1.5                -- Seperation lenght between kmaps if is_multitable_seperated=false
    local kmaplevel_seperator_lenght = 0.1   -- Setting to determine the seperator line's thickness if is_multitable_seperated=true
    local line_width = 0.015                 -- Set the line thickness of things here
    local zero_var_line_lenght = 0.75         -- The lenght of the line at the top-left corner of the kmap where the implacants reside
    local column_header_numb_bits = ((column-1) // 2)+1
    local row_header_numb_bits = ((row-1) // 2)+1
    if is_multitable_seperated then graph_seperator = 0 end
    for d=0,submaps_n,1 do
        -- Find the top-left corner of each grid (seperated by 1 unit)
        local grid_x_loc = (d % 2)*(column+graph_seperator)
        local grid_y_loc = -(d // 2)*(row+graph_seperator)
    --         localPrint(string.format("\\node[above] at (%f,%f) {\\small{%s}};", 0, 0, abimplecant))
        if is_multitable_seperated then
            if (d % 2) == 1 then
                local add_heigh = 0
                if d >= 2 then add_heigh = kmaplevel_seperator_lenght end
                localPrint(string.format("\\fill[black] (%f,%f) rectangle (%f,%f);", grid_x_loc, grid_y_loc, grid_x_loc+kmaplevel_seperator_lenght, grid_y_loc-row-line_width-add_heigh))
                grid_x_loc = grid_x_loc + kmaplevel_seperator_lenght
            end
            if d >= 2 then
                localPrint(string.format("\\fill[black] (%f,%f) rectangle (%f,%f);", grid_x_loc, grid_y_loc, grid_x_loc+column+line_width, grid_y_loc-kmaplevel_seperator_lenght))
                grid_y_loc = grid_y_loc - kmaplevel_seperator_lenght
            end
        end
        -- Print out the top-left line corner with the variables
        if (is_multitable_seperated == false) or (d==0) then
            localPrint(string.format("\\draw[inner sep=0pt, outer sep=0pt] (%f, %f) -- (%f, %f);", grid_x_loc+line_width, grid_y_loc-line_width, grid_x_loc-zero_var_line_lenght, grid_y_loc+zero_var_line_lenght))
            localPrint(string.format("\\node[left] at (%f,%f) {\\small{%s}};", grid_x_loc-0.3, grid_y_loc+0.3, var2))
            localPrint(string.format("\\node[right] at (%f,%f) {\\small{%s}};", grid_x_loc-0.6, grid_y_loc+0.6, var1))
        end
        -- Print out the top boolean column header
        if (is_multitable_seperated == false) or (d < 2) then
            localPrint(string.format("\\matrix[matrix of nodes, ampersand replacement=\\&, column sep={1cm,between origins}, nodes={align=center,text width=1cm,inner sep=0pt}, anchor=south west, inner sep=0pt, outer sep=0pt] at (%f, %f) {",grid_x_loc,grid_y_loc+0.05))
            for c=0, column-1, 1 do
                localPrint(string.format("%s", decimalToGreyBin(c, column_header_numb_bits)))
                if c ~= (column-1) then localPrint("\\&") end
            end
            localPrint("\\\\};")
        end
        -- Print out the side boolean row header
        if (is_multitable_seperated == false) or (d%2 == 0) then
            localPrint(string.format("\\matrix[matrix of nodes, ampersand replacement=\\&, row sep={1cm,between origins}, nodes={minimum height=1cm,inner sep=0pt, text height=2ex, text depth=0.5ex}, anchor=north east, inner sep=0pt, outer sep=0pt] at (%f, %f) {",grid_x_loc-0.05,grid_y_loc))
            for r=0, row-1, 1 do
                localPrint(string.format("%s \\\\", decimalToGreyBin(r, row_header_numb_bits)))
            end
            localPrint("};")
        end
        -- Print out the matrix
        localPrint(string.format("\\matrix[matrix of nodes, ampersand replacement=\\&, column sep={1cm,between origins}, row sep={1cm,between origins}, nodes={rectangle,draw,minimum height=1cm,align=center,text width=1cm,inner sep=0pt, text height=2ex, text depth=0.5ex, line width=0.015cm}, anchor=north west, inner sep=0pt, outer sep=0pt] at (%f, %f) {%s};",
                                    grid_x_loc, grid_y_loc, generateKMap(row, column, d)
                                    ))
        -- Print out the buttom text saying which matrix is which
        if (submaps_n > 0) then
            if (is_multitable_seperated == false) then
                localPrint(string.format("\\node[below] at (%f, %f) {%s = %s};", grid_x_loc+(column//2),grid_y_loc-row,var3, decimalToBin(d, 2)))
            elseif (is_multitable_seperated == true) then
                if (d < 2) then
                    localPrint(string.format("\\node[] at (%f, %f) {%s = %s};", grid_x_loc+(column//2), grid_y_loc+1, var3, decimalToBin(d, 2)))
                end
                if (d % 2 == 0) and (submaps_n > 2) then
                    localPrint(string.format("\\node[rotate=90] at (%f, %f) {%s = %s};", grid_x_loc-1, grid_y_loc-(row//2), var3, decimalToBin(d, 2)))
                end
            end
        end
    end
end

-- Function for drawing an implicant manually (meaning to give the start and endpoint, as well as optional
-- submaps for different ones)
function manual_draw_implicant(st, en, submaps_str)
    local color_index = cartonaugh_env_settings.color_index
    local max_submaps = cartonaugh_env_settings.submaps
    local inner_spread = cartonaugh_env_settings.implicant_settings.inner_sep
    st = tonumber(st)
    en = tonumber(en)
    local submap_arr = split(submaps_str, ',')
    --     Check if the implacent selection
    for s=1,table.getn(submap_arr),1 do
        current_submap = tonumber(submap_arr[s])
        if current_submap < max_submaps then
            local draw_str = string.format("($(%s.center)+(-%s,%s)$) rectangle ($(%s.center)+(%s,-%s)$)", decimalToGreyBin(current_submap, 2) .. decimalToBin(st,4), inner_spread, inner_spread, decimalToGreyBin(current_submap, 2) .. decimalToBin(en,4), inner_spread, inner_spread)
            if cartonaugh_env_settings.bw == 0 then
                localPrint(string.format("\\fill[rounded corners=3pt,fill=%s,fill opacity=0.25,] {%s};", getColor(color_index) , draw_str))
            end
            localPrint(string.format("\\draw[rounded corners=3pt,draw opacity=1.0,] {%s};", draw_str))
        else
            localPrint(string.format("\\PackageWarning{cartonaugh}{You can only draw on existing sub maps. Ignoring instruction to draw on non existing sub map number %d}", s))
        end
    end
    cartonaugh_env_settings.color_index = cartonaugh_env_settings.color_index+1
end

-- Handler function for drawing edge implacants, figuring out orientation as well
function manual_draw_edge_implicant(corner1, corner2, corner3, corner4, submaps_str)
    corner1 = tonumber(corner1)
    corner2 = tonumber(corner2)
    corner3 = tonumber(corner3)
    corner4 = tonumber(corner4)

    if corner1-corner2 > corner1-corner3 then
        manual_draw_edge_implicant_orientation(corner1, corner2, submaps_str, 'n')
        manual_draw_edge_implicant_orientation(corner3, corner4, submaps_str, 's')
    else
        manual_draw_edge_implicant_orientation(corner1, corner2, submaps_str, 'w')
        manual_draw_edge_implicant_orientation(corner3, corner4, submaps_str, 'e')
    end

    cartonaugh_env_settings.color_index = cartonaugh_env_settings.color_index+1

end

-- Function to draw out a 1 edge implacant given 2 corners, the submaps, and the orientation (n, s, e, or w)
-- TODO: Perhaps find a way to repeat the code between n/s and e/w
-- TODO: For the mirror variable, have that apply to the lua var directly instead of having LaTeX handle it
-- TODO: Maybe add option for squigly lines for the end instead of nothing
-- TODO: Open up the internal inner_spread and outer_spead settings to the user
function manual_draw_edge_implicant_orientation(corner1, corner2, submaps_str, orientation)
    local color_index = cartonaugh_env_settings.color_index
    local max_submaps = cartonaugh_env_settings.submaps
    corner1 = tonumber(corner1)
    corner2 = tonumber(corner2)
    local submap_arr = split(submaps_str, ',')
    local inner_spread = cartonaugh_env_settings.implicant_settings.inner_sep
    local outer_spead = cartonaugh_env_settings.implicant_settings.outer_sep
    --     Check if the implacent selection
    for s=1,table.getn(submap_arr),1 do
        current_submap = tonumber(submap_arr[s])
        if current_submap < max_submaps then
            local draw_string = ""
            local mirror = 1
            local corner1_bin = decimalToGreyBin(current_submap, 2) .. decimalToBin(corner1,4)
            local corner2_bin = decimalToGreyBin(current_submap, 2) .. decimalToBin(corner2,4)
            if orientation == 'n' or orientation == 's' then
                -- If the orientation is south, just mirror it
                if orientation == 's' then mirror = -1 end
                draw_string = string.format("($(%s.center)+(-%f,%f*%s)$)", corner1_bin, inner_spread, outer_spead, mirror)
                draw_string = draw_string .. string.format("{[rounded corners=3pt] -- ($(%s.center)+(-%f,-%f*%s)$)}", corner1_bin, inner_spread, inner_spread, mirror)
                draw_string = draw_string .. string.format("{[rounded corners=3pt] -- ($(%s.center)+(%f,-%f*%s)$)}", corner2_bin, inner_spread, inner_spread, mirror)
                draw_string = draw_string .. string.format("-- ($(%s.center)+(%f,%f*%s)$)", corner2_bin, inner_spread, outer_spead, mirror)
            else
                if orientation == 'e' then mirror = -1 end
                draw_string = string.format("($(%s.center)+(-%f*%s,%f)$)", corner1_bin, outer_spead, mirror, inner_spread)
                draw_string = draw_string .. string.format("{[rounded corners=3pt] -- ($(%s.center)+(%f*%s,%f)$)}", corner1_bin, inner_spread, mirror, inner_spread)
                draw_string = draw_string .. string.format("{[rounded corners=3pt] -- ($(%s.center)+(%f*%s,-%f)$)}", corner2_bin, inner_spread, mirror, inner_spread)
                draw_string = draw_string .. string.format("-- ($(%s.center)+(-%f*%s,-%f)$)", corner2_bin, outer_spead, mirror, inner_spread)
            end
            if cartonaugh_env_settings.bw == 0 then
                localPrint(string.format("\\fill[fill=%s,fill opacity=0.25,] {%s};", getColor(color_index), draw_string))
            end
            localPrint(string.format("\\draw[draw opacity=1.0] {%s};", draw_string))
        else
            localPrint(string.format("\\PackageWarning{cartonaugh}{You can only draw on existing sub maps. Ignoring instruction to draw on non existing sub map number %d}", s))
        end
    end
end

-- Function to draw the corner implicants. Only usable on 4x4 matrices
function manual_draw_corner_implicant(submaps_str)
    local corner_arr = {0, 2, 8, 10}
    local submap_arr = split(submaps_str, ',')
    local max_submaps = cartonaugh_env_settings.submaps
    local color = cartonaugh_env_settings.color_index
    local inner_spread = cartonaugh_env_settings.implicant_settings.inner_sep
    local outer_spread = cartonaugh_env_settings.implicant_settings.outer_sep

    if cartonaugh_env_settings.cols ~= 4 or cartonaugh_env_settings.rows ~= 4 then
        localPrint("\\PackageError{cartonaugh}{Cannot use a corner implicant on anything but a 4x4. Sorry!}")
        return
    end

    for s=1,table.getn(submap_arr),1 do
        current_submap = tonumber(submap_arr[s])
        if current_submap < max_submaps then
            for c=0,3,1 do
                local x_mirror = 1-(2*(c%2))
                local y_mirror = 1-(2*(c//2))
                local corner = decimalToGreyBin(current_submap, 2) .. decimalToBin(corner_arr[c+1],4)
                -- Create the string to draw the corners
                local draw_string = string.format("($(%s.center)+(-%f*%d,%f*%d)$)--($(%s.center)+(%f*%d,%f*%d)$)", corner, outer_spread, x_mirror, outer_spread, y_mirror, corner, inner_spread, x_mirror, outer_spread, y_mirror)
                draw_string = draw_string .. string.format("{ [rounded corners=3pt] --($(%s.center)+(%f*%d,-%f*%d)$) }", corner, inner_spread, x_mirror, inner_spread, y_mirror)
                draw_string = draw_string .. string.format("--($(%s.center)+(-%f*%d,-%f*%d)$) -- cycle", corner, outer_spread, x_mirror, inner_spread, y_mirror)
                if cartonaugh_env_settings.bw == 0 then
                    localPrint(string.format("\\fill[fill=%s,fill opacity=0.25,] {%s};", getColor(color), draw_string))
                end
                localPrint(string.format("\\draw[sharp corners, draw opacity=1.0] {%s};", draw_string))
            end
        else
            localPrint(string.format("\\PackageWarning{cartonaugh}{You can only draw on existing sub maps. Ignoring instruction to draw on non existing sub map number %d}", s))
        end
    end

    cartonaugh_env_settings.color_index = cartonaugh_env_settings.color_index+1

end

-- WORK IN PROGRESS/LONG TERM FUNCTION
-- Goals is to eventually give \implicant{1}{x}{0}{x} for example and have it draw it out for you.
-- May give up on this in favor of other things...don't know
function draw_implicant(var_list)
--     local var_list_arr = split(var_list, ',')
    local color_index = cartonaugh_env_settings.color_index
    local max_submaps = cartonaugh_env_settings.submaps
    localPrint("\\PackageWarning{cartonaugh}{This is a UNSTABLE and WIP function. Procede on your own}")

    -- Check argument for submaps greater than 1
    -- TODO: before returning print out a package error
    if max_submaps > 1 then
        for s=0,max_submaps-1,1 do
            if var_list[5+s] == '' then
                -- TODO: Fix this
                localPrint(string.format("\\PackageError{cartonaugh}{Please feed either 1, 0, or x for sub map number %d's variable boolean}", s+1))
                return
            end
        end
    end

    local low_limit = 0
    local high_limit = 0

    for b=1,4,1 do
        if var_list[b] == 'x' then
            print('a',high_limit, greyBinToDecimal(high_limit), decimalToBin(greyBinToDecimal(high_limit), 4))
            print('b',high_limit | (1 << (b-1)), greyBinToDecimal(high_limit | (1 << (b-1))), decimalToBin(greyBinToDecimal(high_limit | (1 << (b-1))), 4))
            if greyBinToDecimal(high_limit) < greyBinToDecimal(high_limit | (1 << (b-1))) then
                high_limit = high_limit | (1 << (b-1))
                print(decimalToBin(greyBinToDecimal(high_limit),4), decimalToBin(greyBinToDecimal(high_limit & ~(1 << (b-2))),4))
                if greyBinToDecimal(high_limit) < greyBinToDecimal(high_limit & ~(1 << (b-2))) then
                    high_limit = high_limit & ~(1 << (b-2))
                end
            end
        elseif var_list[b] == '1' then
            high_limit = high_limit | (1 << (b-1))
            low_limit = low_limit | (1 << (b-1))
        end
        print('low_limit=', low_limit, 'high_limit=', high_limit)
    end

    local st = decimalToBin(low_limit,4)
    local en = decimalToBin(high_limit,4)

    print('low_limit', greyBinToDecimal(low_limit), 'high_limit', greyBinToDecimal(high_limit), 'st=', st, 'en=', en)

    for s=1,1,1 do
        current_submap = 0
        if current_submap < max_submaps then
            if cartonaugh_env_settings.bw == 0 then
                localPrint(string.format("\\fill[rounded corners=3pt,fill=%s,fill opacity=0.25,] {($(%s.center)+(-0.3,0.3)$) rectangle ($(%s.center)+(0.3,-0.3)$)};", getColor(color_index) , decimalToGreyBin(current_submap, 2) .. st, decimalToGreyBin(current_submap, 2) .. en))
                color_index = color_index+1
            end
            localPrint(string.format("\\draw[rounded corners=3pt,draw opacity=1.0,] {($(%s.center)+(-0.3,0.3)$)rectangle($(%s.center)+(0.3,-0.3)$)};", decimalToGreyBin(current_submap, 2) .. st, decimalToGreyBin(current_submap, 2) .. en))
        else
            localPrint(string.format("\\PackageWarning{cartonaugh}{You can only draw on existing sub maps. Ignoring instruction to draw on non existing sub map number %d}", s))
        end
    end
    cartonaugh_env_settings.color_index = color_index
end

function autoterms(what_to_write)
   local max_cells = cartonaugh_env_settings.submaps * cartonaugh_env_settings.cols * cartonaugh_env_settings.rows
   for cell=0,max_cells-1,1 do
       if used_cells[cell] == nil then
           used_cells[cell] = true
           localPrint(string.format("\\path (%s) node {%s};", decimalToBin(cell, 6), what_to_write))
       end
   end
end

function manualterms(what_to_write)
    local what_to_write_arr = split(what_to_write, ',')
    for cell=0,table.getn(what_to_write_arr)-1,1 do
        if used_cells[cell] == nil then
            used_cells[cell] = true
            localPrint(string.format("\\path (%s) node {%s};", decimalToBin(cell, 6), what_to_write_arr[cell+1]))
        end
    end
end

function write_to_cell(cells, what_to_write)
    local cells_arr = split(cells, ',')
    for c=1,table.getn(cells_arr),1 do
        local cell = tonumber(cells_arr[c])
        if used_cells[cell] == nil then
            used_cells[cell] = true
            localPrint(string.format("\\path (%s) node {%s};", decimalToBin(cell, 6), what_to_write))
        end
    end
end
