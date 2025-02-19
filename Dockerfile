# Start with the NVIDIA CUDA 12.2 base image on Ubuntu 22.04
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV APP_NAME=AllO-RAN
ENV PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
ENV HF_HOME=/data/hf_cache/

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    build-essential \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*



RUN pip3 install torch torchvision torchaudio
RUN pip3 install packaging ninja cpufeature numpy

# Set the working directory
WORKDIR /app


COPY . /app/ktransformers/
RUN cd ktransformers
RUN git submodule init
RUN git submodule update

# RUN python3 /app/llm_clean/install_model.py

# Add a label for the app name
LABEL app.name=$APP_NAME

ARG DATE=unknown

RUN chown -R 1001390000.1001390000 /app
# Keep the container running
CMD ["tail", "-f", "/dev/null"]
