-- -*- coding: utf-8 -*-

--[[

   Copyright 2013 Stephan Hennig

   This file is part of Padrinoma.

   Padrinoma is free software: you can redistribute it and/or modify it
   under the terms of the GNU Affero General Public License as published
   by the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Padrinoma is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public
   License along with Padrinoma.  If not, see
   <http://www.gnu.org/licenses/>.

   Diese Datei ist Teil von Padrinoma.

   Padrinoma ist Freie Software: Sie können es unter den Bedingungen der
   GNU Affero General Public License, wie von der Free Software
   Foundation, Version 3 der Lizenz oder (nach Ihrer Wahl) jeder
   späteren veröffentlichten Version, weiterverbreiten und/oder
   modifizieren.

   Padrinoma wird in der Hoffnung, dass es nützlich sein wird, aber OHNE
   JEDE GEWÄHELEISTUNG, bereitgestellt; sogar ohne die implizite
   Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN
   ZWECK.  Siehe die GNU Affero General Public License für weitere
   Details.

   Sie sollten eine Kopie der GNU Affero General Public License zusammen
   mit diesem Programm erhalten haben. Wenn nicht, siehe
   <http://www.gnu.org/licenses/>.

--]]



--- This module implements is a simple trie class.
-- This is a linked table implementation of a trie data structure.  The
-- implementation does not claim to be memory or performance efficient.
-- The original purpose of this trie implementation was a flexible
-- re-implementation of <a
-- href='http://tug.org/docs/liang/'>F.M. Liang's hyphenation
-- algorithm</a> in Lua.<br />
--
-- This trie requires keys to be in table representation.  Table
-- representation of a key is a sequence of <em>letters</em> (a table
-- with values starting at index 1).  The term <em>letter</em> here
-- refers to any valid Lua value, except the value `nil`.  That is, the
-- alphabet of valid letters is not restricted to characters
-- representing letters as known from scripts.  As an example, the key
-- <code>{'h', 'e', 'l', 'l', 'o'}</code> consists of five letters (each
-- one a single character) and might represent the word
-- <code>hello</code>, while the table <code>{'hello'}</code> represents
-- an entirely different word with only a single letter (a string).  Two
-- tables represent the same key, if they contain the same combination
-- of letters (the same key/value pairs).  A function is provided to
-- convert an arbitrary key into table representation.<br />
--
-- <em>Some numbers:</em> Storing 435,000 German words with 5.4 million
-- characters results in a trie with 1.2 million nodes consuming 77 MB
-- of memory.  That is, in this example application, a single node in
-- the trie uses ca. 69 bytes of memory.  Other than that, the
-- implementation is fully functional.  <em>But you have been
-- warned!</em><br />
--
-- This class is derived from class `autotype-cls_pdnm_oop`.
--
--
-- @class module
-- @name autotype-cls_pdnm_trie_simple
-- @author Stephan Hennig
-- @copyright 2013, Stephan Hennig

-- API-Dokumentation can be generated via <pre>
--
--   luadoc -d API *.lua
--
-- </pre>



-- Load third-party modules.
local unicode = require('unicode')
local cls_oop = require('autotype-cls_pdnm_oop')



-- @trick Prevent LuaDoc from looking past here for module description.
--[[ Trick LuaDoc into entering 'module' mode without using that command.
module(...)
--]]
-- Local module table.
local M = cls_oop:new()



-- Short-cuts.
local Tconcat = table.concat
local Tinsert = table.insert
local Tremove = table.remove
local Ufind = unicode.utf8.find
local UAsub = unicode.ascii.sub
local Ugmatch = unicode.utf8.gmatch



--- Create new trie node.
-- This function returns a newly created trie node with no associated
-- value.
--
-- @param self  Callee reference.
-- @return Trie node.
local function new_node(self)
   return {}
end
M.new_node = new_node



