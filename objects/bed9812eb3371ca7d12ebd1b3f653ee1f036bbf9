--[[
-- This module is part of the LuaHTTP package
-- The purpose of this module is to correctly display the data reveived from the fetch module.
]]

local moduleName = display
local M = {}

---------- Dependencies ------------------------
local fetch = require("luahttp-fetch")

---------- Local variables ---------------------
local tmp_image_counter = 0 -- Counter for image names

---------- Helper functions --------------------

--- Displays an image using LuaTeX img.write function.
-- The image has to be saved first in order to be written to the PDF-Document using LuaTeX.
-- @param data image data
-- @param width optional width in cm
-- @param height optional height in cm
-- @see search_and_escape
local function display_image(data, width, height)
    local tmp_image_name = '/tmp/tmp_image' -- filename of image saved temporarly
    tmp_image_name = tmp_image_name .. tmp_image_counter

    local width = width or nil
    local height = height or nil
    local f = assert(io.open(tmp_image_name, 'wb'))
    f:write(data)
    f:close()

    -- LuaTeX does not provide built-in image scaling functions
    local image = img.new({filename = tmp_image_name, width = width, height = height})
    if image then
        img.write(image)
        tmp_image_counter = tmp_image_counter + 1
    end
end

--- Prompts the user to display an image.
-- If an image-URL is detected the user is asked to display the image or the plain URL.
-- @see is_image_url
local function prompt_user()
    while true do
        print("Do you want to display the image? (y/n)")
        local answer = io.read()

        if answer == 'y' then
            return true
        elseif answer == 'n' then
            return false
        else
            print("Invalid answer. Please enter 'y' or 'n'.")
        end
    end
end

--- Searches the given URL for image extensions.
-- @param url some URL
-- @return true if an image extension was found, false otherwise
-- @see search_and_escape
local function is_image_url(url)
    local image_extensions = { "jpg", "jpeg", "png", "gif" }
    for _, ext in ipairs(image_extensions) do
        if string.match(url, "%." .. ext) then
            return true
        end
    end
    return false
end

--- Searches the given value for special characters that cause problems in LaTeX-Documents.
-- @param value single value of a table
-- @return if no special characters where found the value is retured unchanged,
-- if special characters where found the escaped value is returned,
-- if an image-URL is detected and the user chooses to display that image nil is returned
-- @see is_image_url, prompt_user
local function search_and_escape(value)
    local value = tostring(value)
    if string.find(value, "^http") then
        if is_image_url(value) then
            print("\nLooks like this URL leads to an image: " .. value)
            if prompt_user() then
                local body = fetch.image(value)
                display_image(body, "5cm")
                return nil
            else
                print("\nEscaping URL: " .. value)
                value = [[\url{]] .. value .. [[}]]
            end
        else
            print("\nEscaping URL: " .. value)
            value = [[\url{]] .. value .. [[}]]
        end
    else
        local latex_special_chars = '([%%$%{%}&%#_%^%~])'
        value = value:gsub(latex_special_chars, "\\%1")
    end
    return value
end

--- Prints a table to stdout.
-- @param t tagle to print
-- @param indent optional string used for indents
local function print_table(t, indent)
    indent = indent or ""
    for k, v in pairs(t) do
        if type(v) == "table" then
            print(indent .. k .. ":")
            print_table(v, indent .. "  ")
        else
            print(indent .. k .. ": " .. tostring(v))
        end
    end
end

--- Converts a table to text which can be written to the PDF-Document
-- The values of the table are first searched for special characters.
-- @param tbl table to be converted
-- @return text
-- @see search_and_escape
local function table_to_text(tbl)
    local results = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            table.insert(results, table_to_text(v))
        else
            v = search_and_escape(v)
            if v then
                table.insert(results, v .. " \\\\ ")
            end
        end
    end
    return table.concat(results, " \\ ")
end

