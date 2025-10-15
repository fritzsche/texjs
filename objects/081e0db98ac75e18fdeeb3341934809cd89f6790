if not modules then modules = { } end modules ['t-sudoku'] = 
{
  version   = "2023-05-15",
  comment   = "Sudokus for ConTeXt",
  author    = "Jairo A. del Rio",
  copyright = "Jairo A. del Rio",
  license   = "MIT License"
}

-- Sources:

-- https://norvig.com/sudoku.html
-- https://naokishibuya.medium.com/peter-norvigs-sudoku-solver-25779bb349ce
-- https://gist.github.com/neilalbrock/894520

local table, math, io = table, math, io
local ipairs, pairs, tostring = ipairs, pairs, tostring

local floor, ceil, random = math.floor, math.ceil, math.random
local insert, concat, sort = table.insert, table.concat, table.sort

-- ConTeXt goodies

local context, buffers, inferfaces = context, buffers, interfaces
local getcontent = buffers.getcontent
local implement  = interfaces.implement

-- Take a look for definitions
-- https://source.contextgarden.net/tex/context/base/mkiv/l-table.lua
-- https://source.contextgarden.net/tex/context/base/mkiv/l-io.lua

local contains, copy, unique = table.contains, table.copy, table.unique

local loaddata   = io.loaddata

local rows     = {"A", "B", "C", "D", "E", "F", "G", "H", "I"}
local columns  = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

local rowsquare =
{
  {"A", "B", "C"}, {"D", "E", "F"}, {"G", "H", "I"}
}

local columnsquare = 
{
  {"1", "2", "3"}, {"4", "5", "6"}, {"7", "8", "9"}
}

local digits   = '123456789'

-- Helper functions 
-- F#ck Python

local shuffle, string_to_table