--- Set value associated with a trie node.
-- This function stores a value in a trie associated with the given
-- node.
--
-- @param self  Callee reference.
-- @param node  Trie node.
-- @param value  New value.
-- @return Old value associated with node.
-- @see get_value
local function set_value(self, node, value)
   local old_value = self.value[node]
   self.value[node] = value
   return old_value
end
M.set_value = set_value



--- Get value associated with a trie node.
-- This function retrieves a value in a trie associated with the given
-- node.
--
-- @param self  Callee reference.
-- @param node  Trie node.
-- @return Value associated with node.
-- @see set_value
local function get_value(self, node)
   return self.value[node]
end
M.get_value = get_value



--- Get reference to root node.
-- This function returns a reference to the root node of the trie
-- object.
--
-- @param self  Callee reference.
-- @return Root node.
local function get_root(self)
   return self.root
end
M.get_root = get_root



--- Traverse trie in breadth-first order.
-- For every node visited, a user-supplied function is called.
-- Arguments of that function are a reference to the trie object and a
-- node.  The order a node's child nodes are visited is unspecified.
--
-- @param self  Callee reference.
-- @param visit  User-defined function.
local function bfs(self, visit)
   assert(type(visit) == "function", 'Bad visit function!')
   -- Initialize sequence of all zero level nodes (root node only).
   local current_level = { self:get_root() }
   -- Sequence of nodes of the next level.
   local next_level
   -- Is the current level sequence non-empty?
   while #current_level > 0 do
      -- Start with empty list of child nodes.
      next_level = {}
      -- Iterate over nodes of the current level.
      for _,node in ipairs(current_level) do
         -- Visit node.
         visit(self, node)
         -- Collect all child nodes.
         for _,child in pairs(node) do
            Tinsert(next_level, child)
         end
      end
      -- Prepare for processing next level.
      current_level = next_level
   end
end
M.bfs = bfs



--- Debug traverse trie in breadth-first order.
-- This function differs from function bfs() in that the user-supplied
-- visit function can access more node related data.  Visit function
-- arguments are a reference to the trie object and a table with keys
-- `node`, `level`, `parent`, `letter`, `prefix`.  Additionally, before
-- and after the set of nodes of the same level are visited, two more
-- user-supplied functions are called (if non-nil).  Arguments of those
-- functions are a reference to the trie object and the level number.
-- Since deterministic traversal is desirable for some applications, a
-- node's child nodes are visited in ascending transition letter order.
-- (Internal sorting is done via byte-based `table.sort`).
--
-- @param self  Callee reference.
-- @param visit  User-defined function or nil.
-- @param level_preamble  User-defined function or nil.
-- @param level_postamble  User-defined function or nil.
-- @see bfs
local function debug_bfs(self, visit, level_preamble, level_postamble)
   assert(visit == nil or type(visit) == "function", 'Bad visit function!')
   assert(level_preamble == nil or type(level_preamble) == "function", 'Bad level preamble!')
   assert(level_postamble == nil or type(level_postamble) == "function", 'Bad level postamble!')
   local level = 0
   -- Initialize sequence of all zero level nodes (root node only).
   local current_level = {
      -- Root node.
      {
         node = self:get_root(),
         level = level,
         parent = nil,
         letter = nil,
         prefix = {},
      }
   }
   -- Sequence of nodes of the next level.
   local next_level
   -- Is the current level sequence non-empty?
   while #current_level > 0 do
      -- Start with empty list of child nodes.
      next_level = {}
      -- Call level preamble function.
      if level_preamble ~= nil then level_preamble(self, level) end
      -- Iterate over nodes of the current level.
      for _,data in ipairs(current_level) do
         -- Visit node.
         visit(self, data)
         -- Sort child nodes for more deterministic behaviour.  May be
         -- relevant when creating a visual trie representation.
         local a = {}
         for letter,child in pairs(data.node) do
            Tinsert(a, letter)
         end
         table.sort(a)
         -- Collect all child nodes.
         for _,letter in ipairs(a) do
            -- Create prefix copy.
            local pfx = {}
            for _,l in ipairs(data.prefix) do
               Tinsert(pfx, l)
            end
            -- Append current letter.
            Tinsert(pfx, letter)
            -- Store node.
            Tinsert(next_level, {
                       node = data.node[letter],
                       level = level,
                       parent = data.node,
                       letter = letter,
                       prefix = pfx,
                               }
            )
         end
      end
      -- Call level postamble function.
      if level_postamble ~= nil then level_postamble(self, level) end
      -- Prepare for processing next level.
      current_level = next_level
      level = level + 1
   end
