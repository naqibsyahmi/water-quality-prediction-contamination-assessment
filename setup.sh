#!/bin/bash

# Get project root directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$SCRIPT_DIR"

echo "Project directory: $SCRIPT_DIR"

# Remove old venv if exists
if [ -d "venv" ]; then
    echo "Removing existing virtual environment..."

    rm -rf venv
fi

# Create fresh venv
echo "Creating fresh virtual environment..."

python3 -m venv venv

# Activate venv
echo "Activating virtual environment..."

source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."

pip install --upgrade pip

# Install requirements
echo "Installing requirements..."

pip install -r requirements.txt

# Install Jupyter kernel support
echo "Installing ipykernel..."

pip install ipykernel

# Remove old kernel if exists
echo "Removing old Jupyter kernel if exists..."

jupyter kernelspec uninstall river-water-quality-env -f

# Register new kernel
echo "Registering Jupyter kernel..."

python -m ipykernel install \
    --user \
    --name=river-water-quality-env \
    --display-name="River Water Quality Env"

echo "Setup completed successfully."