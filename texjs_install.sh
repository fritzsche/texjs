#!/bin/bash

# Base path is the path of the build.sh script
BASE_PATH="$(cd "$(dirname "$0")" && pwd -P)"
BUILD_SUB="build"
BUILD_PATH="${BASE_PATH%/}/${BUILD_SUB#}"

TEXLIVE_VERSION='20250308'
TEXLIVE_YEAR=${TEXLIVE_VERSION:0:4}
TEXLIVE_FILE="texlive-${TEXLIVE_VERSION}-source.tar.xz"


TEXLIVE_MIRROR='ftp://tug.org/'
TEXLIVE_MIRROR=${TEXLIVE_MIRROR%/}
TEXLIVE_DOWNLOAD="${TEXLIVE_MIRROR}/historic/systems/texlive/${TEXLIVE_YEAR}/${TEXLIVE_FILE}"

abort_install() {
    if [ $? -ne 0 ]; then
        clear
        echo "Installation aborted."
        exit 0
    fi
}

# print most important parameter 
echo "Build texlive with emscripten"
echo "=============================="
echo ""
echo "BASE_PATH: ${BASE_PATH}"
echo "BUILD_PATH: ${BUILD_PATH}"
echo "TEXLIVE_MIRROR: ${TEXLIVE_MIRROR}"
echo "TEXLIVE_DOWNLOAD: ${TEXLIVE_DOWNLOAD}"



echo ""
echo "** create build folder: ${BUILD_PATH}"
if [ -d ${BUILD_PATH} ]; then
   echo "[SKIP] directory ${BUILD_PATH} already exist"
else
    mkdir ${BUILD_PATH}   
fi


TEXLIVE_SRC_FILE="${BASE_PATH%/}/${BUILD_SUB%/}/${TEXLIVE_FILE}" 
echo ""
echo "** download TeXLive source code: ${TEXLIVE_SRC_FILE}"
if [ -f ${TEXLIVE_SRC_FILE} ]; then
   echo "[SKIP] TeXLive source file ${BUILD_PATH} already exist"
else
   wget --directory-prefix=${BUILD_PATH} ${TEXLIVE_DOWNLOAD}
   cd ${BASE_PATH}
fi


TEXLIVE_SRC_SUB="texlive-${TEXLIVE_VERSION}-source"
TEXLIVE_SRC_PATH="${BUILD_PATH%}/${TEXLIVE_SRC_SUB}" 
echo ""
echo "** exctract TeXLive into ${TEXLIVE_SRC_PATH}"
if [ -d ${TEXLIVE_SRC_PATH} ]; then
   echo "[SKIP] TeXLive source path already exist"
else
    cd ${BUILD_PATH}
    tar xJvf ${TEXLIVE_FILE}
    cd ${BASE_PATH}  
fi


NATIVE_BUILD_PATH='texlive_binary_build'
TEXLIVE_NATIVE_BUILD_PATH="${BUILD_PATH%}/${NATIVE_BUILD_PATH#}" 



echo ""
echo "** native TeXLive build in: ${TEXLIVE_NATIVE_BUILD_PATH}"
if [ -d ${TEXLIVE_NATIVE_BUILD_PATH} ]; then
   echo "[SKIP] Build binary directory exit already"
else
    cd ${BUILD_PATH}
    mkdir ${TEXLIVE_NATIVE_BUILD_PATH} 
    echo "Created ${TEXLIVE_NATIVE_BUILD_PATH}"
fi


cd ${TEXLIVE_NATIVE_BUILD_PATH} 
NATIVE_CONFIG_OPT='--without-x --disable-shared --disable-all-pkgs --enable-pdftex --enable-bibtex --enable-native-texlive-build'
TEXLIVE_SRC_CONFIG_FILE="${TEXLIVE_SRC_PATH%}/configure"
echo ${TEXLIVE_SRC_CONFIG_FILE}


#${TEXLIVE_SRC_CONFIG_FILE} ${NATIVE_CONFIG_OPT} && make -j

NATIVE_WEB2C_PATH="${TEXLIVE_NATIVE_BUILD_PATH%}/texk/web2c"

#cd ${NATIVE_WEB2C_PATH} && make pdftex -j && make bibtex -j




EMSCRIPTEN_BUILD_PATH='texlive_emscripten_build'
TEXLIVE_EMSCRIPTEN_BUILD_PATH="${BUILD_PATH%}/${EMSCRIPTEN_BUILD_PATH#}" 
echo ""
echo "** emscripten TeXLive build in: ${TEXLIVE_EMSCRIPTEN_BUILD_PATH}"
if [ -d ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} ]; then
   echo "[SKIP] Build emscripten directory exit already"
else
    cd ${BUILD_PATH}
    mkdir ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} 
    echo "Created ${TEXLIVE_EMSCRIPTEN_BUILD_PATH}"
fi

cd ${TEXLIVE_EMSCRIPTEN_BUILD_PATH} 

NATIVE_CONFIG_OPT="--without-x --disable-shared --disable-all-pkgs --enable-pdftex --enable-bibtex --enable-native-texlive-build"
EMSCRIPTEN_CC='emcc'
EMSCROPTEN_CFLAGS='-DELIDE_CODE -O3'

TEXLIVE_EMSCRIPTEN_CONFIG_FILE="${TEXLIVE_SRC_PATH%}/configure"
#CC=${EMSCRIPTEN_CC} CFLAGS=${EMSCROPTEN_CFLAGS} EMCONFIGURE_JS=0 emconfigure ${TEXLIVE_EMSCRIPTEN_CONFIG_FILE} ${NATIVE_CONFIG_OPT}

#EMCONFIGURE_JS=0 emconfigure make

cd ${NATIVE_WEB2C_PATH}
EMSCRIPTEN_WEB2C_PATH="${TEXLIVE_EMSCRIPTEN_BUILD_PATH%}/texk/web2c"

chmod a+x ctangle tangle tie pdftex-pool.c
cp ctangle tangle tie pdftex-pool.c ${EMSCRIPTEN_WEB2C_PATH}

cd ${NATIVE_WEB2C_PATH%}/web2c

chmod a+x fixwrites splitup web2c
cp fixwrites splitup web2c ${EMSCRIPTEN_WEB2C_PATH%}/web2c
cd ${EMSCRIPTEN_WEB2C_PATH%}


#EMSCRIPTEN_CC='emcc' EMSCROPTEN_CFLAGS='-DELIDE_CODE -O3' emmake make pdftex -o tangle -o tie -o web2c -o pdftex-pool.c


cd ${BASE_PATH} 