end
M.debug_bfs = debug_bfs



--- Traverse trie in depth-first order.
-- For every node visited, a user-supplied function is called pre-order.
-- Arguments of that function are a reference to the trie object and a
-- node.  The order a node's child nodes are visited is unspecified.
--
-- @param self  Callee reference.
-- @param visit  User-defined function.
local function dfs(self, visit)
   assert(type(visit) == 'function', 'Bad visit function!')
   -- Workhorse function for dfs recursion.
   local function recurse(self, node)
      -- Visit node.
      visit(self, node)
      -- Recurse into child nodes.
      for _,child in pairs(node) do
         recurse(self, child)
      end
   end
   -- Recurse starting at trie root.
   recurse(self, self:get_root())
end
M.dfs = dfs



--- Debug traverse trie in depth-first order.
-- This function differs from function dfs() in that pre-order as well
-- as post-order node visiting is possible.  Additionally, user-supplied
-- visit function(s) can access more node related data.  Visit function
-- arguments are a reference to the trie object and a table with keys
-- `node`, `level`, `parent`, `letter`, `prefix`.  Since deterministic
-- traversal is desirable for some applications, a node's child nodes
-- are visited in ascending transition letter order.  (Internal sorting
-- is done via byte-based `table.sort`).
--
-- @param self  Callee reference.
-- @param visit_pre_order  User-defined function or nil.
-- @param visit_post_order  User-defined function or nil.
-- @see dfs
local function debug_dfs(self, visit_pre_order, visit_post_order)
   assert(visit_pre_order == nil or type(visit_pre_order) == 'function', 'Bad visit function!')
   assert(visit_post_order == nil or type(visit_post_order) == 'function', 'Bad visit function!')
   -- Recursion upvalue table collecting various data related to the
   -- node to be visited.  This table is the argument to visit
   -- functions.
   local data = {
      -- Current node.
      node = nil,
      -- Level the current node is placed with the trie.
      level = nil,
      -- Patent node.
      parent = nil,
      -- Transition letter that lead from parent to node.
      letter = nil,
      -- A sequence containing all transition letters that lead to the
      -- current node from root.
      prefix = {},
   }
   -- Workhorse function for dfs recursion.  This function, in contrast
   -- to visit functions, doesn't have a table argument for memory
   -- efficiency reasons.
   local function recurse(self, node, level, parent, letter)
      -- Update node related data.
      data.node = node
      data.level = level
      data.parent = parent
      data.letter = letter
      -- Visit node pre-order.
      if visit_pre_order ~= nil then visit_pre_order(self, data) end
      -- Recurse into child nodes.
      for letter,child in pairs(node) do
         -- Update prefix.
         Tinsert(data.prefix, letter)
         recurse(self, child, level + 1, node, letter)
         -- Restore prefix.
         Tremove(data.prefix)
      end
      -- Restore node related data for post-order visitor.
      data.node = node
      data.level = level
      data.parent = parent
      data.letter = letter
      -- Visit node post-order.
      if visit_post_order ~= nil then visit_post_order(self, data) end
   end
   -- Recurse starting at trie root.
   recurse(self, self:get_root(), 0, nil, nil)
end
M.debug_dfs = debug_dfs



