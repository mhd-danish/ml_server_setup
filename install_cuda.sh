#!/bin/bash

set -e  # Exit if any command fails

# Step 1: Download keyring
echo "Downloading CUDA keyring..."
wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb

# Step 2: Install keyring
echo "Installing CUDA keyring..."
sudo dpkg -i cuda-keyring_1.1-1_all.deb

# Step 3: Update APT
echo "Updating package lists..."
sudo apt-get update -y

# Step 4: Install CUDA Toolkit
echo "Installing CUDA Toolkit 12.5..."
sudo apt-get install -y cuda-toolkit-12-5

# Step 5: Install NVIDIA Driver
echo "Installing NVIDIA driver 555-open..."
sudo apt-get install -y nvidia-driver-555-open

# Step 6: Install CUDA driver 555
echo "Installing CUDA drivers 555..."
sudo apt-get install -y cuda-drivers-555

# Step 7: Add CUDA to PATH (optional but recommended)
if ! grep -q 'export PATH=/usr/local/cuda/bin:$PATH' ~/.bashrc; then
  echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
  echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
fi

echo "✅ CUDA & drivers installed. Reboot is recommended."

lsmod | grep nvidia

sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia_uvm

sudo rmmod nvidia

sudo lsof /dev/nvidia*

lsmod | grep nvidia

nvidia-smi
