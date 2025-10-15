#!/bin/bash

# Load shared configurations and utilities
source ./common.sh


execute_action() {
    local action_name="$1"  
    echo "--- Execute: $action_name ---"
    case "$action_name" in
        check_all) 
            echo "Running system pre-flight check..."
            check_build_requirements
        ;;
        download) 
            action_download
        ;;
        compile) 
            action_compile
        ;;   
        final_build) 
            action_final_build
        ;;  
        install) 
            action_install
        ;; 
        objects) 
            action_objects
        ;;                                  
        clean) 
            action_clean
        ;;              
        *)
            echo "Error: Unknown installation step '$step_name'." >&2
            exit 1
        ;;
    esac       
}


if [ -z "$1" ]; then
  echo "Usage: $0 <action>" >&2  
  exit 1
fi
execute_action "$1"