--- Convert a key to table representation.
-- A table argument is returned as is.  A string argument is converted
-- into a table containing UTF-8 characters as values, starting at index
-- 1 (a sequence).  Any non-table, non-string argument is converted into
-- a table with the argument as value at index 1 (a sequence).
--
-- @param key  Key to convert into table representation.
-- @return Key in table representation.
local function key(self, key)
   local key_type = type(key)
   if key_type == 'table' then
      return key
   elseif key_type == 'string' then
      key_table = {}
      for ch in Ugmatch(key, '.') do
         Tinsert(key_table, ch)
      end
      return key_table
   else
      return { key }
   end
end
M.key = key



--- Insert a key into a trie.
-- Any existing value is replaced by the new value.
--
-- @param self  Callee reference.
-- @param key  A key in table representation.
-- @param new_value  A non-nil value associated with the key.
-- @return Old value associated with key.
local function insert(self, key, new_value)
   assert(type(key) == 'table','Key must be in table representation. Got ' .. type(key) .. ': ' .. tostring(key))
   -- Start inserting letters at root node.
   local node = self.root
   assert(type(node) == 'table', 'Trie root not found!')
   -- Iterate over key letters.
   for _,letter in ipairs(key) do
      -- Search matching edge.
      local next = node[letter]
      -- Need to insert new edge?
      if next == nil then
         next = self:new_node()
         node[letter] = next
      end
      -- Advance.
      node = next
   end
   -- Save old value.
   local old_value = self.value[node]
   -- Set new value.
   self.value[node] = new_value
   -- Return old value.
   return old_value
end
M.insert = insert



--- Search for a key in trie.
--
-- @param self  Callee reference.
-- @param key  Key to search in table representation.
-- @return Value associated with key, or `nil` if the key cannot be found.
local function find(self, key)
   assert(type(key) == 'table','Key must be in table representation. Got ' .. type(key) .. ': ' .. tostring(key))
   -- Start searching at root node.
   local node = self.root
   assert(type(node) == 'table', 'Trie root not found!')
   -- Iterate over key letters.
   for _,letter in ipairs(key) do
      -- Search matching edge.
      node = node[letter]
      if node == nil then
         return nil
      end
   end
   -- Return value associated with target node.
   return self.value[node]
end
M.find = find



--- Get buffer size used for reading files.
--
-- @param self  Callee reference.
-- @return Buffer size in bytes.
-- @see read_file
local function get_buffer_size(self)
   return self.file_buffer_size
end
M.get_buffer_size = get_buffer_size



--- Set buffer size used for reading files.
--
-- @param self  Callee reference.
-- @param buffer_size  New buffer size in bytes.
-- @return Old buffer size in bytes.
-- @see read_file
local function set_buffer_size(self, buffer_size)
   local old_buffer_size = self.file_buffer_size
   self.file_buffer_size = buffer_size
   return old_buffer_size
end
M.set_buffer_size = set_buffer_size



--- Get chunk iterator.
-- Reading records from files is done through a buffer.  This function
-- returns an iterator over the chunks.  You might want to refer to this
-- iterator when implementing a custom record iterator.  The file handle
-- argument is not closed.
--
-- @param self  Callee reference.
-- @param fin  Input file handle.
-- @return Chunk iterator.
-- @see read_file
-- @see file_records
-- @see set_buffer_size
-- @see get_buffer_size
local function file_chunks(self, fin)
   -- Check for valid file handle.
   assert(fin, 'Invalid input file handle.')
   -- Get local reference to buffer size.
   local BUFFERSIZE = self:get_buffer_size()

   return function ()
      -- Read next chunk.
      local chunk, rest = fin:read(BUFFERSIZE, '*l')
      -- EOF?
      if not chunk then
         return
      end
      if rest then chunk = chunk .. rest .. '\n' end
      return chunk
   end
end
M.file_chunks = file_chunks



