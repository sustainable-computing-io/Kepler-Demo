FROM nvidia/cuda:12.1.0-devel-ubuntu22.04 AS dev

RUN apt-get update -y \
    && apt-get install -y python3-pip

# Install git and wget
RUN apt-get update && \
    apt-get install -y git wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Clone the specific branch of the repository
RUN apt-get update && \
    apt-get install -y git && \
    git clone --branch loadtesting https://github.com/wangchen615/vllm.git /app/vllm

# Install the required Python packages
RUN pip install -r /app/vllm/requirements-dev.txt && \
    pip install -r /app/vllm/requirements.txt

# Install the package in editable mode
RUN cd /app/vllm && pip install -e .

# Set environment variables for the benchmark script
ENV MAX_CONCURRENCY=1 \
    NUM_PROMPT=1 \
    MODEL='mistralai/Mistral-7B-v0.1' \
    DATA_SET_FILE='ShareGPT_V3_unfiltered_cleaned_split.json' \
    HOST='localhost' \
    PORT='8000'

# Set the working directory to the benchmark folder
WORKDIR /app/vllm/benchmarks

# Download the dataset
RUN wget https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json


# Command to run the Python script with environment variables
CMD python3 benchmark_serving_concurrency.py --backend openai-chat --host $HOST --port $PORT --endpoint /v1/chat/completions --max-concurrency $MAX_CONCURRENCY --num-prompts $NUM_PROMPT --model $MODEL --dataset ShareGPT_V3_unfiltered_cleaned_split.json --save-result