--- Check if a table contains a certain value.
-- @param table input table
-- @param target_value value to be searched
-- @return true if value was found, false otherwise
local function table_contains(table, target_value)
    for _, value in pairs(table) do
        if type(value) == "table" then
            table_contains(value, target_value)
        elseif value == target_value then
            return true
        end
    end
    return false
end

--- Filter out table entries that are not in the provided target keys.
-- @param input_table
-- @param target_keys array of target keys
-- @param results used for recursion
-- @return return a new table containing only the target keys and their values
local function filter_table(input_table, target_keys, results)
    local results = results or {}

    for _, target_key in ipairs(target_keys) do
        for key, value in pairs(input_table) do
            if type(value) == "table" then
                filter_table(value, target_keys, results)
            elseif tostring(key) == target_key then
                if not table_contains(results, value) then
                    table.insert(results, value)
                    break
                end
            end
        end
    end
    return results
end

--- Converts a string containing a comma seperated list of elements to an array (ipairs).
-- @param str input string
-- @return table containing the elements as values
local function string_to_ipairs(str)
    local t = {}
    for value in string.gmatch(str, "([^,]+)") do
        table.insert(t, value)
    end
    return t
end

---------- Module functions --------------------

--- Reads the contents of a JSON-file, filters the response and prints the result to the PDF-Document.
-- @param json_file_path path to the JSON-file
-- @param keys optional keys to filter out the relevant values from the response
function M.json_using_file(json_file_path, keys)
    local data = fetch.json_using_file(json_file_path)
    print_table(data)
    if keys then
        local keys = string_to_ipairs(tostring(keys))
        local values = filter_table(data, keys)
        tex.sprint(table_to_text(values))
    else
        tex.sprint(table_to_text(data))
    end
end

--- Prints the response filtered by the keys to the PDF-Document.
-- @param url URL of the API
-- @param keys optional keys to filter out the relevant values from the response
function M.json(url, keys)
    local data = fetch.json(tostring(url))
    print_table(data)
    if keys then
        local keys = string_to_ipairs(tostring(keys))
        local values = filter_table(data, keys)
        tex.sprint(table_to_text(values))
    else
        tex.sprint(table_to_text(data))
    end
end

--- Print an image to the PDF-Document.
-- @param url URL of the image
-- @param width optional width in cm
-- @param height optional height in cm
function M.image(url, width, height)
    local data = fetch.image(tostring(url))
    display_image(data, width, height)
end

--- Print values from an rss-feed to the PDF-Document.
-- @param url URL of the feed
-- @param limit limits the amount of entries that get printed to the PDF-Document
-- @param feed_info_keys keys used to filter the feed information
-- @param entry_keys keys used to filter the feed entries
function M.rss(url, limit, feed_info_keys, entry_keys)
    local data = fetch.rss(tostring(url))

    if feed_info_keys then
        local feed_info_keys = string_to_ipairs(tostring(feed_info_keys))
        local feed = data.feed
        local feed_info_filtered = filter_table(feed, feed_info_keys)

        tex.sprint(table_to_text(feed_info_filtered))
    end

    local entries = {}

    for i = 1, limit do
        if data.entries[i] then
            table.insert(entries, data.entries[i])
        end
    end

    if entry_keys then
        local entry_keys = string_to_ipairs(tostring(entry_keys))
        local entries_filtered = filter_table(entries, entry_keys)

        print_table(entries_filtered)
        tex.sprint(table_to_text(entries_filtered))
    else
        tex.sprint(table_to_text(entries))
    end
end

--- Print the reponse from a request using query parameters to the PDF-Document.
-- @param url URL of the API
-- @param keys keys to filter out the relevant values
-- @param ... multiple optional query parameters used in the request
function M.json_using_query(url, keys, ...)
    local query_parameters = { ... }
    local data = fetch.json_using_query(url, query_parameters)

    print_table(data)

    local keys = string_to_ipairs(tostring(keys))
    local values = filter_table(data, keys)
    tex.sprint(table_to_text(values))
end

return M