--- Get record iterator.
-- This function returns an iterator over the records in a file.
-- Records are specified by the last argument, which must be a Lua
-- string pattern.  The file handle argument is not closed.
--
-- @param self  Callee reference.
-- @param fin  Input file handle.
-- @param rec_pattern  A Lua string pattern, determining what is
-- considered a record.
-- @return Record iterator.
-- @see read_file
-- @see file_chunks
-- @see set_buffer_size
local function file_records(self, fin, rec_pattern)
   -- Chunk iterator.
   local next_chunk = self:file_chunks(fin)
   -- Initialize chunk.
   local chunk = next_chunk() or ''
   local pos = 1

   return function()
      repeat
         local s, e = Ufind(chunk, rec_pattern, pos)
         -- Record found?
         if s then
            -- Update position.
            pos = e + 1
            -- Return record.
            return UAsub(chunk, s, e)
         else
            -- Read new chunk.
            chunk = next_chunk()
            -- EOF?
            if not chunk then
               return
            end
            pos = 1
         end
      until false
   end
end
M.file_records = file_records



--- Convert a record read from a file into a key to insert into trie.
-- By default, table representation of the record is returned.
--
-- @param self  Callee reference.
-- @param record  A record.
-- @return Key.
-- @see read_file
local function record_to_key(self, record)
   return self:key(record)
end
M.record_to_key = record_to_key



--- Convert a record read from a file into a value to be associated with
--- a key in trie.
-- By default, the value `true` is returned.
--
-- @param self  Callee reference.
-- @param record  A record.
-- @return Value.
-- @see read_file
local function record_to_value(self, record)
   return true
end
M.record_to_value = record_to_value



--- Insert a record, e.g., read from a file, into a trie, transforming
--- it into a key-value pair before.
-- This function is useful when reading records from a file manually,
-- e.g., when file records are filtered.
--
-- @param self  Callee reference.
-- @param record  A record.
-- @return Old value associated with key.
-- @see insert
-- @see record_to_key
-- @see record_to_value
local function insert_record(self, record)
   return self:insert(self:record_to_key(record), self:record_to_value(record))
end
M.insert_record = insert_record



--- Read a file and store the contents in trie.
-- This function callback driven reads a file and stores the contents in
-- the trie.  The given file handle is not closed.
--
-- Note, files are buffered while reading.  Lines in the input file are
-- always read as a whole into the buffer.  The record pattern is always
-- searched for in the current read buffer.  That is, records cannot be
-- larger than the file buffer.  In general, this is not a restriction.
-- If it is for you, you have to replace this function with a custom
-- one.
--
-- @param self  Callee reference.
-- @param fin  File handle to read records from.
-- @param rec_pattern  A Lua string pattern, determining what is
-- considered a record.  If this parameter is an empty string or `nil`,
-- records are considered complete lines (without line ending
-- characters).
-- @return Number new (keys, value) pairs stored in trie.
-- @see record_to_key
-- @see record_to_value
-- @see file_records
-- @see file_chunks
-- @see set_buffer_size
local function read_file(self, fin, rec_pattern)
   -- Initialize record pattern.
   if rec_pattern == nil or rec_pattern == '' then
      rec_pattern = '[^\n\r]+'
   end
   local count = 0
   for record in self:file_records(fin, rec_pattern) do
      local key = self:record_to_key(record)
      local value = self:record_to_value(record)
      local old_value = self:insert(key, value)
      if value ~= old_value and value ~= nil then
         count = count + 1
      end
   end
   return count
end
M.read_file = read_file



--- Count number of nodes in trie.
--
-- @param self  Callee reference.
-- @return Number of nodes.
local function count_nodes(self)
   -- Init visit upvalue.
   local n = 0
   -- Visit function.
   local function visit(self, node)
      -- Increment counter for every node.
      n = n + 1
   end
   -- Recurse into trie.
   self:dfs(visit)
   return n
end
M.count_nodes = count_nodes



