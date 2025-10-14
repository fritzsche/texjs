DIALOG_HEIGHT=30
DIALOG_WIDTH=80


SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd -P)"
CURRENT_PATH="$PWD"
BASE_PATH=${SCRIPT_PATH}


# Path definitions
BASE_PATH="$(cd "$(dirname "$0")" && pwd -P)"
BUILD_SUB="build"
BUILD_PATH="${BASE_PATH%/}/${BUILD_SUB#}"

TEXLIVE_VERSION='20250308'
TEXLIVE_YEAR=${TEXLIVE_VERSION:0:4}
TEXLIVE_FILE="texlive-${TEXLIVE_VERSION}-source.tar.xz"


TEXLIVE_MIRROR='ftp://tug.org/'
TEXLIVE_MIRROR=${TEXLIVE_MIRROR%/}
TEXLIVE_DOWNLOAD="${TEXLIVE_MIRROR}/historic/systems/texlive/${TEXLIVE_YEAR}/${TEXLIVE_FILE}"


TEXLIVE_SRC_SUB="texlive-${TEXLIVE_VERSION}-source"
TEXLIVE_SRC_PATH="${BUILD_PATH%}/${TEXLIVE_SRC_SUB}" 


NATIVE_BUILD_PATH='texlive_binary_build'
TEXLIVE_NATIVE_BUILD_PATH="${BUILD_PATH%}/${NATIVE_BUILD_PATH#}" 
NATIVE_WEB2C_PATH="${TEXLIVE_NATIVE_BUILD_PATH%}/texk/web2c"

# emscripten build
EMSCRIPTEN_BUILD_PATH='texlive_emscripten_build'
TEXLIVE_EMSCRIPTEN_BUILD_PATH="${BUILD_PATH%}/${EMSCRIPTEN_BUILD_PATH#}" 

NATIVE_CONFIG_OPT="--without-x --disable-shared --disable-all-pkgs --enable-pdftex --enable-bibtex --enable-native-texlive-build"


EMSCRIPTEN_CC='emcc'
EMSCROPTEN_CFLAGS='-DELIDE_CODE -O3'
EMSCROPTEN_CXXFLAGS="-s EXPORTED_RUNTIME_METHODS='[\"FS\",\"ENV\",\"callMain\"]' -s MODULARIZE=1 -s EXPORT_ES6=1 -sALLOW_MEMORY_GROWTH -s INVOKE_RUN=0 -s MAXIMUM_MEMORY=2GB --js-library ${SCRIPT_PATH%}/library_texfs.js  "

TEXLIVE_EMSCRIPTEN_CONFIG_FILE="${TEXLIVE_SRC_PATH%}/configure"
EMSCRIPTEN_WEB2C_PATH="${TEXLIVE_EMSCRIPTEN_BUILD_PATH%}/texk/web2c"


# installing
TEXLIVE_INST_MIRROR='https://mirror.ctan.org/'
INSTALL_SUB=${BUILD_SUB} #"install"
INSTALL_PATH="${BASE_PATH%/}/${INSTALL_SUB#}"

TEXLIVE_INSTALLER_FILE='install-tl-unx.tar.gz'
TEXLIVE_INST_DOWNLOAD="${TEXLIVE_INST_MIRROR%/}/systems/texlive/tlnet/${TEXLIVE_INSTALLER_FILE}"
WGET='wget'
TEXLIVE_INST_FILE="${INSTALL_PATH%/}/${TEXLIVE_INSTALLER_FILE}" 

TEXLIVE_INST_PATH="${INSTALL_PATH%/}/texlive"

set_color() {
    if [[ "$TEXJS_INST_MODE" == 'DIALOG' ]]; then
        RESET=$'\x5CZn'
        RED=$'\x5CZ1'
        GREEN=$'\x5CZ2'
        YELLOW=$'\x5CZ3'
        BOLD=$'\x5CZb'
    else
        RESET=$'\e[0m'
        RED=$'\e[31m'
        GREEN=$'\e[32m'
        YELLOW=$'\e[33m'
        BOLD=$'\e[1m'
    fi
}

unset_color() {
        RESET=''
        RED=''
        GREEN=''
        YELLOW=''
        BOLD=''
}

set_color

# --- 1. ANSI Console Color Variables (for echo) ---
# \e is the Escape character (Octal \033, Hex \x1b)


check_dialog() {
    # Check if 'dialog' is installed
    if ! command -v dialog &> /dev/null
    then
        echo "The 'dialog' program is required for this script."    
        exit 1
    fi
}

