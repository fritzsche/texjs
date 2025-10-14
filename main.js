if (window.Worker) {
  const myWorker = new Worker("./worker.js", { type: "module" });

let pdfBlobUrl = null;
const openPdfButton = document.getElementById('openPdfButton');
const compileButton = document.getElementById('compileButton');

compileButton.onclick = function() {
    const texSource = texInput.value;
    
    console.log('Sende TeX-Quellcode an Worker...');
    
    // Sende den Befehl und den TeX-String an den Worker
    myWorker.postMessage({
        command: 'compile',
        texContent: texSource,
        fileName: 'example.tex' // Dateiname, unter dem die Datei im VFS gespeichert wird
    });

    compileButton.disabled = true;
    compileButton.textContent = 'Erstelle PDF...';
};


myWorker.onmessage = function(event) {
    const { command, data, message, fileName } = event.data;

    if (command === 'pdfReady') {
        // 1. ArrayBuffer mit dem PDF-Inhalt empfangen (dies sind Binärdaten)
        const pdfArrayBuffer = data;

        // 2. Ein Blob-Objekt aus den Binärdaten erstellen
        const pdfBlob = new Blob([pdfArrayBuffer], { type: 'application/pdf' });
        
        // **Wichtig:** Eine temporäre URL für den Blob erstellen
        // Diese URL kann im Browser als reguläre Datei-URL behandelt werden.
        if (pdfBlobUrl) {
            URL.revokeObjectURL(pdfBlobUrl); // Alte URL freigeben
        }
        pdfBlobUrl = URL.createObjectURL(pdfBlob);

        console.log('PDF-Datei erfolgreich empfangen. Temporäre URL erstellt.');

        // 3. Option A: PDF in einem neuen Tab anzeigen
        openPdfButton.onclick = function() {
            window.open(pdfBlobUrl, '_blank');
        };
        openPdfButton.disabled = false;
        openPdfButton.textContent = 'PDF in neuem Tab öffnen';
/*
        // 4. Option B: PDF in einem Iframe anzeigen (oder nur den Link zum Download/Anzeige)
        pdfViewer.src = pdfBlobUrl;

        // 5. Option C: Download-Link setzen
        downloadLink.href = pdfBlobUrl;
        downloadLink.download = fileName.split('/').pop() || 'example.pdf'; // Download-Name
        downloadLink.textContent = `Download: ${downloadLink.download}`;
        downloadLink.style.display = 'block';
        */
        }
 }        

/*
  [first, second].forEach((input) => {
    input.onchange = () => {
      myWorker.postMessage([first.value, second.value]);
      console.log("Message posted to worker");
    };
  });*/
}