--- Converts a value associated with a key in the trie into string.
--  By default, Lua's `tostring` function is applied to the value.
--
-- @param self  Callee reference.
-- @param value  A value.
-- @return String represenation of the value.
local function value_to_string(self, value)
   return tostring(value)
end
M.value_to_string = value_to_string



--- Visit function for outputting a trie in full format.
-- Values are separated from key by an equals sign `=`.
--
-- @param self  Callee reference.
-- @param data  Table with node related data.
-- @see debug_output
-- @see debug_dfs
local function debug_output_visit_full(self, data)
   local node = data.node
   local prefix = data.prefix
   -- Has current node an associated value?
   local value = self.value[node]
   if value ~= nil then
      -- Output key and value.
      io.write(Tconcat(prefix), '=', self:value_to_string(value), '\n')
   end
end
M.debug_output_visit_full = debug_output_visit_full



--- Visit function for outputting a trie in sparse format.
-- Values are separated from key by an equals sign `=`.
--
-- @param self  Callee reference.
-- @param data  Table with node related data.
-- @see debug_output
-- @see debug_dfs
local function debug_output_visit_sparse(self, data)
   local node = data.node
   local prefix = data.prefix
   -- Has current node an associated value?
   local value = self.value[node]
   local output
   if value ~= nil then
      -- Output key and value.
      output = { Tconcat(prefix), '=', self:value_to_string(value) }
   else
      -- Count child nodes.
      local cnt_childs = 0
      for letter,child in pairs(node) do
         cnt_childs = cnt_childs + 1
      end
      -- In sparse format, if a node has more than one child node,
      -- output current prefix immediately.  But not at root node.
      if cnt_childs > 1 and data.level > 0 then
         output = { Tconcat(prefix) }
      end
   end
   if output then
      Tinsert(output, '\n')
      io.write(Tconcat(output))
      -- In sparse format, output letters leading to this node only
      -- once.
      for i,_ in ipairs(prefix) do
         data.prefix[i] = ' '
      end
   end
end
M.debug_output_visit_sparse = debug_output_visit_sparse



--- Output a string representation of a trie to a file.
-- Values are separated from key by an equals sign `=`.  Default file
-- name is `trie.txt`.
--
-- @param self  Callee reference.
-- @param fname  Output file name.
-- @param is_sparse  flag: Output keys in sparse format?
-- @see debug_output_visit_full
-- @see debug_output_visit_sparse
local function debug_output(self, fname, is_sparse)
   -- Save current default output.
   local fout = io.output()
   -- Direct default output to a custom file.
   io.output(type(fname) == 'string' and fname ~= '' and fname or 'trie.txt')
   -- Choose visit function.
   local visit = is_sparse and self.debug_output_visit_sparse or self.debug_output_visit_full
   -- Traverse trie in DFS order.
   self:debug_dfs(visit)
   -- Flush output.
   io.flush()
   -- Restore default output.
   io.output(fout)
end
M.debug_output = debug_output



--- Determine a unique node name of a node for dot output.
--
-- @param node  A node.
-- @return A string.
-- @see debug_dot
local function debug_dot_nname(node)
   -- The address of a node's table is unique.
   local s = tostring(node):gsub('table: ', 'n')
   return s
end
M.debug_dot_nname = debug_dot_nname



--- Visit function that outputs a node in dot output.
-- Nodes associated with a value are emphasized.
--
-- @param self  Callee reference.
-- @param data  Table with node related data.
-- @see debug_dot
-- @see debug_bfs
local function debug_dot_visit_output_node(self, data)
   local node = data.node
   local nsource = debug_dot_nname(node)
   local source_attr = (self.value[node] ~= nil) and string.format('fillcolor="/greens7/2", fontname="Bold Italic"') or ''
   io.write(string.format('    %s [ label="%s", %s ]\n', nsource, table.concat(data.prefix), source_attr))
end
M.debug_dot_visit_output_node = debug_dot_visit_output_node