check_execution_path() {
    # Check we execute in the main directory
    if [ "$SCRIPT_PATH" = "$CURRENT_PATH" ]; then
        echo "Starting the script"
    else
        dialog --title "Error" --msgbox "The script need to be started in the main folder." 7 50
        exit 1 
    fi
}

output_error_and_exit() {   
    local msg=$1
    if [[ "$TEXJS_INST_MODE" == 'DIALOG' ]]; then
        dialog --title "Error" --msgbox "${msg}" 7 50
        exit 1 
    else
        echo "${msg}"   
        exit 1
    fi
}

check_command() {
    local tool=$1
    # Check is a certain command exist
    echo -en "Checking for command ${BOLD}${tool}${RESET}: "
    if ! command -v ${tool} &> /dev/null 
    then
        echo -e "${RED}NOT FOUND${RESET}"  
    else
        echo -e "${GREEN}OK found${RESET}"             
    fi
}

output_action() {
   local action=$1
   echo -e "${BOLD}---- ${action} ----${RESET}"
}

output_skip() {
   local step=$1
   echo -e "${YELLOW}${BOLD}[SKIP] ${RESET} ${step}"
}


build_mkdir() {
    output_action 'Create build folder'
    if [ -d ${BUILD_PATH} ]; then
        output_skip "directory ${BUILD_PATH} already exist"
    else
        mkdir ${BUILD_PATH}   
    fi    
}

build_download() {
    TEXLIVE_SRC_FILE="${BASE_PATH%/}/${BUILD_SUB%/}/${TEXLIVE_FILE}"    
    output_action "Download TeXLive source code: ${TEXLIVE_SRC_FILE}"
    if [ -f ${TEXLIVE_SRC_FILE} ]; then
        output_skip "TeXLive source file ${TEXLIVE_SRC_FILE} already exist"
    else
        wget --directory-prefix=${BUILD_PATH} ${TEXLIVE_DOWNLOAD}
        cd ${BASE_PATH}
    fi
}

build_extract() {
    output_action "Exctract TeXLive into ${TEXLIVE_SRC_PATH}"
    if [ -d ${TEXLIVE_SRC_PATH} ]; then
        output_skip "TeXLive source path already exist"
    else
        cd ${BUILD_PATH}
        tar xJvf ${TEXLIVE_FILE}
        cd ${BASE_PATH}  
    fi
}


check_build_requirements() {
    check_command 'wget'
    check_command 'tar'
    check_command 'node'
    check_command 'emcc'
    check_command 'pdftex'    
}

action_download() {
    build_mkdir
    build_download
    build_extract     
}


build_native() {    
    output_action "Native TeXLive build in: ${TEXLIVE_NATIVE_BUILD_PATH}"
    if [ -d ${TEXLIVE_NATIVE_BUILD_PATH} ]; then
        output_skip "Build binary directory exit already"
    else
        cd ${BUILD_PATH}
        mkdir ${TEXLIVE_NATIVE_BUILD_PATH} 
        echo "Created ${TEXLIVE_NATIVE_BUILD_PATH}"

        cd ${TEXLIVE_NATIVE_BUILD_PATH} 
        NATIVE_CONFIG_OPT='--without-x --disable-shared --disable-all-pkgs --enable-pdftex --enable-bibtex --enable-native-texlive-build'
        TEXLIVE_SRC_CONFIG_FILE="${TEXLIVE_SRC_PATH%}/configure"
        ${TEXLIVE_SRC_CONFIG_FILE} ${NATIVE_CONFIG_OPT} && make -j
        NATIVE_WEB2C_PATH="${TEXLIVE_NATIVE_BUILD_PATH%}/texk/web2c"
        cd ${NATIVE_WEB2C_PATH} && make pdftex -j && make bibtex -j
    fi
}


# final emscripten build of pdflex
build_emscripten_final() {
    cd ${EMSCRIPTEN_WEB2C_PATH%}   
    #rm pdftex

    TEXFS_LIB_PATH=${SCRIPT_PATH}

    emmake make pdftex CC=emcc CXX=emcc \
    CXXFLAGS="-s EXPORTED_RUNTIME_METHODS='[\"FS\",\"ENV\",\"callMain\",\"TEXFS\"]' -s MODULARIZE=1 -s EXPORT_ES6=1 -s ALLOW_MEMORY_GROWTH -s INVOKE_RUN=0 -s MAXIMUM_MEMORY=2GB --js-library ${TEXFS_LIB_PATH}/library_texfs.js" \
    -o tangle -o tie -o web2c -o pdftex-pool.c
    cp pdftex ${SCRIPT_PATH%}/pdftex.js
    cp pdftex.wasm ${SCRIPT_PATH%}
}

