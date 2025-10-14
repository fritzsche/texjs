SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd -P)"
CURRENT_PATH="$PWD"
BASE_PATH=${SCRIPT_PATH}

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