shuffle = function(t)
  for i = #t, 2, -1 do
    local j = random(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end

string_to_table = function(s)
  local result = {}
  s = s:gsub("[.%d]", function(x)
    insert(result, x == "." and x or tostring(floor(x)))
  end)
  return result 
end

-- Data

local squares, units 

squares = 
{
  "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9",
  "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9",
  "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9",
  "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9",
  "E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8", "E9",
  "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9",
  "G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8", "G9",
  "H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9",
  "I1", "I2", "I3", "I4", "I5", "I6", "I7", "I8", "I9"
}

units =
{
  ['A1'] = 
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['A2'] = 
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['A3'] = 
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['A4'] = 
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['A5'] = {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  }, 
  ['A6'] = 
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['A7'] = {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['A8'] = 
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['A9'] = 
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  }, 
  ['B1'] = 
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['B2'] = 
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['B3'] = 
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['B4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['B5'] = 
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['B6'] = 
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['B7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['B8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['B9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['C1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['C2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['C3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}
  },
  ['C4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['C5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['C6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A4', 'A5', 'A6', 'B4', 'B5', 'B6', 'C4', 'C5', 'C6'}
  },
  ['C7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['C8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['C9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
    {'A7', 'A8', 'A9', 'B7', 'B8', 'B9', 'C7', 'C8', 'C9'}
  },
  ['D1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['D2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['D3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['D4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['D5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['D6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['D7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['D8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['D9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['E1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['E2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['E3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['E4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['E5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['E6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['E7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['E8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['E9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['F1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['F2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['F3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D1', 'D2', 'D3', 'E1', 'E2', 'E3', 'F1', 'F2', 'F3'}
  },
  ['F4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['F5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['F6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D4', 'D5', 'D6', 'E4', 'E5', 'E6', 'F4', 'F5', 'F6'}
  },
  ['F7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['F8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['F9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9'},
    {'D7', 'D8', 'D9', 'E7', 'E8', 'E9', 'F7', 'F8', 'F9'}
  },
  ['G1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['G2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['G3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['G4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['G5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['G6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['G7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['G8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['G9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['H1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['H2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['H3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['H4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['H5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['H6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['H7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['H8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['H9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['I1'] =
  {
    {'A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1', 'I1'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['I2'] =
  {
    {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['I3'] =
  {
    {'A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'H3', 'I3'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G1', 'G2', 'G3', 'H1', 'H2', 'H3', 'I1', 'I2', 'I3'}
  },
  ['I4'] =
  {
    {'A4', 'B4', 'C4', 'D4', 'E4', 'F4', 'G4', 'H4', 'I4'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['I5'] =
  {
    {'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5', 'H5', 'I5'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['I6'] =
  {
    {'A6', 'B6', 'C6', 'D6', 'E6', 'F6', 'G6', 'H6', 'I6'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G4', 'G5', 'G6', 'H4', 'H5', 'H6', 'I4', 'I5', 'I6'}
  },
  ['I7'] =
  {
    {'A7', 'B7', 'C7', 'D7', 'E7', 'F7', 'G7', 'H7', 'I7'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['I8'] =
  {
    {'A8', 'B8', 'C8', 'D8', 'E8', 'F8', 'G8', 'H8', 'I8'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  },
  ['I9'] =
  {
    {'A9', 'B9', 'C9', 'D9', 'E9', 'F9', 'G9', 'H9', 'I9'},
    {'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'},
    {'G7', 'G8', 'G9', 'H7', 'H8', 'H9', 'I7', 'I8', 'I9'}
  }
}

local peers =
{
  ['A1'] =
  {
    'C1', 'A5', 'A4', 'H1', 'A9', 'D1', 'E1', 'A7', 'A2', 'F1',
    'B3', 'B1', 'G1', 'I1', 'C3', 'B2', 'A6', 'A3', 'A8', 'C2'
  },
  ['A2'] =
  {
    'C1', 'A5', 'A4', 'A9', 'I2', 'A7', 'F2', 'B3', 'H2', 'D2',
    'B1', 'E2', 'C3', 'B2', 'A6', 'A1', 'A3', 'A8', 'C2', 'G2'
  },
  ['A3'] =
  {
    'C1', 'A5', 'A4', 'A9', 'I3', 'F3', 'D3', 'A7', 'A2', 'B3',
    'B1', 'E3', 'C3', 'H3', 'B2', 'G3', 'A6', 'A1', 'A8', 'C2'
  },
  ['A4'] =
  {
    'A5', 'A9', 'H4', 'I4', 'A7', 'A2', 'A8', 'C4', 'B6', 'C5',
    'C6', 'B5', 'A6', 'D4', 'G4', 'A1', 'E4', 'A3', 'F4', 'B4'
  },
  ['A5'] =
  {
    'A4', 'A9', 'H5', 'A7', 'A2', 'D5', 'C4', 'E5', 'F5', 'B6',
    'C5', 'C6', 'B5', 'I5', 'A6', 'A1', 'A3', 'A8', 'G5', 'B4'
  },
  ['A6'] =
  {
    'A5', 'A4', 'A9', 'F6', 'G6', 'D6', 'I6', 'A2', 'A7', 'E6',
    'H6', 'C4', 'B6', 'C6', 'C5', 'B5', 'A1', 'A3', 'A8', 'B4'
  },
  ['A7'] =
  {
    'B7', 'A4', 'A9', 'A5', 'C9', 'C7', 'E7', 'A2', 'F7', 'B9',
    'D7', 'G7', 'I7', 'A6', 'C8', 'A1', 'A3', 'A8', 'B8', 'H7'
  },
  ['A8'] =
  {
    'A5', 'A4', 'A9', 'E8', 'F8', 'B7', 'C9', 'C7', 'A7', 'A2',
    'B9', 'I8', 'H8', 'A6', 'C8', 'A1', 'A3', 'B8', 'G8', 'D8'
  },
  ['A9'] =
  {
    'A5', 'A4', 'B7', 'E9', 'C9', 'I9', 'C7', 'H9', 'A7', 'A2',
    'F9', 'B9', 'G9', 'D9', 'A6', 'C8', 'A1', 'A3', 'A8', 'B8'
  },
  ['B1'] =
  {
    'C1', 'B7', 'H1', 'D1', 'E1', 'A2', 'F1', 'B3', 'B9', 'G1',
    'B6', 'I1', 'C3', 'B2', 'B5', 'A1', 'A3', 'B8', 'C2', 'B4'
  },
  ['B2'] =
  {
    'C1', 'B7', 'I2', 'F2', 'A2', 'B3', 'H2', 'D2', 'B1', 'B9',
    'B6', 'E2', 'C3', 'B5', 'A1', 'A3', 'B8', 'C2', 'G2', 'B4'
  },
  ['B3'] =
  {
    'C1', 'B7', 'I3', 'F3', 'D3', 'A2', 'B1', 'B9', 'B6', 'E3',
    'C3', 'H3', 'B2', 'B5', 'G3', 'A1', 'A3', 'B8', 'C2', 'B4'
  },
  ['B4'] =
  {
    'B7', 'A4', 'A5', 'H4', 'I4', 'B3', 'C4', 'B1', 'B9', 'B6',
    'C5', 'C6', 'B2', 'B5', 'A6', 'D4', 'G4', 'E4', 'B8', 'F4'
  },
  ['B5'] =
  {
    'A5', 'B7', 'A4', 'H5', 'B3', 'D5', 'C4', 'B1', 'B9', 'F5',
    'E5', 'B6', 'C5', 'C6', 'B2', 'I5', 'A6', 'B8', 'G5', 'B4'
  },
  ['B6'] =
  {
    'B7', 'A4', 'A5', 'F6', 'G6', 'D6', 'I6', 'B3', 'E6', 'H6',
    'C4', 'B1', 'B9', 'C6', 'C5', 'B2', 'B5', 'A6', 'B8', 'B4'
  },
  ['B7'] =
  {
    'A9', 'C9', 'C7', 'E7', 'A7', 'A8', 'B3', 'B1', 'B9', 'D7',
    'G7', 'B6', 'I7', 'B2', 'B5', 'C8', 'F7', 'B8', 'H7', 'B4'
  },
  ['B8'] =
  {
    'B7', 'A9', 'E8', 'F8', 'C9', 'C7', 'A7', 'B3', 'B1', 'B9',
    'B6', 'I8', 'B2', 'H8', 'B5', 'C8', 'A8', 'G8', 'D8', 'B4'
  },
  ['B9'] =
  {
    'B7', 'A9', 'E9', 'C9', 'I9', 'C7', 'H9', 'A7', 'B3', 'F9',
    'B1', 'B6', 'G9', 'D9', 'B2', 'B5', 'C8', 'A8', 'B8', 'B4'
  },
  ['C1'] =
  {
    'H1', 'D1', 'E1', 'C9', 'C7', 'A2', 'F1', 'B3', 'B1', 'G1',
    'C5', 'I1', 'C3', 'C6', 'B2', 'C8', 'A1', 'A3', 'C2', 'C4'
  },
  ['C2'] =
  {
    'C1', 'C9', 'C7', 'I2', 'F2', 'A2', 'B3', 'H2', 'D2', 'B1',
    'E2', 'C5', 'C6', 'C3', 'B2', 'C8', 'A1', 'A3', 'G2', 'C4'
  },
  ['C3'] =
  {
    'C1', 'C9', 'I3', 'C7', 'F3', 'D3', 'A2', 'B3', 'B1', 'E3',
    'C5', 'C6', 'H3', 'B2', 'G3', 'C8', 'A1', 'A3', 'C2', 'C4'
  },
  ['C4'] =
  {
    'C1', 'A5', 'A4', 'H4', 'C9', 'I4', 'C7', 'B6', 'C5', 'C6',
    'C3', 'B5', 'A6', 'C8', 'D4', 'G4', 'E4', 'C2', 'F4', 'B4'
  },
  ['C5'] =
  {
    'C1', 'A5', 'A4', 'C9', 'H5', 'C7', 'D5', 'E5', 'F5', 'B4',
    'B6', 'C6', 'C3', 'B5', 'I5', 'A6', 'C8', 'C2', 'G5', 'C4'
  },
  ['C6'] =
  {
    'C1', 'A5', 'A4', 'C9', 'C7', 'F6', 'G6', 'D6', 'I6', 'E6',
    'H6', 'B4', 'B6', 'C5', 'C3', 'B5', 'A6', 'C8', 'C2', 'C4'
  },
  ['C7'] =
  {
    'C1', 'B7', 'A9', 'C9', 'E7', 'A7', 'A8', 'B9', 'D7', 'G7',
    'C5', 'C6', 'C3', 'I7', 'C8', 'F7', 'B8', 'H7', 'C2', 'C4'
  },
  ['C8'] =
  {
    'C1', 'B7', 'A9', 'E8', 'F8', 'C9', 'C7', 'A7', 'B9', 'I8',
    'C5', 'C3', 'C6', 'H8', 'A8', 'B8', 'G8', 'C2', 'D8', 'C4'
  },
  ['C9'] =
  {
    'C1', 'B7', 'A9', 'E9', 'I9', 'C7', 'H9', 'A7', 'F9', 'B9',
    'G9', 'C5', 'C6', 'D9', 'C3', 'C8', 'A8', 'B8', 'C2', 'C4'
  },
  ['D1'] =
  {
    'C1', 'H1', 'E1', 'F3', 'D3', 'D6', 'F2', 'F1', 'D5', 'D2',
    'B1', 'D7', 'G1', 'E2', 'E3', 'I1', 'D9', 'A1', 'D4', 'D8'
  },
  ['D2'] =
  {
    'D1', 'E1', 'F3', 'D3', 'I2', 'D6', 'F2', 'A2', 'F1', 'D5',
    'H2', 'D7', 'E2', 'E3', 'D9', 'B2', 'D4', 'C2', 'G2', 'D8'
  },
  ['D3'] =
  {
    'D1', 'E1', 'I3', 'F3', 'D6', 'F2', 'F1', 'B3', 'D5', 'D2',
    'D7', 'E2', 'E3', 'C3', 'H3', 'D9', 'G3', 'D4', 'A3', 'D8'
  },
  ['D4'] =
  {
    'A4', 'H4', 'D1', 'F4', 'I4', 'D3', 'F6', 'D6', 'D5', 'D2',
    'E6', 'C4', 'D7', 'F5', 'E5', 'D9', 'G4', 'E4', 'D8', 'B4'
  },
  ['D5'] =
  {
    'A5', 'D1', 'F4', 'H5', 'D3', 'F6', 'D6', 'D2', 'E6', 'E5',
    'F5', 'D7', 'C5', 'D9', 'B5', 'I5', 'D4', 'E4', 'G5', 'D8'
  },
  ['D6'] =
  {
    'D1', 'F4', 'D3', 'F6', 'G6', 'I6', 'D5', 'D2', 'E6', 'H6',
    'D7', 'F5', 'E5', 'B6', 'C6', 'D9', 'A6', 'D4', 'E4', 'D8'
  },
  ['D7'] =
  {
    'B7', 'E8', 'F8', 'D1', 'E9', 'C7', 'D3', 'E7', 'A7', 'D6',
    'D5', 'D2', 'F9', 'G7', 'D9', 'I7', 'D4', 'F7', 'H7', 'D8'
  },
  ['D8'] =
  {
    'E8', 'F8', 'D1', 'E9', 'D3', 'E7', 'D6', 'A8', 'D5', 'D2',
    'F9', 'D7', 'I8', 'D9', 'H8', 'C8', 'D4', 'F7', 'B8', 'G8'
  },
  ['D9'] =
  {
    'A9', 'E8', 'F8', 'D1', 'E9', 'C9', 'I9', 'D3', 'E7', 'H9',
    'D6', 'D5', 'D2', 'F9', 'B9', 'D7', 'G9', 'D4', 'F7', 'D8'
  },
  ['E1'] =
  {
    'C1', 'H1', 'E8', 'D1', 'E9', 'F3', 'D3', 'E7', 'F2', 'F1',
    'D2', 'E6', 'B1', 'E5', 'G1', 'E2', 'E3', 'I1', 'A1', 'E4'
  },
  ['E2'] =
  {
    'E8', 'D1', 'E1', 'E9', 'F3', 'D3', 'E7', 'I2', 'F2', 'A2',
    'F1', 'H2', 'D2', 'E6', 'E5', 'E3', 'B2', 'E4', 'C2', 'G2'
  },
  ['E3'] =
  {
    'E8', 'D1', 'E1', 'I3', 'E9', 'F3', 'D3', 'E7', 'F2', 'F1',
    'B3', 'D2', 'E6', 'E5', 'E2', 'C3', 'H3', 'G3', 'A3', 'E4'
  },
  ['E4'] =
  {
    'A4', 'E8', 'H4', 'E1', 'E9', 'I4', 'E7', 'F6', 'D6', 'D5',
    'E6', 'C4', 'E5', 'F5', 'E2', 'E3', 'D4', 'G4', 'F4', 'B4'
  },
  ['E5'] =
  {
    'A5', 'E8', 'E1', 'E9', 'H5', 'E7', 'F6', 'D6', 'D5', 'E6',
    'F5', 'E2', 'E3', 'C5', 'B5', 'I5', 'D4', 'E4', 'G5', 'F4'
  },
  ['E6'] =
  {
    'E8', 'E1', 'E9', 'E7', 'F6', 'G6', 'D6', 'I6', 'D5', 'H6',
    'E5', 'F5', 'B6', 'E2', 'E3', 'C6', 'A6', 'D4', 'E4', 'F4'
  },
  ['E7'] =
  {
    'B7', 'E8', 'F8', 'E1', 'E9', 'C7', 'A7', 'F9', 'E6', 'D7',
    'E5', 'G7', 'E2', 'E3', 'D9', 'I7', 'E4', 'F7', 'H7', 'D8'
  },
  ['E8']  =
  {
    'F8', 'E1', 'E9', 'E7', 'A8', 'F9', 'E6', 'E5', 'D7', 'E2',
    'E3', 'I8', 'D9', 'H8', 'C8', 'E4', 'F7', 'B8', 'G8', 'D8'
  },
  ['E9'] =
  {
    'A9', 'E8', 'F8', 'C9', 'E1', 'I9', 'E7', 'H9', 'F9', 'E6',
    'B9', 'E5', 'D7', 'E2', 'G9', 'E3', 'D9', 'E4', 'F7', 'D8'
  },
  ['F1'] =
  {
    'C1', 'H1', 'F8', 'D1', 'E1', 'F3', 'D3', 'F6', 'F2', 'D2',
    'F9', 'B1', 'G1', 'F5', 'E2', 'E3', 'I1', 'A1', 'F7', 'F4'
  },
  ['F2'] =
  {
    'F8', 'D1', 'E1', 'F3', 'D3', 'I2', 'F6', 'A2', 'F1', 'H2',
    'F9', 'D2', 'F5', 'E2', 'E3', 'B2', 'F7', 'C2', 'G2', 'F4'
  },
  ['F3'] =
  {
    'F8', 'D1', 'E1', 'I3', 'D3', 'F6', 'F2', 'F1', 'B3', 'D2',
    'F9', 'F5', 'E2', 'E3', 'C3', 'H3', 'G3', 'A3', 'F7', 'F4'
  },
  ['F4'] =
  {
    'A4', 'F8', 'H4', 'I4', 'F3', 'F6', 'D6', 'F2', 'F7', 'F1',
    'D5', 'F9', 'E6', 'C4', 'E5', 'F5', 'D4', 'G4', 'E4', 'B4'
  },
  ['F5'] =
  {
    'A5', 'F8', 'H5', 'F3', 'F6', 'D6', 'F2', 'F1', 'D5', 'F9',
    'E6', 'E5', 'C5', 'B5', 'I5', 'D4', 'E4', 'F7', 'G5', 'F4'
  },
  ['F6'] =
  {
    'F8', 'F3', 'G6', 'D6', 'F2', 'I6', 'F1', 'D5', 'F9', 'E6',
    'H6', 'E5', 'F5', 'B6', 'C6', 'A6', 'D4', 'E4', 'F7', 'F4'
  },
  ['F7'] =
  {
    'B7', 'E8', 'F8', 'E9', 'F4', 'C7', 'F3', 'E7', 'F6', 'A7',
    'F2', 'F1', 'F9', 'D7', 'F5', 'G7', 'D9', 'I7', 'H7', 'D8'
  },
  ['F8'] =
  {
    'E8', 'E9', 'F3', 'E7', 'F6', 'F2', 'F7', 'F1', 'F9', 'D7',
    'F5', 'D8', 'I8', 'D9', 'H8', 'C8', 'A8', 'B8', 'G8', 'F4'
  },
  ['F9'] =
  {
    'A9', 'E8', 'F8', 'E9', 'C9', 'F4', 'I9', 'F3', 'E7', 'F6',
    'H9', 'F2', 'F1', 'B9', 'D7', 'F5', 'G9', 'D9', 'F7', 'D8'
  },
  ['G1'] =
  {
    'C1', 'H1', 'D1', 'E1', 'I3', 'I2', 'G5', 'G6', 'F1', 'H2',
    'B1', 'G7', 'G9', 'I1', 'H3', 'G3', 'A1', 'G4', 'G8', 'G2'
  },
  ['G2'] =
  {
    'H1', 'I3', 'I2', 'G5', 'G6', 'F2', 'A2', 'H2', 'D2', 'G1',
    'G7', 'E2', 'G9', 'I1', 'H3', 'B2', 'G3', 'G4', 'G8', 'C2'
  },
  ['G3'] =
  {
    'H1', 'I3', 'F3', 'D3', 'I2', 'G5', 'G6', 'B3', 'H2', 'G1',
    'G7', 'G9', 'E3', 'I1', 'C3', 'H3', 'G4', 'A3', 'G8', 'G2'
  },
  ['G4'] =
  {
    'A4', 'H4', 'I4', 'H5', 'G5', 'G6', 'I6', 'H6', 'C4', 'G1',
    'G7', 'G9', 'G3', 'I5', 'D4', 'E4', 'G8', 'G2', 'F4', 'B4'
  },
  ['G5'] =
  {
    'A5', 'H4', 'I4', 'H5', 'G6', 'I6', 'D5', 'H6', 'G2', 'E5',
    'F5', 'G1', 'G7', 'G9', 'C5', 'B5', 'G3', 'I5', 'G4', 'G8'
  },
  ['G6'] =
  {
    'H4', 'I4', 'H5', 'G5', 'F6', 'D6', 'I6', 'E6', 'H6', 'G1',
    'G7', 'B6', 'G9', 'C6', 'G3', 'I5', 'A6', 'G4', 'G8', 'G2'
  },
  ['G7'] =
  {
    'B7', 'C7', 'I9', 'E7', 'G5', 'G6', 'H9', 'A7', 'G8', 'D7',
    'G1', 'G9', 'I8', 'I7', 'H8', 'G3', 'G4', 'F7', 'H7', 'G2'
  },
  ['G8'] =
  {
    'E8', 'F8', 'I9', 'G5', 'H7', 'G6', 'H9', 'G1', 'G7', 'G9',
    'I8', 'I7', 'H8', 'G3', 'C8', 'G4', 'A8', 'B8', 'G2', 'D8'
  },
  ['G9'] =
  {
    'A9', 'E9', 'C9', 'I9', 'H7', 'G6', 'H9', 'F9', 'B9', 'G2',
    'G1', 'G7', 'I8', 'D9', 'I7', 'H8', 'G3', 'G4', 'G8', 'G5'
  },
  ['H1'] =
  {
    'C1', 'H4', 'D1', 'E1', 'I3', 'H5', 'I2', 'H9', 'F1', 'H2',
    'H6', 'B1', 'G1', 'I1', 'H3', 'H8', 'G3', 'A1', 'H7', 'G2'
  },
  ['H2'] =
  {
    'H1', 'H4', 'I3', 'H5', 'I2', 'H9', 'F2', 'A2', 'D2', 'H6',
    'G1', 'E2', 'I1', 'H3', 'H8', 'B2', 'G3', 'H7', 'C2', 'G2'
  },
  ['H3'] =
  {
    'H1', 'H4', 'I3', 'H5', 'F3', 'D3', 'I2', 'H9', 'B3', 'H2',
    'H6', 'G1', 'E3', 'I1', 'C3', 'H8', 'G3', 'A3', 'H7', 'G2'
  },
  ['H4'] =
  {
    'A4', 'H1', 'I4', 'H5', 'G6', 'H9', 'I6', 'H2', 'H6', 'C4',
    'H3', 'H8', 'I5', 'D4', 'G4', 'E4', 'H7', 'G5', 'F4', 'B4'
  },
  ['H5'] =
  {
    'A5', 'H1', 'H4', 'I4', 'G6', 'H9', 'I6', 'D5', 'H2', 'H6',
    'E5', 'F5', 'C5', 'H3', 'H8', 'B5', 'I5', 'G4', 'H7', 'G5'
  },
  ['H6'] =
  {
    'H1', 'H4', 'I4', 'H5', 'F6', 'H9', 'D6', 'G6', 'I6', 'H2',
    'E6', 'B6', 'C6', 'H3', 'H8', 'I5', 'A6', 'G4', 'H7', 'G5'
  },
  ['H7'] =
  {
    'B7', 'H1', 'H4', 'H5', 'C7', 'I9', 'E7', 'H9', 'A7', 'H2',
    'H6', 'G8', 'D7', 'G7', 'G9', 'I8', 'I7', 'H3', 'H8', 'F7'
  },
  ['H8'] =
  {
    'H1', 'E8', 'F8', 'H4', 'H5', 'I9', 'H7', 'H9', 'H2', 'H6',
    'G7', 'G9', 'I8', 'H3', 'I7', 'C8', 'A8', 'B8', 'G8', 'D8'
  },
  ['H9'] =
  {
    'A9', 'H1', 'H4', 'E9', 'C9', 'H5', 'I9', 'H2', 'F9', 'H6',
    'B9', 'G8', 'G7', 'G9', 'I8', 'D9', 'H3', 'H8', 'I7', 'H7'
  },
  ['I1'] =
  {
    'C1', 'H1', 'D1', 'E1', 'I3', 'I4', 'I9', 'I2', 'I6', 'F1',
    'H2', 'B1', 'G1', 'I8', 'I7', 'H3', 'G3', 'I5', 'A1', 'G2'
  },
  ['I2'] =
  {
    'H1', 'I3', 'I4', 'I9', 'I6', 'F2', 'A2', 'H2', 'D2', 'G1',
    'E2', 'I8', 'I1', 'I7', 'H3', 'B2', 'G3', 'I5', 'C2', 'G2'
  },
  ['I3'] =
  {
    'H1', 'I4', 'I9', 'F3', 'D3', 'I2', 'I6', 'B3', 'H2', 'G1',
    'E3', 'I8', 'I1', 'H3', 'I7', 'C3', 'G3', 'I5', 'A3', 'G2'
  },
  ['I4'] =
  {
    'A4', 'H4', 'I3', 'H5', 'I9', 'I2', 'G6', 'I6', 'H6', 'C4',
    'I8', 'I1', 'I7', 'I5', 'D4', 'G4', 'E4', 'G5', 'F4', 'B4'
  },
  ['I5'] =
  {
    'A5', 'H4', 'I3', 'I4', 'H5', 'I9', 'I2', 'G6', 'I6', 'D5',
    'H6', 'E5', 'F5', 'C5', 'I1', 'I8', 'I7', 'B5', 'G4', 'G5'
  },
  ['I6'] =
  {
    'H4', 'I3', 'I4', 'H5', 'I9', 'I2', 'F6', 'G6', 'D6', 'E6',
    'H6', 'B6', 'C6', 'I1', 'I8', 'I7', 'I5', 'A6', 'G4', 'G5'
  },
  ['I7'] =
  {
    'B7', 'I3', 'I4', 'C7', 'I9', 'E7', 'I2', 'H9', 'A7', 'I6',
    'G8', 'D7', 'G7', 'G9', 'I8', 'I1', 'H8', 'I5', 'F7', 'H7'
  },
  ['I8'] =
  {
    'E8', 'F8', 'I3', 'I4', 'I9', 'I2', 'H9', 'I6', 'G8', 'G7',
    'G9', 'I1', 'I7', 'H8', 'I5', 'C8', 'A8', 'B8', 'H7', 'D8'
  },
  ['I9'] =
  {
    'A9', 'E9', 'C9', 'I4', 'I3', 'I2', 'H9', 'I6', 'F9', 'B9',
    'G8', 'G7', 'G9', 'I8', 'I1', 'D9', 'I7', 'H8', 'I5', 'H7'
  }
}

local grid_chars, grid_values, parse_grid, assign, 
      eliminate, solve, search, random_sudoku

-- Input: a string representation 
-- Output: an association between squares and characters

grid_values = function(grid)
  local result = {}
  local chars  = string_to_table(grid)
  assert(#chars == 81, "Invalid grid")
  
  -- ipairs is necessary here 
    
  for k, v in ipairs(squares) do
    result[v] = chars[k]
  end
  return result
end

-- Input: a table grid 
-- Output: return false if contradiction

parse_grid = function(grid)
  local values = {}
  local gridvalues = grid_values(grid)
    
  -- Every square can be any digit 
  
  for _, s in ipairs(squares) do
    values[s] = digits
  end
  
  for s, d in pairs(gridvalues) do
    if digits:find(d) and not assign(values, s, d) then
      return false
    end
  end
  return values
end

assign = function(values, s, d)
  -- Eliminate all the other values and propagate
  local result = true
  local other_values = string_to_table(values[s]:gsub(d,''))
  for _, d2 in ipairs(other_values) do
    if not eliminate(values, s, d2) then
      result = false
    end
  end
  return result and values or false
end

eliminate = function(values, s, d)
  -- Eliminate d from values[s]
  if not values[s]:find(d) then
    return values --Already eliminated
  end
  values[s] = values[s]:gsub(d,'')
    -- 1. If a square s is reduced to one value d2, then eliminate d2 from the peers
  if #values[s] == 0 then
    return false 
  elseif #values[s] == 1 then
    local check = true
    local d2 = values[s]
    for _, s2 in pairs(peers[s]) do
      if not eliminate(values, s2, values[s]) then
        check = false
      end 
    end
    if not check then return false end
  end
  -- 2. If a unit u is reduced to only one place for a value d, then put it there
  for _, u in ipairs(units[s]) do
    local dplaces = {}
    for _, w in ipairs(u) do
      if values[w]:find(d) then
        insert(dplaces, w)
      end
    end
    if #dplaces == 0 then
      return false --contradiction
    elseif #dplaces == 1 then
      if not assign(values, dplaces[1], d) then
        return false
      end
    end
  end
  return values 
end

solve = function(grid)
  return search(parse_grid(grid))
end

search = function(values)
  local check = true
  local n = {}
  local s 
  if not values then
    return false --Fail
  end
  for _, s in ipairs(squares) do
    if #values[s] ~= 1 then
      check = false
    end
  end
  if check then return values end --Solved!
  for _, x in ipairs(squares) do
    if #values[x] > 1 then
      insert(n, {#values[x], x})
    end
  end
  sort(n, function(t1,t2) return t1[1] < t2[1] end)
  s = n[1][2]
  for _, d in ipairs(string_to_table(values[s])) do
    local result = search(assign(copy(values), s, d))
    if result then return result end
  end
  return false
end 

-- Unused until I find a handy way to interface with ConTeXt

random_sudoku = function(N)
  local N = N or 17
  local result = {}
  local values = {}
  for _, s in ipairs(squares) do
    values[s] = digits
  end
  for _, v in ipairs(shuffle(copy(squares))) do
    local r = random(#values[v])
    if not assign(values, v, values[v]:sub(r, r)) then
      break
    end
    local ds = {}
    for _, s in ipairs(squares) do
      if #values[s] == 1 then
        insert(ds, values[s])
      end
    end
    if #ds >= N and #unique(ds) >= 8 then
      for _, i in ipairs(rows) do
        for _, j in ipairs(columns) do
          insert(result, #values[i..j] == 1 and values[i..j] or "0")
        end
      end
      return concat(result)
    end
  end
  return random_sudoku(N)
end

-- ConTeXt functions

local ctx_sudoku, ctx_solvesudoku, 
      ctx_sudokufile, ctx_solvesudokufile, 
      ctx_sudokubuffer, ctx_sudokusolvebuffer,
      ctx_randomsudoku, ctx_sudokufunction,
      ctx_typeset, ctx_error

ctx_sudoku = function(grid, data)
  local ok, result = pcall(grid_values, grid)
  if ok then
    ctx_typeset(result, data)
  else
    ctx_error("a") -- Invalid sudoku
  end
end

ctx_sudokufile = function(file, data)
  local ok, result = pcall(grid_values, loaddata(file))
  if ok then
    ctx_typeset(result, data)
  else
    ctx_error("b") -- "Invalid sudoku file"
  end
end

ctx_solvesudoku = function(grid, data)
  local ok, result = pcall(solve, grid)
  if ok then
    if result then
      ctx_typeset(result, data)
    else
      ctx_error("c") -- "Impossible to find a solution"
    end
  else
    ctx_error("a") -- "Invalid sudoku"
  end
end

ctx_sudokubuffer = function(buffer, data)
  local ok, result = pcall(grid_values, getcontent(buffer))
  if ok then
    if result then
      ctx_typeset(result, data)
    else
      ctx_error("c")
    end
  else
    ctx_error("b")
  end
end

ctx_sudokusolvebuffer = function(buffer, data)
  local ok, result = pcall(solve, getcontent(buffer))
  if ok then
    if result then
      ctx_typeset(result, data)
    else
      ctx_error("c")
    end
  else
    ctx_error("b")
  end
end

ctx_solvesudokufile = function(file, data)
  local ok, result = pcall(solve, loaddata(file))
  if ok then
    if result then
      ctx_typeset(result, data)
    else
      ctx_error("c") -- "Impossible to find a solution"
    end
  else
    ctx_error("b") -- "Invalid sudoku file"
  end
end

ctx_error = function(nerror)
  local c = interfaces.constants
  local placeholder, label, command = c.placeholder, c.label, c.command
  c = context
  c.sudokuparameter(placeholder .. command,
    c.nested.sudokuparameter(placeholder .. label .. nerror)
  )
end

local ctx_sudokufunctions = 
{
  sudoku            = ctx_sudoku,
  sudokufile        = ctx_sudokufile,
  sudokubuffer      = ctx_sudokubuffer,
  sudokusolvebuffer = ctx_sudokusolvebuffer,
  solvesudoku       = ctx_solvesudoku,
  solvesudokufile   = ctx_solvesudokufile
}

ctx_sudokufunction = function(t)
  ctx_sudokufunctions[t.name](t.content, t)
end

ctx_randomsudoku = function(data)
  local n = tonumber(data.n)
  if n < 17 then
    ctx_error("d")
    return
  end
  local result = grid_values(random_sudoku(tonumber(n)))
  ctx_typeset(result, data)
end

ctx_typeset = function(grid, data)
  local alternatives = 
    {
      {background = data.oddbackground,  backgroundcolor = data.oddbackgroundcolor }, 
      {background = data.evenbackground, backgroundcolor = data.evenbackgroundcolor}
    }
  for i, a in ipairs(rows) do
    context.bTR()
    for j, b in ipairs(columns) do
      local r = grid[a..b]
      context.bTD(alternatives[(ceil(i/3)+ceil(j/3))%2+1])
      context(r == '0' and "" or r == '.' and "" or r)
      context.eTD()
    end
    context.eTR()
  end
end

--context.sudokuplaceholder = function(text)
--  context.quitvmode()
--  context.framed(context.nested.type(text))
--end

implement{
  name      = "sudokufunction",
  arguments = {"hash"},
  actions   = ctx_sudokufunction
}

implement{
  name      = "randomsudoku",
  arguments = {"hash"},
  actions   = ctx_randomsudoku
}