--- Output preamble for nodes of the same level in dot output.
-- Set rank=same attribute for nodes of the same level.
--
-- @param self  Callee reference.
-- @param level  Node level.
-- @see debug_dot
-- @see debug_bfs
local function debug_dot_level_preamble_output_node(self, level)
   io.write(string.format('\n// begin level %d\n', level))
   io.write('{ rank=same // dot\n')
end
M.debug_dot_level_preamble_output_node = debug_dot_level_preamble_output_node



--- Output postamble for nodes of the same level in dot output.
-- Close sub-graph.
--
-- @param self  Callee reference.
-- @param level  Node level.
-- @see debug_dot
-- @see debug_bfs
local function debug_dot_level_postamble_output_node(self, level)
   io.write('}\n')
   io.write(string.format('// end level %d\n\n', level))
end
M.debug_dot_level_postamble_output_node = debug_dot_level_postamble_output_node



--- Visit function that outputs a node's valid transition edges in dot
--- output.
--
-- @param self  Callee reference.
-- @param data  Table with node related data.
-- @see debug_dot
-- @see debug_dfs
local function debug_dot_visit_output_transition_edges(self, data)
   local node = data.node
   local nsource = debug_dot_nname(node)
   -- Sort outgoing letters to get more deterministic output.
   local a = {}
   for outletter,child in pairs(node) do
      table.insert(a, outletter)
   end
   table.sort(a)
   -- Output child nodes in deterministic order.
   for _,outletter in ipairs(a) do
      local child = node[outletter]
      local nsink = debug_dot_nname(child)
      io.write(string.format('    %s -> %s [ label="%s" ]\n', nsource, nsink, outletter))
   end
end
M.debug_dot_visit_output_transition_edges = debug_dot_visit_output_transition_edges



--- Output trie in graphviz dot format to a file.
-- See <URL:http://www.graphviz.org/doc/info/lang.html>.  Default file
-- name is `trie.dot`.
--
-- @param self  Callee reference.
-- @param fname  Output file name.
local function debug_dot(self, fname)
   -- Save current default output.
   local fout = io.output()
   -- Direct default output to a custom file.
   io.output(type(fname) == 'string' and fname ~= '' and fname or 'trie.dot')
   -- Begin graph.
   io.write(string.format([[
strict digraph trie {
  graph [
           root=%s, //circo, twopi
           rankdir=TB, // dot
//           ranksep=12, // dot, twopi
           ordering=out, // dot
           mode=ipsep, // neato
           outputorder=edgesfirst,
           splines=line,
        ]
  node [
          label="",
          style=filled,
          fillcolor=white,
       ]
  edge [
       ]

]], debug_dot_nname(self:get_root())
                         )
   )
   -- Output nodes.  BFS traversal order is relevant to properly apply
   -- `rank=same` attribute.
   self:debug_bfs(self.debug_dot_visit_output_node, self.debug_dot_level_preamble_output_node, self.debug_dot_level_postamble_output_node)
   -- Output transition edges.
   io.write('\n// begin transition edges\n')
   -- As long as outgoing edges are sorted in the visit function,
   -- traversal order is not relevant.  But see graph attribute
   -- `ordering`.
   self:debug_dfs(self.debug_dot_visit_output_transition_edges)
   io.write('// end transition edges\n\n')
   -- End graph.
   io.write('}\n')
   -- Flush output.
   io.flush()
   -- Restore default output.
   io.output(fout)
end
M.debug_dot = debug_dot



--- Initialize object.
--
-- @param self  Callee reference.
local function init(self)
   -- Call parent class initialization function on object.
   M.super.init(self)
   -- Root node.
   self.root = self:new_node()
   -- Table of values associated with nodes.
   self.value = {}
   -- Set default buffer size used for file reading.
   self:set_buffer_size(8*1024*1024)
end
M.init = init



-- Export module table.
return M
