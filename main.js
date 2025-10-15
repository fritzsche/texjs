/* const dropZone = document.getElementById('dropZone');

// 1. Prevent default behavior for 'dragover' and 'dragleave'
['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropZone.addEventListener(eventName, (e) => {
        e.preventDefault();
        e.stopPropagation();
    }, false);
});

// Optional: Add visual feedback
dropZone.addEventListener('dragenter', () => dropZone.style.backgroundColor = '#f0f0f0');
dropZone.addEventListener('dragleave', () => dropZone.style.backgroundColor = 'white');


// 2. Handle the 'drop' event
dropZone.addEventListener('drop', (e) => {
    dropZone.style.backgroundColor = 'white'; // Reset background

    // The files are in the dataTransfer object
    const files = e.dataTransfer.files;

    for (const file of files) {
        console.log(`Dropped File: ${file.name}`);
        // Now use the FileReader, just like with the <input type="file">
        const reader = new FileReader();
        reader.onload = (event) => {
            // Process file data (e.g., read ArrayBuffer for a ZIP)
        };
        reader.readAsArrayBuffer(file);
        console.log("File: ",file.name)
    }
});


*/




const appendText = (element, text) => {
  const newDIV = document.createElement('div')
  newDIV.textContent = text
  element.appendChild(newDIV)
}
if (window.Worker) {
  const TexWorker = new Worker("./worker.js", { type: "module" })

  let pdfBlobUrl = null
  const openPdfButton = document.getElementById('openPdfButton')
  const compileButton = document.getElementById('compileButton')

  compileButton.onclick = function () {
    const texSource = texInput.value

    console.log('Send TeX source code to the worker...')

    
    // Send the compile command and the TeX-String to the Worker
    TexWorker.postMessage({
      command: 'compile',
      texContent: texSource,
      fileName: 'example.tex' // Filename this is stored in the virtual file system
    })
    compileButton.disabled = true
    compileButton.textContent = 'Erstelle PDF...'
  }

  TexWorker.onmessage = function (event) {
    const { command, data, message, fileName } = event.data
    switch (command) {
      case 'print':
        const output = document.getElementById('texOutput')
        if (output) {
          appendText(output, message)
        }

        break

      case 'pdfReady':
        // Receive the data
        const pdfArrayBuffer = data

        // Create a blob
        const pdfBlob = new Blob([pdfArrayBuffer], { type: 'application/pdf' })

        // This URL can be used by the browser
        if (pdfBlobUrl) {
          URL.revokeObjectURL(pdfBlobUrl)
        }
        pdfBlobUrl = URL.createObjectURL(pdfBlob)

        console.log('PDF-File received. Create temporary URL.')

        openPdfButton.onclick = function () {
/*
          const downloadLink = document.createElement('a')

          // 1. Die Blob-URL als Linkziel (href) setzen
          downloadLink.href = pdfBlobUrl

   
          downloadLink.download = 'example.pdf' 

   
          document.body.appendChild(downloadLink)
          downloadLink.click()
          document.body.removeChild(downloadLink)
*/


                   window.open(pdfBlobUrl, '_blank')
        }
        openPdfButton.disabled = false
        openPdfButton.textContent = 'PDF in neuem Tab öffnen'
        /*
                // Option: PDF in einem Iframe anzeigen (oder nur den Link zum Download/Anzeige)
                pdfViewer.src = pdfBlobUrl;
        
                // Option: Download-Link setzen
                downloadLink.href = pdfBlobUrl;
                downloadLink.download = fileName.split('/').pop() || 'example.pdf'; // Download-Name
                downloadLink.textContent = `Download: ${downloadLink.download}`;
                downloadLink.style.display = 'block';
                */
        break
    }
  }
}