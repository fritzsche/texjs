// library_texfs.js
// Content-Addressed File System (Git-like) for Emscripten.
// - Contents (Blobs/Trees) are fetched synchronously via /objects/<hash>.
// - Implements In-Memory caching for all loaded objects.
// - Compression removed.

var TEXFS = {

    // Global in-memory cache: Stores loaded Tree structures (as object maps) 
    // and Blob contents (as Uint8Array), indexed by hash code.
    // This object can be shared across multiple VFS mounts (e.g., Module instances) 
    // if passed via mount.opts.objects.
    objectCache: {}, 
    debug: false, // Flag to control console logging

    _throwReadOnlyError() {
      throw new FS.ErrnoError(70); // EROFS
    },
    
    // ====================================================================
    // HELPER FUNCTIONS FOR CACHE & NETWORK
    // ====================================================================

    // Performs a synchronous HTTP request to load the object and store it in the cache.
    fetchObject(hash, type) {
        // 1. CACHE HIT: Return immediately from memory
        if (TEXFS.objectCache[hash]) {
            if (TEXFS.debug) console.log(`[TEXFS Cache] Hit for ${type} object: ${hash.substring(0, 8)}`);
            return TEXFS.objectCache[hash];
        }

        // 2. CACHE MISS: Start synchronous HTTP request
        const url = `objects/${hash}`; 
        if (TEXFS.debug) console.log(`[TEXFS HTTP] Starting synchronous fetch for ${type} object: ${url}`);
        
        const request = new XMLHttpRequest();
        request.open('GET', url, false); 
        request.responseType = 'arraybuffer'; // Crucial to get binary data
        
        try {
            request.send(null);
        } catch (e) {
            console.error(`[TEXFS HTTP] Error sending XHR request for ${url}:`, e);
            throw new FS.ErrnoError(59); // EIO
        }

        if (request.status === 200 || request.status === 0) { 
            const dataBuffer = new Uint8Array(request.response);
            let result;

            if (type === 'tree') {
                // Tree is an uncompressed JSON file
                const jsonString = new TextDecoder().decode(dataBuffer);
                try {
                    const treeData = JSON.parse(jsonString);
                    // Index the JSON array for fast lookup
                    const entryMap = {};
                    treeData.forEach(entry => { entryMap[entry.name] = entry; });
                    result = entryMap; // Store the map

                } catch (e) {
                    console.error(`[TEXFS PARSE] JSON parse error for Tree ${hash}:`, e);
                    throw new FS.ErrnoError(5); // EBADF (Corrupt data)
                }
            } else { // type === 'blob'
                // Blob is the raw, uncompressed binary content
                result = dataBuffer; // Store the Uint8Array
            }

            // 3. CACHE WRITE: Store the result in the global cache
            TEXFS.objectCache[hash] = result;
            return result;
        } 
        
        if (request.status === 404) {
            console.error(`[TEXFS HTTP] Object not found (404): ${url}`);
            throw new FS.ErrnoError(44); // ENOENT
        }
        
        console.error(`[TEXFS HTTP] Server error (${request.status}) fetching ${url}`);
        throw new FS.ErrnoError(59); // EIO
    },

    // ====================================================================
    // MOUNT & CREATE NODE 
    // ====================================================================

    mount(mount) {
      // 1. Setup global state (Cache and Debug)
      if (mount.opts.objects && typeof mount.opts.objects === 'object') {
          // Use an externally provided cache object, allowing reuse across module instances.
          TEXFS.objectCache = mount.opts.objects;
      } else {
          // Ensure it's initialized as an empty object if not provided (though initialized above).
          TEXFS.objectCache = {}; 
      }
      
      TEXFS.debug = mount.opts.debug || false; // Set debug flag

      const rootHash = mount.opts.rootHash;
      if (!rootHash) {
          console.error("[TEXFS Mount] Error: Root hash must be passed in mount.opts.rootHash.");
          throw new Error("Missing rootHash option for TEXFS mount.");
      }
      
      if (TEXFS.debug) console.log(`[TEXFS Mount] Creating root node with hash: ${rootHash}`);
      
      // Root is always a directory/Tree. mode = S_IFDIR | 0o555 (read/execute)
      const root = TEXFS.createNode(null, '/', 0o555 | 16384, 0);
      root.hash = rootHash; 
      root.type = 'tree';
      
      return root; 
    },
    
    createNode(parent, name, mode, dev) {
      const node = FS.createNode(parent, name, mode, dev);
      
      if (FS.isDir(node.mode)) {
        node.node_ops = TEXFS.ops_table.dir.node;
        node.stream_ops = TEXFS.ops_table.dir.stream;
        node.contents = {}; // Cache for created child nodes (FSNodes)
        node.treeEntries = null; // Local cache for loaded Tree JSON data (Pointer to global cache entry)
      } else if (FS.isFile(node.mode)) {
        node.node_ops = TEXFS.ops_table.file.node;
        node.stream_ops = TEXFS.ops_table.file.stream;
        
        node.contents = null; // Blob content (Uint8Array)
        node.usedBytes = 0;   
        node.hash = null;     
        node.type = 'blob';   
      }
      node.atime = node.mtime = node.ctime = Date.now();
      
      if (parent && name !== '/') { 
        parent.contents[name] = node;
      }
      return node;
    },
    
    ops_table: { 
        dir: {
          node: {
            getattr: function(node) { return TEXFS.node_ops.getattr(node); },
            lookup: function(parent, name) { return TEXFS.node_ops.lookup(parent, name); },
            readdir: function(node) { return TEXFS.node_ops.readdir(node); },
            setattr: function() { TEXFS._throwReadOnlyError(); }, mknod: function() { TEXFS._throwReadOnlyError(); },
            rename: function() { TEXFS._throwReadOnlyError(); }, unlink: function() { TEXFS._throwReadOnlyError(); },
            rmdir: function() { TEXFS._throwReadOnlyError(); }, symlink: function() { TEXFS._throwReadOnlyError(); }
          },
          stream: {
            llseek: function(stream, offset, whence) { return TEXFS.stream_ops.llseek(stream, offset, whence); }
          }
        },
        file: {
          node: {
            getattr: function(node) { return TEXFS.node_ops.getattr(node); },
            setattr: function() { TEXFS._throwReadOnlyError(); }
          },
          stream: {
            read: function(stream, buffer, offset, length, position) { return TEXFS.stream_ops.read(stream, buffer, offset, length, position); },
            llseek: function(stream, offset, whence) { return TEXFS.stream_ops.llseek(stream, offset, whence); },
            write: function() { TEXFS._throwReadOnlyError(); }, mmap: function() { TEXFS._throwReadOnlyError(); },
            msync: function() { TEXFS._throwReadOnlyError(); }
          }
        }
    },
    
    // ====================================================================
    // BASE OPS: READ, LOOKUP, REaddir
    // ====================================================================
    
    // Loads and indexes the Tree object (JSON) if it's not already in the cache.
    loadTree(node) {
        // fetchObject manages the global cache and JSON indexing.
        const treeEntries = TEXFS.fetchObject(node.hash, 'tree'); 
        
        // Store the TreeEntries locally on the node to ensure direct access and consistency.
        if (!node.treeEntries) {
             node.treeEntries = treeEntries; 
        }
        return treeEntries;
    },
    
    node_ops: { 
      getattr(node) {
        const attr = {};
        attr.dev = 1; attr.ino = node.id; attr.mode = node.mode; attr.nlink = 1;
        attr.uid = 0; attr.gid = 0; attr.rdev = node.rdev;
        
        // File size (Blob) or default size (Tree/Dir)
        attr.size = FS.isDir(node.mode) ? 4096 : node.usedBytes; 
        
        attr.atime = new Date(node.atime); attr.mtime = new Date(node.mtime); attr.ctime = new Date(node.ctime);
        attr.blksize = 4096;
        attr.blocks = Math.ceil(attr.size / 4096);
        return attr;
      },
      
      lookup(parent, name) {
        if (TEXFS.debug) console.log(`[TEXFS Lookup] Called for: "${name}" in parent: "${parent.name}" (Hash: ${parent.hash.substring(0, 8)})`);

        // 1. FSNode Cache Check (Check if the FSNode for this entry has already been created)
        if (parent.contents.hasOwnProperty(name)) {
             if (TEXFS.debug) console.log(`[TEXFS Lookup] FSNode cache hit for "${name}"`);
             return parent.contents[name];
        }
        
        // 2. Load Parent Tree Data (uses global cache or fetches)
        const treeEntries = TEXFS.loadTree(parent); 
        
        // 3. Find entry in Tree Data
        const entry = treeEntries[name];
        
        if (entry) {
            if (TEXFS.debug) console.log(`[TEXFS Lookup] Tree hit for "${name}" (Type: ${entry.type}, Hash: ${entry.hash.substring(0, 8)})`);
            
            let newNode;
            let mode = parseInt(entry.mode, 8); // Mode is Octal string in the Git object
            
            if (entry.type === 'tree') {
                // Create directory (Tree)
                newNode = TEXFS.createNode(parent, name, mode | 16384, 0); // 16384 = S_IFDIR
                newNode.hash = entry.hash; 
                newNode.type = 'tree';
                
            } else if (entry.type === 'blob') {
                // Create file (Blob)
                newNode = TEXFS.createNode(parent, name, mode | 32768, 0); // 32768 = S_IFREG
                newNode.hash = entry.hash; 
                newNode.type = 'blob';
                // Important: size is the uncompressed Blob size from the Tree entry
                newNode.usedBytes = entry.size; 
            }
            
            return newNode;
        }

        if (TEXFS.debug) console.log(`[TEXFS Lookup] NOT found: "${name}" in Tree ${parent.hash.substring(0, 8)}`);
        throw new FS.ErrnoError(44); // ENOENT
      },
      
      readdir(node) {
        if (TEXFS.debug) console.log(`[TEXFS ReadDir] Called for: "${node.name}" (Hash: ${node.hash.substring(0, 8)})`);

        let entries = ['.', '..'];
        
        // Load Tree data to know all children (uses global cache)
        const treeEntries = TEXFS.loadTree(node);

        for (const name in treeEntries) {
            entries.push(name);
        }
        
        return entries;
      }
    },
    
    stream_ops: { 
      read(stream, buffer, offset, length, position) {
        
        // --- CRITICAL STEP: BLOB CONTENT FETCH ---
        if (stream.node.contents === null) {
             if (TEXFS.debug) console.log(`[TEXFS READ] Content fetch required for Blob ${stream.node.hash.substring(0, 8)}`);
             try {
                // Fetches the Blob content (uses global cache or loads synchronously)
                const fileData = TEXFS.fetchObject(stream.node.hash, 'blob'); 
                
                // Store the content locally on the node as a reference (saves lookup time later)
                stream.node.contents = fileData;
                stream.node.usedBytes = fileData.length;
                if (TEXFS.debug) console.log(`[TEXFS READ] Blob ${stream.node.hash.substring(0, 8)} loaded. Size: ${fileData.length}`);
            } catch (e) {
                throw e; 
            }
        }
        // --- END CONTENT FETCH ---

        const contents = stream.node.contents;


        const availableBytes = contents.length - position;
        if (position >= stream.node.usedBytes) return 0;
        
        const size = Math.min(availableBytes, length);
        
        if (contents.subarray) {
          buffer.set(contents.subarray(position, position + size), offset);
        } else {
          for (let i = 0; i < size; i++) {
            buffer[offset + i] = contents[position + i];
          }
        }
        //stream.position += size;
        return size;
      },
      
      llseek(stream, offset, whence) {
        let position = offset;
        if (whence === 1) { 
          position += stream.position;
        } else if (whence === 2) { 
          if (FS.isFile(stream.node.mode)) {
            // SEEK_END relies on usedBytes, which is set during lookup from the Tree entry.
            position += stream.node.usedBytes;
          }
        }
        if (position < 0) {
          throw new FS.ErrnoError(28); // EINVAL
        }
        return position;
      }
    }
};

autoAddDeps(TEXFS, '$FS');
mergeInto(LibraryManager.library, {
  $TEXFS: TEXFS
});
