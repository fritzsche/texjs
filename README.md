# TeXjs
This is another attempt to run **pdfLaTeX** in the browser.

It uses **emscripten** to compile `pdflatex` into **WebAssembly**.

The project is in a very early stage, so expect issues. However, it's provided early for everyone interested in getting **TeX Live** running in a web browser.

The provided `index.html` file and JavaScript glue code are solely for demonstration purposes.

To achieve a suitably fast TeX execution in the browser, especially considering the large TeX Live file system, a new custom virtual file system called **TEXFS** has been created for the emscripten runtime environment.

The project utilizes the **TeX Live** distribution and makes it executable in the browser.

---
## Building TeXjs
TeXjs was built on a Mac computer. Any Unix-like environment *might* work as well, but these are currently completely untested.

### Prerequisites
The following tools are the minimum required to run the installation:

* **C/C++ compiler chain** (for native compilation of tools like `tangle`, `tie`, etc.).
* **emscripten** build environment.
* **TeX environment** (MacTeX was used for development).
* **`wget`** to download various files.
* **`perl`** for running the TeX Live installer and `fmtutil`.
* **`nodejs`** to convert the TeX Live filesystem into object files.

---
## Installation

There are two build scripts that help automate the TeX Live build process and its installation into a format consumable by the **TEXFS** filesystem.

The installation is doing the following steps:

1) Creat the `build` folder and download TeXLive source code.
2) Build a native version of TeXLive to get tools like **tangle** or **tie**.
3) Build the **WebAssembly** version of TeXLive (some files need to be copied from the native build).
TEXFS filesystem support is build in the Javascipt glue code.
3) Install TeXLive (medium schema)
4) Run fmtutil to create the necessary format files.
5) Creat Object files for the **TEXFS** filesystem.


**WARNING**: Currently the scripts are doing very little checks/validations, but are kepts to the minimum that made them executable by the author. Please feel free and provide fixes for issues you find.

### `texjs_menu.sh`
Run `texjs_menu.sh` to execute the most important installation tasks. It provides a minimal text based gui.
## `texjs_install.sh`
This is doing the same steps as `texjs_menu.sh` but is more like a commandline tool without gui like environment.


## TEXFS Filesystem
The **TEXFS** emscripten filesystem is a very minimal **read-only** file system. The key difference is that files are **not instantiated when mounted**, but only upon read access. The necessary file parts are loaded from a backend source.

The complete file system is based on **objects**. These objects are stored as files whose filename is the **SHA1 hash** of their content. This is similar to the git version control system, as there are two kinds:

1.  **Trees**: Tree objects represent **folders** in the file system. Internally, they are JSON files containing the most important file attributes (such as name, file size, and the SHA1 hash of the file content).
2.  **Blobs**: Blob objects contain the actual **file content**.

The filesystem is implemented in the file `library_texfs.js`, which is linked with emscripten into the WebAssembly file.

To prepare the **TEXFS** filesystem, the `nodejs` program `texfs_objects.js` is used to convert the source files into these object files.