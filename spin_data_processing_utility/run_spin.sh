#!/bin/bash

# Script to run the SPIN model checker for the Data Processing Utility

# Check if Spin is installed
if ! command -v spin &> /dev/null; then
    echo "Error: Spin is not installed or not in PATH."
    echo "Please install Spin from http://spinroot.com/spin/INSTALL.html"
    exit 1
fi

# Compile the model
spin -a Main.spin
make -f pan

# Run the verification
./pan

# Optional: Generate HTML for visualization
spin -T Main.spin
gcc -o pan -O2 -DREACH pan.c
./pan
