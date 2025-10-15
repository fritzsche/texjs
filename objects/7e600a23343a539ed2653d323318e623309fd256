--[[
-- This module is part of the LuaHTTP package
-- The purpose of this module is to make HTTP requests and return the response.
--
-- Dependencies:
--  dkjson
--  luasec
--  ltn12
--  feedparser
]]

local moduleName = fetch
local M = {}

---------- Dependencies ------------------------
local http = require("socket.http")
local urlsocket = require("socket.url")
local https = require("ssl.https")
local dkjson = require("dkjson")
local ltn12 = require("ltn12")
local feedparser = require("feedparser")

---------- Local variables ---------------------

---------- Helper functions --------------------

--- Makes an HTTP request using the provided request parameter.
-- @param request table containing the request parameters
-- @return the response as a table
local function http_request(request)
    local url = request.url
    print("\nConnecting to " .. url)

    -- Detect HTTPS
    local client = http
    if url:lower():find("^https://") then
        client = https
    end

    -- Save optional body
    local body = request.body

    -- Prepare request
    local response = {}
    local request = {
        method = request.method or "GET",
        url = url,
        headers = request.headers or nil,
        redirect = request.redirect or false,
        sink = ltn12.sink.table(response)
    }

    -- Send optional body
    if body then
        if type(body) == "table" then
            body = dkjson.encode(body)
        end
        request.source = ltn12.source.string(body)
        request.headers["Content-Length"] = #body
    end

    -- Make the request
    local response_status, response_code, response_header, response_message = client.request(request)

    local message = response_message or "(No response message recieved)"

    if response_status == nil then
        error("\n!!! Error connecting to " .. url .. "\nResponse: " .. response_code .. "\nMessage: " .. message)
    end

    -- Check for redirects and return body
    if response_code == 301 or response_code == 302 or response_code == 303 then
        print("\nResponse " .. message)
        local redirect_url = response_header["location"]
        if redirect_url == url then
            error("\n!!! Error connecting to " .. url .. " results in a redirection loop")
        else
            print("\n!! Warning: redirecting to " .. redirect_url)
            request.url = redirect_url
            return http_request(request)
        end
    elseif response_code == 200 then
        print("\nResponse " .. message)
        if response == null or not next(response) then
            error("\n!!! Error empty response")
        end
        return response
    else
        error("\n!!! Error connecting to " .. url .. "\nResponse: " .. response_code .. "\nMessage: " .. message)
    end
end

--- Parse the given JSON-file.
-- @param file_path path to JSON-file
-- @return table containing the JSON data
local function parse_json_file(file_path)
    local file = io.open(file_path, "r")
    local content = file:read("*all")
    file:close()
    return dkjson.decode(content)
end

--- Split a given string on the first occurence of a given character.
-- @param str string containing the given character
-- @param char target character at which the string gets split
-- @return table containing the first part of the string as the key and the second part as the value
local function split_first(str, char)
    local result = {}
    local pos = str:find(char)
    local key = str:sub(1, pos - 1)
    local value = str:sub(pos + 1)
    result[key] = value
    return result
end

---------- Module functions --------------------

--- Make a GET request using the provided URL
-- @param url target URL
-- @return table containg the response
function M.json(url)
    local request = {
        method = "GET",
        url = url,
        headers = {
            ["Accept"] = "application/json"
        },
    }
    local response = http_request(request)
    return dkjson.decode(table.concat(response))
end

--- Make a request using the provided JSON-file
-- @param json_file_path path to JSON-file
-- @return table containg the response
function M.json_using_file(json_file_path)
    print("\nUsing file " .. json_file_path)
    local request = parse_json_file(json_file_path)
    local response = http_request(request)
    return dkjson.decode(table.concat(response))
end

--- Make a GET request using the provided URL
-- @param url target URL
-- @return table containg the response
function M.rss(url)
    local request = {
        method = "GET",
        url = url,
        headers = {
            ["Accept"] = "application/rss+xml"
        },
    }
    local response = http_request(request)
    return feedparser.parse(table.concat(response))
end

--- Fetch image data using the provided URL
-- @param url target URL leading to an image
-- @return image data
function M.image(url)
    local request = {
        method = "GET",
        url = url
    }
    local response = http_request(request)
    return table.concat(response)
end

--- Make a POST request using the provided URL and query parameters
-- @param url target URL
-- @param query_parameters parameters sent in the URL
-- @return table containg the response
function M.json_using_query(url, query_parameters)
    local url = url
    for _, value in ipairs(query_parameters) do
        local params = split_first(value, "=")
        for k, v in pairs(params) do
            v = string.gsub(v, "\n", "")
            url = url .. k .. "=" .. urlsocket.escape(v)
        end
    end

    print("\nURL: " .. url)

    local request = {
        method = "POST",
        url = url,
        headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/x-www-form-urlencoded";
        },
        redirect = false
    }
    local response = http_request(request)
    return dkjson.decode(table.concat(response))
end

return M
