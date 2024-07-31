#!/bin/bash

set -e

# Set environment variables
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
apt-get update -y
apt-get install -y --no-install-recommends \
  wget \
  bzip2 \
  ca-certificates \
  curl \
  git \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxrender1 \
  libxext6 \
  software-properties-common

# Add deadsnakes PPA and install Python 3.7
add-apt-repository -y ppa:deadsnakes/ppa
apt-get update -y
apt-get install -y python3.7 python3.7-dev
rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install pip for Python 3.7
curl https://bootstrap.pypa.io/pip/3.7/get-pip.py -o get-pip.py
python3.7 get-pip.py
rm get-pip.py

# Upgrade pip
python3.7 -m pip install --upgrade pip

# Install Python dependencies
python3.7 -m pip install --no-cache-dir -r ./requirements.txt

# Download and prepare the dataset
cd ./imgur5k-dataset
python3.7 download_imgur5k.py
python3.7 prepare_dataset.py

# Run the main application
cd ../deep-text-edit
python3.7 run.py ./src/config/stylegan_adversarial.py
