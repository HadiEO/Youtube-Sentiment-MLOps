#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
VENV_DIR="$PROJECT_ROOT/venv"

# Set up the virtual environment
export VIRTUAL_ENV="$VENV_DIR"
export PATH="$VENV_DIR/Scripts:$PATH"

# Print confirmation
echo "Virtual environment activated. Using Python at: "
python.exe --version
echo "Type 'deactivate' to exit the virtual environment" 