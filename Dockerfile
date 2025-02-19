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
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements.txt from the docker directory
#COPY requirements.txt /app/requirements.txt

COPY . /app/llm_clean/
RUN pip3 install -r /app/llm_clean/requirements.txt
RUN bash install.sh

# Add a label for the app name
LABEL app.name=$APP_NAME

ARG DATE=unknown

RUN chown -R 1001390000.1001390000 /app
# Keep the container running
CMD ["tail", "-f", "/dev/null"]
