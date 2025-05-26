#!/bin/bash

set -e  # Exit on error

echo "📦 Installing Miniconda..."

# Step 1: Create installation directory
mkdir -p ~/miniconda3

# Step 2: Download installer
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

# Step 3: Run installer silently
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

# Step 4: Clean up installer
rm ~/miniconda3/miniconda.sh

# Step 5: Activate and initialize conda
source ~/miniconda3/bin/activate
conda init --all

source ~/.bashrc
echo "✅ Miniconda installed and initialized. Restart shell or run 'source ~/.bashrc'."

echo "🐍 Creating Conda environment: llm_fft with Python 3.10..."

# Step 1: Ensure conda is available
source ~/miniconda3/bin/activate

# Step 2: Create the environment
conda create -y -n llm_fft python=3.10

# Step 3: Activate it
conda activate llm_fft

# Step 4: Install ipykernel
pip install ipykernel

# Step 5: Add Jupyter kernel
python -m ipykernel install --user --name=llm_fft --display-name "Python (llm_fft)"

echo "✅ Environment 'llm_fft' created, Jupyter kernel registered, and activated."

echo "📦 Installing unsloth. This may take some time..."
pip install unsloth

echo "🐍 Creating Conda environment: vllm_serve with Python 3.12..."

# Step 2: Create the environment
conda create -y -n vllm_serve python=3.12

# Step 3: Activate it
conda activate vllm_serve

# Step 4: Install ipykernel
pip install ipykernel

# Step 5: Add Jupyter kernel
python -m ipykernel install --user --name=vllm_serve --display-name "Python (vllm_serve)"

echo "✅ Environment 'vllm_serve' created, Jupyter kernel registered, and activated."
conda activate vllm_serve

echo "📦 Installing vllm. This may take some time..."
pip install -q vllm

echo "📦 Installing Jupyter Notebook in the base environment..."

# Step 1: Ensure conda is available
source ~/miniconda3/bin/activate

# Step 2: Install Jupyter in the base environment
conda activate base
pip install -q notebook

# Step 3: Set Jupyter password to '123'
echo "Setting Jupyter password..."
jupyter notebook password

# Step 5: Run Jupyter Notebook in the background
echo "✅ Jupyter Notebook installed and configured. Running it now..."
cd / && jupyter-notebook --allow-root --ip 0.0.0.0 --port 8888 &