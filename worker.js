import createModule from './pdftex.js'
import { ROOT_HASH  } from './objects/root.js'

const FileObjects = {}

// Das Konfigurationsobjekt für das Emscripten-Modul
const Module = {
    thisProgram: '/pdflatex',
    //thisProgram: '/pdftex',    

    preRun: [() => {
        console.log("Initialize the filesystem...")
        const FS = Module.FS

        const TEXFS = Module.TEXFS

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
        Module.FS.mount(TEXFS,  { 
        rootHash: root_fs_hash, 
        debug: false, 
        objects: FileObjects }, '/texlive')

        FS.mkdir("/working")
        FS.chdir("/working")
     //   FS.createDataFile("/working", 'example.tex', example_tex, true, true)   


        const ENV = Module.ENV
        ENV.TEXMFCNF = '/texlive/:/texlive/texmf-dist/web2c/'
        ENV.TEXMFROOT = '/texlive'
        ENV.TEXMFLOCAL = '/texlive/texmf-local'
        ENV.TEXMFDIST = '/texlive/texmf-dist'
        ENV.TEXMFSYSVAR = '/texlive/texmf-var'
        ENV.TEXMFSYSCONFIG = '/texlive/texmf-config'
        ENV.TEXMFVAR = '/texlive/texmf-var'
        
        console.log("preRun: Dateisystem ist bereit.")



    }], 
}


// 2. Die Factory-Funktion aufrufen und das Promise verarbeiten
createModule(Module).then((instance) => {
    console.log("Modul-Instanz ready.")
     const FS = instance.FS
   
     const args = [  'example.tex'];
//     const args = ['pdftex', '-ini','-jobname=latex','-progname=latex','-translate-file=cp227.tcx','*latex.ini'];
 //    MyModule.callMain(args);
   //  sendToMain('example.pdf')

})

self.onmessage = function(event) {
    const { command, texContent, fileName } = event.data;

    if (command === 'compile') {
        const pdfFileName = fileName.replace('.tex', '.pdf'); 
    //    const workingDir = '/working'; // Das Verzeichnis, in dem pdflatex arbeitet
        
        try {

            Module.FS.writeFile(fileName, texContent, { encoding: 'utf8' });

            console.log(`TeX-Datei '${fileName}' im VFS gespeichert. Starte pdflatex...`);
            const args = [fileName];
            Module.callMain(args);
            sendToMain(pdfFileName)            
        } catch (e) {
            console.error('Fehler während der pdflatex-Ausführung im Worker:', e);
            postMessage({
                command: 'error',
                message: `Fehler beim Erstellen der PDF: ${e.message}`
            });
        } finally {
            // Optional: Aufräumarbeiten im VFS
            // Module.FS.unlink(fileName); 
        }
    }
};

// Behält die Definition der Sende-Funktion bei
function sendToMain(fileName) {
    // Nimmt jetzt den Dateinamen als Argument, da er variabel sein könnte
    
    try {
        const fileContent = Module.FS.readFile(fileName, { encoding: 'binary' });

        postMessage({
            command: 'pdfReady',
            data: fileContent.buffer, 
            fileName: fileName
        }, [fileContent.buffer]); 

    } catch (e) {
        console.error('Error sending PDF file', e);
        postMessage({
            command: 'error',
            message: 'Error while sending PDF to the main thread.'
        });
    }
}


