#!/bin/bash

TEXJS_INST_MODE='DIALOG'
# Load shared configurations and utilities
source ./common.sh


check_all() {
  local OUTPUT_FILE=$(mktemp)
  check_build_requirements  collect_messages > "$OUTPUT_FILE"
   dialog --colors --title "Check if build tools" \
       --msgbox "$(cat "$OUTPUT_FILE")" \
       $DIALOG_HEIGHT $DIALOG_WIDTH 
   rm "$OUTPUT_FILE"
}


perform_action() {
    local command=$1
    local title=$2
    unset_color  
    ${command}  | dialog --colors   --title "$title" --programbox $DIALOG_HEIGHT $DIALOG_WIDTH
    JOB_EXIT_STATUS=${pipestatus[1]}
    set_color
}

# --- Main Menu Loop ---
main_menu() {
# check we have the dialog tool    
  check_dialog
  check_execution_path

  while true; do  
    # Use 'dialog --menu' to display choices
    CHOICE=$(dialog --backtitle "TeX.js Setup Menu" \
      --title "Installation Steps" \
      --menu "Select an action. " 20 70 10 \
      1 "Check Build Requirements" \
      2 "Download TeXLive source" \
      3 "Compile TeXLive for emscripten" \
      4 "Install TeXLive and generate object" \
      5 "Exit Installer" \
      2>&1 >/dev/tty)
      
    local menu_exit_status=$?

    if [ $menu_exit_status -ne 0 ] || [ -z "$CHOICE" ]; then
      # User pressed Cancel or Escape/Closed the dialog
      CHOICE=5
    fi

    case $CHOICE in
      1)
        check_all
        ;;
      2)
        perform_action action_download 'Download TeXLive'
        ;;
      3)
        perform_action action_compile 'Compile TeXLive'
        ;;
      4)
        perform_action action_install 'Install TeXLive'
        ;;
      5)
        dialog --msgbox "Exiting Installer. Goodbye!" 5 40
        clear
        exit 0
        ;;
    esac
    
 done
}

# Execute the main program
main_menu
