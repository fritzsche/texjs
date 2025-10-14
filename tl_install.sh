TEXLIVE_INST_MIRROR='https://mirror.ctan.org/'

# Base path is the path of the build.sh script
BASE_PATH="$(cd "$(dirname "$0")" && pwd -P)"

INSTALL_SUB="install"
INSTALL_PATH="${BASE_PATH%/}/${INSTALL_SUB#}"

TEXLIVE_INST_FILE='install-tl-unx.tar.gz'
TEXLIVE_INST_DOWNLOAD="${TEXLIVE_INST_MIRROR%/}/systems/texlive/tlnet/${TEXLIVE_INST_FILE}"
WGET='wget'

check_command_and_exit() {
  local command_name="$1"
  echo "Checking for ${command_name}"
  if ! command -v "$command_name" &> /dev/null; then
    # The `!` negates the success (0) status, so this block runs if 
    # `command -v` fails (non-zero status).
    echo "Error: Required command '$command_name' not found in PATH." >&2
    echo "Please install '$command_name' or ensure it's in your system's PATH." >&2
    exit 1
  # else: command was found, function returns successfully (exit status 0)
  fi
}


make_profile() {
    echo '** generate profile'
	echo selected_scheme scheme-basic > ${INSTALL_PATH%}/input.profile
	echo tlpdbopt_create_formats 1 >> ${INSTALL_PATH%}/input.profile
	echo instopt_portable 1 >> ${INSTALL_PATH%}/input.profile
	echo TEXDIR `pwd`/texlive >> ${INSTALL_PATH%}/input.profile
	echo TEXMFLOCAL `pwd`/texlive/texmf-local >> ${INSTALL_PATH%}/input.profile
	echo TEXMFSYSVAR `pwd`/texlive/texmf-var >> ${INSTALL_PATH%}/input.profile
	echo TEXMFSYSCONFIG `pwd`/texlive/texmf-config >> ${INSTALL_PATH%}/input.profile
	echo TEXMFVAR `pwd`/home/texmf-var >> ${INSTALL_PATH%}/input.profile
}

echo "Install TeXLive"
echo "================="
echo ""
echo "TEXLIVE_INST_DOWNLOAD: ${TEXLIVE_INST_DOWNLOAD}"


echo ""
echo "** create build folder: ${INSTALL_PATH}"
if [ -d ${INSTALL_PATH} ]; then
   echo "[SKIP] directory ${INSTALL_PATH} already exist"
else
    mkdir ${INSTALL_PATH}   
fi

TEXLIVE_INST_FILE="${INSTALL_PATH%/}/${TEXLIVE_INST_FILE}" 
echo ${TEXLIVE_INST_FILE}
echo ""
echo "** download TeXLive Installer: ${TEXLIVE_INST_DOWNLOAD}"
if [ -f ${TEXLIVE_INST_FILE} ]; then
   echo "[SKIP] TeXLive installer file ${BUILD_PATH} already exist"
else
   wget --directory-prefix=${INSTALL_PATH} ${TEXLIVE_INST_DOWNLOAD}
fi

cd ${INSTALL_PATH}
#tar xvfz ${TEXLIVE_INST_FILE}

make_profile


# 4347  export TEXMFCNF="/Users/thomas/devel/tex/tl/texlive" 
# 4353  export TEXMFCNF=".:/Users/thomas/devel/tex/tl/texlive" 
# 4433  export TEXINPUTS="/Users/thomas/devel/tex/tl/texlive/texmf-dist/source/latex/base:/Users/thomas/devel/tex/tl/texlive/texmf-dist/source/latex/l3kernel"
# 4454  export TEXMFROOT=/Users/thomas/devel/tex/tl/texlive
# 4531  export PERL5LIB=/Users/thomas/devel/tex/latexjs/texlive-20250308-source/texk/texlive/linked_scripts/texlive
# 4557  export PERL5LIB=/Users/thomas/devel/tex/tl/texlive/install-tl-20251009/tlpkg/TeXLive
# 4559  export PERL5LIB=/Users/thomas/devel/tex/tl/texlive/install-tl-20251009/tlpkg


#/Users/thomas/devel/tex/latexjs/texlive-20250308-source/texk/texlive/linked_scripts/texlive/fmtutil.pl -sys --all  

#export PERL5LIB=/Users/thomas/devel/tex/tl/texlive/install-tl-20251009/tlpkg     


TEXLIVE_PATH='texlive'
TEXLIVE_INSTALL_PATH="${INSTALL_PATH%/}/${TEXLIVE_PATH}" 

TEXMFCNF=${TEXLIVE_INSTALL_PATH}
TEXMFROOT=${TEXLIVE_INSTALL_PATH}

TEXLIVE_INSTALL_PATH="${INSTALL_PATH%/}/${TEXLIVE_PATH}" 
FMTUTIL="${TEXLIVE_INSTALL_PATH%/}/texmf-dist/scripts/texlive/fmtutil.pl"


echo "TeXLive installation path: ${TEXLIVE_INSTALL_PATH}"
echo "fmtutil: ${FMTUTIL}"

PATH="${PATH}"




#TEXMFROOT=${TEXMFROOT} ${FMTUTIL} -sys -all # --dry-run

check_command_and_exit "node"
cd ${INSTALL_PATH}

check_command_and_exit "node"
node ../tl_objects 

cd ${BASE_PATH}




