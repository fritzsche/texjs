-- lparse.lua
-- Copyright 2023-2025 Josef Friedrich
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3c
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   http://www.latex-project.org/lppl.txt
-- and version 1.3c or later is part of all distributions of LaTeX
-- version 2008/05/04 or later.
--
-- This work has the LPPL maintenance status `maintained'.
--
-- The Current Maintainer of this work is Josef Friedrich.
--
-- This work consists of the files lparse.lua, lparse.tex,
-- and lparse.sty.
---
if lpeg == nil then
  lpeg = require('lpeg')
end

---
---@param spec string An argument specifier, for example `o m`
---
---Required arguments:
---
---* `m`: A standard mandatory argument, which can either be a single
---  token alone or multiple tokens surrounded by curly braces `{}`.
---  Regardless of the input, the argument will be passed to the
---  internal code without the outer braces. This is the `lparse`
---  type specifier for a normal TeX argument.
---* `r`: Given as `r` `token1` `token2`, this denotes a
---  required delimited argument, where the delimiters are
---  `token1` and `token2`. If the opening delimiter
---  `token1` is missing, `nil` will be
---  returned after a suitable error.
---* `R` Given as `R` `token1` `token2` `default`,
---  this is a required delimited argument as for `r`,
---  but it has a user-definable recovery `default` instead of
---  `nil`.
---* `v`: Reads an argument `verbatim`, between the following
---   character and its next occurrence.
---
---Optional arguments:
---
---* `o`: A standard LaTeX optional argument, surrounded with square
---  brackets, which will supply
---  `nil` if not given (as described later).
---* `d`: Given as `d` `token1` `token2`, an optional
---  argument which is delimited by `token1` and `token1`.
---  As with  `o`, if no
---  value is given `nil` is returned.
---* `O`: Given as `O{default}`, is like `o`, but
---  returns `default` if no value is given.
---* `D`: Given as `D` `token1` `token2` `{default}`,
---  it is as for `d`, but returns `default` if no value is given.
---  Internally, the `o`, `d` and `O` types are
---  short-cuts to an appropriated-constructed `D` type argument.
---* `s`: An optional star, which will result in a value
---  `true` if a star is present and `false`
---  otherwise (as described later).
---* `t`: An optional `token`, which will result in a value
---  `true` if `token` is present and `false`
---  otherwise. Given as `t` `token`.
---
---@return Argument[]
local function parse_spec(spec)
  local V = lpeg.V
  local P = lpeg.P
  local Set = lpeg.S
  local Range = lpeg.R
  local CaptureFolding = lpeg.Cf
  local CaptureTable = lpeg.Ct
  local Cc = lpeg.Cc
  local CaptureSimple = lpeg.C

  local function add_result(result, value)
    if not result then
      result = {}
    end
    table.insert(result, value)
    return result
  end

  local function collect_delims(a, b)
    return { init_delim = a, end_delim = b }
  end

  local function collect_token(a)
    return { token = a }
  end

  local function set_default(a)
    return { default = a }
  end

  local function combine(...)
    local args = { ... }

    local output = {}

    for _, arg in ipairs(args) do
      if type(arg) ~= 'table' then
        arg = {}
      end

      for key, value in pairs(arg) do
        output[key] = value
      end

    end

    return output
  end

  local function ArgumentType(letter)
    local function get_type(l)
      return { argument_type = l }
    end
    return CaptureSimple(P(letter)) / get_type
  end

  local T = ArgumentType

  local pattern = P({
    'init',
    init = V('whitespace') ^ 0 *
      CaptureFolding(CaptureTable('') * V('list'), add_result),

    list = (V('arg') * V('whitespace') ^ 1) ^ 0 * V('arg') ^ -1,

    arg = V('m') + V('r') + V('R') + V('v') + V('o') + V('d') + V('O') +
      V('D') + V('s') + V('t'),

    m = T('m') / combine,

    r = T('r') * V('delimiters') / combine,

    R = T('R') * V('delimiters') * V('default') / combine,

    v = T('v') * Cc({ verbatim = true }) / combine,

    o = T('o') * Cc({ optional = true }) / combine,

    d = T('d') * V('delimiters') * Cc({ optional = true }) / combine,

    O = T('O') * V('default') * Cc({ optional = true }) / combine,

    D = T('D') * V('delimiters') * V('default') *
      Cc({ optional = true }) / combine,

    s = T('s') * Cc({ star = true }) / combine,

    t = T('t') * V('token') / combine,

    token = V('delimiter') / collect_token,

    delimiter = CaptureSimple(Range('!~')),

    delimiters = V('delimiter') * V('delimiter') / collect_delims,

    whitespace = Set(' \t\n\r'),

    default = P('{') * CaptureSimple((1 - P('}')) ^ 0) * P('}') /
      set_default,
  })

  return pattern:match(spec)

end

---
---@param t Token
local function debug_token(t)
  print(t)
  print('command', t.command)
  print('cmdname', t.cmdname)
  print('csname', t.csname)
  print('id', t.id)
  print('tok', t.tok)
  print('active', t.active)
  print('expandable', t.expandable)
  print('protected', t.protected)
  print('mode', t.mode)
  print('index', t.index)
end

---
---Scan for an optional delimited argument.
---
---@param init_delim? string # The character that marks the beginning of an optional argument (by default `[`).
---@param end_delim? string # The character that marks the end of an optional argument (by default `]`).
---
---@return string|nil # The string that was enclosed by the delimiters. The delimiters themselves are not returned.
local function scan_oarg(init_delim, end_delim)
  if init_delim == nil then
    init_delim = '['
  end
  if end_delim == nil then
    end_delim = ']'
  end

  ---
  ---Convert a token object to a string. If the token is a control sequence
  ---it is converted to `\\csname`.
  ---
  ---@param t Token The token object.
  ---
  ---@return string token_string A string representing the token.
  local function convert_token_to_string(t)
    if t.csname ~= nil then
      return '\\' .. t.csname
    else
      return utf8.char(t.index)
    end
  end

  local delimiter_stack = 0

  local function get_next_char()
    local t = token.get_next()
    local char = convert_token_to_string(t)
    if char == init_delim then
      delimiter_stack = delimiter_stack + 1
    end

    if char == end_delim then
      delimiter_stack = delimiter_stack - 1
    end
    return char, t
  end

  local char, t = get_next_char()

  if t.cmdname == 'spacer' then
    char, t = get_next_char()
  end

  if char == init_delim then
    local output = {}

    char, t = get_next_char()

    -- “while” better than “repeat ... until”: The end_delimiter is
    -- included in the result output.
    while not (char == end_delim and delimiter_stack == 0) do
      table.insert(output, char)
      char, t = get_next_char()
    end
    return table.concat(output, '')
  else
    token.put_next(t)
  end
end

---
---Represents an argument of a command.
---
---The basic form of the argument specifier is a list of letters, where
---each letter defines a `Argument`.
---
---## `m`:
---
---```lua
---{ argument_type = 'm' }
---```
---
---## `r`:
---
---```lua
---{ argument_type = 'r', end_delim = '>', init_delim = '<' }
---```
---
---## `R`:
---
---(`R<>{default}`)
---
---```lua
---{
---  argument_type = 'R',
---  end_delim = '>',
---  init_delim = '<',
---  default = 'default',
---}
---```
---
---## `v`:
---
---```lua
---{
---  argument_type = 'v',
---  verbatim = true,
---}
---```
---
---## `o`:
---
---```lua
---{ argument_type = 'o', optional = true }
---```
---
---## `d`:
---
---(`d<>`)
---
---```lua
---{
---  argument_type = 'd',
---  optional = true,
---  end_delim = '>',
---  init_delim = '<',
---}
---```
---
---## `O`:
---
---(`O{default}`)
---
---```lua
---{ argument_type = 'O', optional = true, default = 'default' }
---```
---
---## `D`:
---
---(`D<>{default}`)
---
---```lua
---{
---  argument_type = 'D',
---  optional = true,
---  default = ' default ',
---  end_delim = '>',
---  init_delim = '<',
---}
---```
---
---
---## `s`:
---
---```lua
---{ argument_type = 's', star = true }
---```
---
---
---## `t`:
---
---```lua
---{ argument_type = 't', token = '+' }
---```
---
---@class Argument
---@field argument_type? 'm' | 'r' | 'R' | 'v' | 'o' | 'd' | 'O' | 'D' | 's' | 't' A single letter representing the argument type in the list of letters.
---@field optional? boolean Indicates whether the argument is optional.
---@field init_delim? string The character that marks the beginning of an argument.
---@field end_delim? string The character that marks the end of an argument.
---@field star? boolean `true` if it is a star argument type (`s`).
---@field default? string The default value if no value is given.
---@field verbatim? boolean `true` if it is a verbatim argument type (`v`).
---@field token? string The optional token for the argument type `t`.

---A parser that parses the argument specification (list of letters).
---@class Scanner
---@field spec string An argument specifier
---@field args Argument[]
---@field result any[]
local Scanner = {}
---@private
Scanner.__index = Scanner

---
---@param spec string An argument specifier, for example `o m`
---
---Required arguments:
---
---* `m`: A standard mandatory argument, which can either be a single
---  token alone or multiple tokens surrounded by curly braces `{}`.
---  Regardless of the input, the argument will be passed to the
---  internal code without the outer braces. This is the `lparse`
---  type specifier for a normal TeX argument.
---* `r`: Given as `r` `token1` `token2`, this denotes a
---  required delimited argument, where the delimiters are
---  `token1` and `token2`. If the opening delimiter
---  `token1` is missing, `nil` will be
---  returned after a suitable error.
---* `R` Given as `R` `token1` `token2` `default`,
---  this is a required delimited argument as for `r`,
---  but it has a user-definable recovery `default` instead of
---  `nil`.
---* `v`: Reads an argument `verbatim`, between the following
---   character and its next occurrence.
---
---Optional arguments:
---
---* `o`: A standard LaTeX optional argument, surrounded with square
---  brackets, which will supply
---  `nil` if not given (as described later).
---* `d`: Given as `d` `token1` `token2`, an optional
---  argument which is delimited by `token1` and `token1`.
---  As with  `o`, if no
---  value is given `nil` is returned.
---* `O`: Given as `O{default}`, is like `o`, but
---  returns `default` if no value is given.
---* `D`: Given as `D` `token1` `token2` `{default}`,
---  it is as for `d`, but returns `default` if no value is given.
---  Internally, the `o`, `d` and `O` types are
---  short-cuts to an appropriated-constructed `D` type argument.
---* `s`: An optional star, which will result in a value
---  `true` if a star is present and `false`
---  otherwise (as described later).
---* `t`: An optional `token`, which will result in a value
---  `true` if `token` is present and `false`
---  otherwise. Given as `t` `token`.
function Scanner:new(spec)
  local parser = {}
  setmetatable(parser, Scanner)
  parser.spec = spec
  parser.args = parse_spec(spec)
  parser.result = parser:scan()
  return parser
end

---
---Scan for arguments in the token input stream.
---
---@return any[]
function Scanner:scan()
  local result = {}
  local index = 1
  for _, arg in pairs(self.args) do
    if arg.star then
      -- s
      result[index] = token.scan_keyword('*')
    elseif arg.token then
      -- t
      result[index] = token.scan_keyword(arg.token)
    elseif arg.optional then
      -- o d O D
      local oarg = scan_oarg(arg.init_delim, arg.end_delim)
      if arg.default and oarg == nil then
        oarg = arg.default
      end
      result[index] = oarg
    elseif arg.init_delim and arg.end_delim then
      -- r R
      local oarg = scan_oarg(arg.init_delim, arg.end_delim)
      if arg.default and oarg == nil then
        oarg = arg.default
      end
      if oarg == nil then
        tex.error('Missing required argument')
      end
      result[index] = oarg
    else
      -- m v
      local marg = token.scan_argument(arg.verbatim ~= true)
      if marg == nil then
        tex.error('Missing required argument')
      end
      result[index] = marg
    end
    index = index + 1
  end
  return result
end

---@private
function Scanner:set_result(...)
  self.result = { ... }
end

---
---@return string|boolean|nil ...
function Scanner:export()
  -- #self.arg: to get all elements of the result table, also elements
  -- with nil values.
  return table.unpack(self.result, 1, #self.args)
end

function Scanner:assert(...)
  local arguments = { ... }
  for index, arg in ipairs(arguments) do
    assert(self.result[index] == arg, string.format(
      'Argument at index %d doesn’t match: “%s” != “%s”',
      index, self.result[index], arg))
  end
end

function Scanner:debug()
  for index = 1, #self.args do
    print(index, self.result[index])
  end
end

---
---@param spec string An argument specifier, for example `o m`
---
---Required arguments:
---
---* `m`: A standard mandatory argument, which can either be a single
---  token alone or multiple tokens surrounded by curly braces `{}`.
---  Regardless of the input, the argument will be passed to the
---  internal code without the outer braces. This is the `lparse`
---  type specifier for a normal TeX argument.
---* `r`: Given as `r` `token1` `token2`, this denotes a
---  required delimited argument, where the delimiters are
---  `token1` and `token2`. If the opening delimiter
---  `token1` is missing, `nil` will be
---  returned after a suitable error.
---* `R` Given as `R` `token1` `token2` `default`,
---  this is a required delimited argument as for `r`,
---  but it has a user-definable recovery `default` instead of
---  `nil`.
---* `v`: Reads an argument `verbatim`, between the following
---   character and its next occurrence.
---
---Optional arguments:
---
---* `o`: A standard LaTeX optional argument, surrounded with square
---  brackets, which will supply
---  `nil` if not given (as described later).
---* `d`: Given as `d` `token1` `token2`, an optional
---  argument which is delimited by `token1` and `token1`.
---  As with  `o`, if no
---  value is given `nil` is returned.
---* `O`: Given as `O{default}`, is like `o`, but
---  returns `default` if no value is given.
---* `D`: Given as `D` `token1` `token2` `{default}`,
---  it is as for `d`, but returns `default` if no value is given.
---  Internally, the `o`, `d` and `O` types are
---  short-cuts to an appropriated-constructed `D` type argument.
---* `s`: An optional star, which will result in a value
---  `true` if a star is present and `false`
---  otherwise (as described later).
---* `t`: An optional `token`, which will result in a value
---  `true` if `token` is present and `false`
---  otherwise. Given as `t` `token`.
---
---@return Scanner
local function create_scanner(spec)
  return Scanner:new(spec)
end

---
---Scan for arguments in the token input stream.
---
---@param spec string An argument specifier, for example `o m`
---
---Required arguments:
---
---* `m`: A standard mandatory argument, which can either be a single
---  token alone or multiple tokens surrounded by curly braces `{}`.
---  Regardless of the input, the argument will be passed to the
---  internal code without the outer braces. This is the `lparse`
---  type specifier for a normal TeX argument.
---* `r`: Given as `r` `token1` `token2`, this denotes a
---  required delimited argument, where the delimiters are
---  `token1` and `token2`. If the opening delimiter
---  `token1` is missing, `nil` will be
---  returned after a suitable error.
---* `R` Given as `R` `token1` `token2` `default`,
---  this is a required delimited argument as for `r`,
---  but it has a user-definable recovery `default` instead of
---  `nil`.
---* `v`: Reads an argument `verbatim`, between the following
---   character and its next occurrence.
---
---Optional arguments:
---
---* `o`: A standard LaTeX optional argument, surrounded with square
---  brackets, which will supply
---  `nil` if not given (as described later).
---* `d`: Given as `d` `token1` `token2`, an optional
---  argument which is delimited by `token1` and `token1`.
---  As with  `o`, if no
---  value is given `nil` is returned.
---* `O`: Given as `O{default}`, is like `o`, but
---  returns `default` if no value is given.
---* `D`: Given as `D` `token1` `token2` `{default}`,
---  it is as for `d`, but returns `default` if no value is given.
---  Internally, the `o`, `d` and `O` types are
---  short-cuts to an appropriated-constructed `D` type argument.
---* `s`: An optional star, which will result in a value
---  `true` if a star is present and `false`
---  otherwise (as described later).
---* `t`: An optional `token`, which will result in a value
---  `true` if `token` is present and `false`
---  otherwise. Given as `t` `token`.
---
---@return boolean|string|nil ...
local function scan(spec)
  local scanner = create_scanner(spec)
  return scanner:export()
end

---@class RegisterCsnameOptions
---@field global? boolean
---@field projected? boolean

---
---Register a Lua function under a control sequence name (`csname`).
---
---@param csname string # The control sequence name without the leading backslash.
---@param fn function # The Lua function to be called when the command name is called in the TeX code.
---@param opts? RegisterCsnameOptions
local function register_csname(csname, fn, opts)
  if opts == nil then
    opts = {}
  end
  local fns = lua.get_functions_table()
  local index = 1
  while fns[index] do
    index = index + 1
  end
  fns[index] = fn
  if opts.global and opts.projected then
    token.set_lua(csname, index, 'global', 'protected')
  elseif opts.global then
    token.set_lua(csname, index, 'global')
  elseif opts.projected then
    token.set_lua(csname, index, 'protected')
  else
    token.set_lua(csname, index)
  end
end

return {
  scan = scan,
  Scanner = create_scanner,
  register_csname = register_csname,
  utils = {
    parse_spec = parse_spec,
    scan_oarg = scan_oarg,
  },
}
