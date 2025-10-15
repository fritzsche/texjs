import createModule from './pdftex.js'
import { ROOT_HASH } from './objects/root.js'
import { IndexDBCache } from './cache.js'

const TeXLiveFileObjects = {}

// Configuration of the emscripten module
const Module = {
    thisProgram: '/pdflatex',
    'print': (text) => {
        postMessage({
            command: 'print',
            message: text
        })
    },
    'printErr': (text) => { console.error('stderr: ' + text) },

    preRun: [async () => {
        console.log("Initialize the filesystem...")
        const FS = Module.FS

        const TEXFS = Module.TEXFS

        //  await IndexDBCache.loadFileObjectsFromIndexedDB(FileObjects)

        FS.chdir('/')
        //        FS.mkdir("/working")
        //        FS.chdir("/working")
        //        FS.createDataFile("/working", 'example.tex', example_tex, true, true)   

        //   FS.createLazyFile("/texlive", "texmf.cnf", "texlive/texmf.cnf", true, false)
        FS.createDataFile("/", Module.thisProgram, "dummy for kpathsea", true, true)

        //console.log(TeXLive)
        //initializeFS(FS)
        //const root_fs_hash = '032e36abb8411cdac23eb83318c475ce380aee4e'
        const root_fs_hash = ROOT_HASH
        //const root_fs_hash = 'f3c67207b857afff679a7ba18ca654e8f0e0172c'

        Module.FS.mkdir('/texlive')
        Module.FS.mount(TEXFS, {
            rootHash: root_fs_hash,
            debug: false,
            objects: TeXLiveFileObjects
        }, '/texlive')

        FS.mkdir("/working")
        FS.chdir("/working")
        // Set enviromengt variable to make TeX happy find all the path in /texlive
        const ENV = Module.ENV
        ENV.TEXMFCNF = '/texlive/:/texlive/texmf-dist/web2c/'
        ENV.TEXMFROOT = '/texlive'
        ENV.TEXMFLOCAL = '/texlive/texmf-local'
        ENV.TEXMFDIST = '/texlive/texmf-dist'
        ENV.TEXMFSYSVAR = '/texlive/texmf-var'
        ENV.TEXMFSYSCONFIG = '/texlive/texmf-config'
        ENV.TEXMFVAR = '/texlive/texmf-var'
        console.log("preRun: Setup Ready.")
    }],
}

console.log("Start restoring all the TeX Live VFS objects")
await IndexDBCache.loadFileObjectsFromIndexedDB(TeXLiveFileObjects)
console.log("Restore all the files from IndexDB finished.")
// Call the modules Factors Class and process the Promise
createModule(Module).then((instance) => {
    console.log("Modul-Instanz ready.")
    const FS = instance.FS
    const args = ['example.tex']
})

self.onmessage = function (event) {
    const { command, texContent, fileName } = event.data
    if (command === 'compile') {
        const pdfFileName = fileName.replace('.tex', '.pdf')
        try {
            Module.FS.writeFile(fileName, texContent, { encoding: 'utf8' })
            console.log(`TeX-File '${fileName}' in VFS saved. Starting pdflatex...`)
            const args = [fileName]
            Module.callMain(args)
            IndexDBCache.storeFileObjectsInIndexedDB(TeXLiveFileObjects)
            sendToMain(pdfFileName)
        } catch (e) {
            console.error('Error durign execution in worker', e)
            postMessage({
                command: 'error',
                message: `Error during pdf processing in worker: ${e.message}`
            })
        } finally {
            // Optional: Clean VFS
            // Module.FS.unlink(fileName); 
        }
    }
}


const sendToMain = (fileName) => {
    try {
        const fileContent = Module.FS.readFile(fileName, { encoding: 'binary' })
        postMessage({
            command: 'pdfReady',
            data: fileContent.buffer,
            fileName: fileName
        }, [fileContent.buffer])

    } catch (e) {
        console.error('Error sending PDF file', e)
        postMessage({
            command: 'error',
            message: 'Error while sending PDF to the main thread.'
        })
    }
}


