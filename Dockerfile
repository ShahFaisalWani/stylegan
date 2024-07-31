# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update --fix-missing && \
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
  ruby \
  software-properties-common && \
  add-apt-repository -y ppa:deadsnakes/ppa && \
  apt-get update && \
  apt-get install -y python3.7 python3.7-dev && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install pip for Python 3.7
RUN curl https://bootstrap.pypa.io/pip/3.7/get-pip.py -o get-pip.py && \
  python3.7 get-pip.py && \
  rm get-pip.py

# Upgrade pip
RUN python3.7 -m pip install --upgrade pip

RUN gem install yadisk

# Create a directory for the application
WORKDIR /stylegan

# Copy the application files to the container
COPY deep-text-edit /stylegan/deep-text-edit
COPY imgur5k-dataset /stylegan/imgur5k-dataset
COPY entrypoint.sh /stylegan/entrypoint.sh
COPY requirements.txt /stylegan/requirements.txt

# Install Python dependencies
RUN python3.7 -m pip install --no-cache-dir -r /stylegan/requirements.txt

# Download, extract, and remove the Yandex Disk zip content
RUN yadisk https://disk.yandex.ru/d/gTJa6Bg2QW0GJQ /stylegan/deep-text-edit/archive.zip && \
  unzip /stylegan/deep-text-edit/archive.zip -d /stylegan/deep-text-edit && \
  rm /stylegan/deep-text-edit/archive.zip

# Make entrypoint.sh executable
RUN chmod +x /stylegan/deep-text-edit/entrypoint.sh

# Set the entry point script to be run when the container starts
ENTRYPOINT ["/stylegan/entrypoint.sh"]
