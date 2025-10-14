export class IndexDBCache {
    static async openDB() {
        return new Promise((resolve, reject) => {
            const request = indexedDB.open("FileCacheDB", 1)

            request.onupgradeneeded = (event) => {
                const db = event.target.result
                if (!db.objectStoreNames.contains("objects")) {
                    db.createObjectStore("objects")
                }
            }

            request.onsuccess = (event) => resolve(event.target.result)
            request.onerror = (event) => reject(event.target.error)
        })
    }
    static async storeFileObjectsInIndexedDB(FileObjects) {
        const db = await IndexDBCache.openDB()
        const tx = db.transaction("objects", "readwrite")
        const store = tx.objectStore("objects")

        for (const [hash, value] of Object.entries(FileObjects)) {
            store.put(value, hash)
        }

        return new Promise((resolve, reject) => {
            tx.oncomplete = () => resolve(true)
            tx.onerror = () => reject(tx.error)
        })
    }
    static async loadFileObjectsFromIndexedDB(FileObjects) {
        const db = await IndexDBCache.openDB()
        const tx = db.transaction("objects", "readonly")
        const store = tx.objectStore("objects")

        const allKeys = await new Promise((resolve, reject) => {
            const req = store.getAllKeys()
            req.onsuccess = () => resolve(req.result)
            req.onerror = () => reject(req.error)
        })

        for (const key of allKeys) {
            if (!(key in FileObjects)) {
                const value = await new Promise((resolve, reject) => {
                    const req = store.get(key)
                    req.onsuccess = () => resolve(req.result)
                    req.onerror = () => reject(req.error)
                })
                FileObjects[key] = value
            }
        }

        return FileObjects
    }
}