build_em_copy_back() {
    output_action  "Copy files from native build into emscripten"
    cd ${NATIVE_WEB2C_PATH}
    chmod a+x ctangle tangle tie pdftex-pool.c
    cp -av ctangle tangle tie pdftex-pool.c ${EMSCRIPTEN_WEB2C_PATH%}
    cd ${NATIVE_WEB2C_PATH%}/web2c
    chmod a+x fixwrites splitup web2c
    cp -av fixwrites splitup web2c ${EMSCRIPTEN_WEB2C_PATH%}/web2c
}

build_emscripten() {    
    output_action  "Emscripten TeXLive build in: ${TEXLIVE_EMSCRIPTEN_BUILD_PATH}"
    if [ -d ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} ]; then
        output_skip "Build emscripten directory exit already"
    else
        cd ${BUILD_PATH}
        mkdir ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} 
        echo "Created ${TEXLIVE_EMSCRIPTEN_BUILD_PATH}"

        cd ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} 
        CC=${EMSCRIPTEN_CC} CFLAGS=${EMSCROPTEN_CFLAGS} EMCONFIGURE_JS=0 emconfigure ${TEXLIVE_EMSCRIPTEN_CONFIG_FILE} ${NATIVE_CONFIG_OPT}
        EMCONFIGURE_JS=0 emconfigure make
    fi
}


build_compile() {
    build_native
    build_emscripten
    build_em_copy_back
    build_emscripten_final
}

action_compile() {
  build_compile
}

action_final_build() {
  build_emscripten_final       
}

action_clean() {
   output_action "Cleaning" 
   rm -fr ${BUILD_PATH}
   echo -e "${GREEN}Finished${RESET}"        
}

make_profile() {
    output_action 'Generate profile'
	echo selected_scheme scheme-medium > ${INSTALL_PATH%}/input.profile
	echo tlpdbopt_create_formats 1 >> ${INSTALL_PATH%}/input.profile
	echo instopt_portable 1 >> ${INSTALL_PATH%}/input.profile
	echo TEXDIR `pwd`/texlive >> ${INSTALL_PATH%}/input.profile
	echo TEXMFLOCAL `pwd`/texlive/texmf-local >> ${INSTALL_PATH%}/input.profile
	echo TEXMFSYSVAR `pwd`/texlive/texmf-var >> ${INSTALL_PATH%}/input.profile
	echo TEXMFSYSCONFIG `pwd`/texlive/texmf-config >> ${INSTALL_PATH%}/input.profile
	echo TEXMFVAR `pwd`/home/texmf-var >> ${INSTALL_PATH%}/input.profile
}

download_installer() {
    output_action  "Download TeXLive Installer: ${TEXLIVE_INST_DOWNLOAD}"
    if [ -f ${TEXLIVE_INST_FILE} ]; then
        output_skip "TeXLive installer file ${BUILD_PATH} already exist"
    else
        wget --directory-prefix=${INSTALL_PATH} ${TEXLIVE_INST_DOWNLOAD}
    fi
}

action_install() {
   output_action "Install TeXLive" 
   download_installer
   cd ${INSTALL_PATH}
   tar xvfz ${TEXLIVE_INST_FILE}

   output_action "Start Download TeXLive" 
   make_profile   
   if [ -d ${TEXLIVE_INST_PATH} ]; then
      output_skip 'TeXLive Installation already done'
   else         
      install-tl-*/install-tl --profile input.profile
   fi  


   TEXLIVE_PATH='texlive'
   TEXLIVE_INSTALL_PATH="${INSTALL_PATH%/}/${TEXLIVE_PATH}" 

   TEXMFCNF=${TEXLIVE_INSTALL_PATH}
   TEXMFROOT=${TEXLIVE_INSTALL_PATH}
   FMTUTIL="${TEXLIVE_INSTALL_PATH%/}/texmf-dist/scripts/texlive/fmtutil.pl"
   
   # cleanup texlive
   cd ${TEXLIVE_INSTALL_PATH}
   rm -rf bin readme* tlpkg install* *.html texmf-dist/doc texmf-var/web2c
   cd ${INSTALL_PATH} 

    # run fmtutil to pre-build all format files
   WILDCARD_PATTERN="${INSTALL_PATH}/install-tl-2*"
   INSTALLER_PATH=( ${INSTALL_PATH}/install-tl-2* )

   PERL5LIB="${INSTALLER_PATH}"/tlpkg 
  
   PERL5LIB=${PERL5LIB} TEXMFROOT=${TEXMFROOT} ${FMTUTIL} -sys -all # --dry-run
   # generate object files
   node ../tl_objects 
}