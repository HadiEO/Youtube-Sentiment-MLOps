#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
VENV_DIR="$PROJECT_ROOT/venv"
VENV_SCRIPTS="$VENV_DIR/Scripts"

# Function to check if we're in the virtual environment
in_venv() {
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to add venv Scripts to PATH if not already there
setup_path() {
    if [[ ":$PATH:" != *":$VENV_SCRIPTS:"* ]]; then
        export PATH="$VENV_SCRIPTS:$PATH"
    fi
}

case "$1" in
    "python")
        setup_path
        "$VENV_SCRIPTS/python.exe" "${@:2}"
        ;;
    "pip")
        setup_path
        "$VENV_SCRIPTS/pip.exe" "${@:2}"
        ;;
    "pytest")
        setup_path
        "$VENV_SCRIPTS/pytest.exe" "${@:2}"
        ;;
    "black")
        setup_path
        "$VENV_SCRIPTS/black.exe" "${@:2}"
        ;;
    "isort")
        setup_path
        "$VENV_SCRIPTS/isort.exe" "${@:2}"
        ;;
    "flake8")
        setup_path
        "$VENV_SCRIPTS/flake8.exe" "${@:2}"
        ;;
    "pre-commit")
        setup_path
        "$VENV_SCRIPTS/pre-commit.exe" "${@:2}"
        ;;
    "setup")
        # Initialize git if not already initialized
        if [ ! -d ".git" ]; then
            git init
        fi
        # Install pre-commit hooks
        setup_path
        "$VENV_SCRIPTS/pre-commit.exe" install
        ;;
    "test")
        setup_path
        "$VENV_SCRIPTS/pytest.exe" tests/ -v --cov=src
        ;;
    "format")
        setup_path
        "$VENV_SCRIPTS/black.exe" src tests
        "$VENV_SCRIPTS/isort.exe" src tests
        ;;
    "lint")
        setup_path
        "$VENV_SCRIPTS/flake8.exe" src tests
        ;;
    "check")
        # Run all checks: format, lint, and test
        "$0" format
        "$0" lint
        "$0" test
        ;;
    *)
        echo "Usage: $0 <command> [args...]"
        echo "Available commands:"
        echo "  python     - Run Python from virtual environment"
        echo "  pip       - Run pip from virtual environment"
        echo "  pytest    - Run pytest"
        echo "  black     - Run black formatter"
        echo "  isort     - Run isort"
        echo "  flake8    - Run flake8"
        echo "  pre-commit - Run pre-commit"
        echo "  setup     - Set up git and pre-commit hooks"
        echo "  test      - Run tests with coverage"
        echo "  format    - Format code with black and isort"
        echo "  lint      - Run linting checks"
        echo "  check     - Run all checks (format, lint, test)"
        ;;
esac 