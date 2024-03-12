# Benchmarking Load Tester Tutorial

This tutorial guides you through the process of setting up and running a benchmarking experiment using our provided scripts and configurations. The steps include building a Docker image, deploying a persistent volume, managing secrets, and configuring the experiment.

## Prerequisites

- Docker installed on your machine.
- Kubernetes cluster access and `kubectl` configured to interact with your cluster.
- A Docker registry account (e.g., on quay.io) and your `<user_id>` ready.
- Your HuggingFace token base64 encoded as `<hg_base64_token>`.

## Setup Instructions

### 1. Building and Pushing the Docker Image

First, you need to build the Docker image from the provided `Dockerfile` and then push this image to your Docker registry.

```bash
# Navigate to the benchmark subfolder
cd benchmark

# Build the Docker image
docker build -t quay.io/<user_id>/benchmark-load-tester:latest .

# Push the Docker image to the registry
docker push quay.io/<user_id>/benchmark-load-tester:latest
```

### 2. Deploying the Persistent Volume
To store all benchmarking results, you need to create a persistent volume in your Kubernetes cluster.
```bash
kubectl create -f benchmark-pv.yaml
```

### 3. Managing the HuggingFace Secret
Ensure that the **huggingface-secret** secret exists in your cluster to allow the load tester to fetch the tokenizer from HuggingFace Hub. If it doesn't exist, create the secret with your base64 encoded HuggingFace token.
```bash
kubectl create secret generic huggingface-secret --from-literal=HF_TOKEN='<hg_base64_token>'
```

### 4. Configuring the Experiment
Create a **.env** file in the benchmark subfolder to configure the experiment. This file should include all necessary environment variables for your benchmarking session. Use the provided **template.env** as a starting point and adjust the values as needed for your experiment.
```bash
# Copy the template to a new .env file
cp template.env .env

# Edit the .env file with your preferred editor and configure the variables
vi .env
```

### 5. Run the Load Testing job.
With your Docker image pushed, persistent volume deployed, secrets configured, and environment variables set up, you're now ready to run the load testing job. This involves creating a ConfigMap from your **.env** file and then deploying the Kubernetes job defined in **loadtesting-job.yaml**.
```bash
# Create a ConfigMap named vllm-benchmark-config from the .env file
kubectl create configmap vllm-benchmark-config --from-env-file=.env

# Deploy the load testing job to the cluster
kubectl create -f loadtesting-job.yaml
```
This will start the load testing job in your Kubernetes cluster using the configurations specified. The job will use the persistent volume to store benchmarking results and the secret to access the HuggingFace tokenizer.

## Running the Benchmark
After completing the setup, you can conduct various benchmarking experiments to analyze model performance, including throughput and latency, under different conditions. Below are three experiments you can run:

1. Standard Benchmarking

This experiment assesses the model's performance, including throughput and latency, under varying load levels and dataset sizes.
```bash
./benchmark.sh
```

2. Benchmarking with GPU Frequency Adjustments

This experiment is similar to the standard benchmarking; however, it adjusts the GPU clock frequencies to different levels for each experiment round, providing insights into how GPU frequencies impact the model's performance.
```bash
# Run the benchmark with GPU frequency adjustments
./benchmark-gpu-freq.sh
```
This will give you a comparative analysis of model performance across different GPU frequency settings, allowing for optimizations based on energy efficiency or computational speed.

3. Adjusting GPU Frequencies Without Workload

This experiment focuses solely on adjusting the GPU frequency every 10 minutes to 4 different frequency levels, without running any workload. It's useful for testing the effects of frequency changes on the system without the variable of workload performance.
```
# Adjust GPU frequencies at intervals without running a workload
./adjust_gpu_freq.sh
```

## Summarizing Results
After conducting the experiments, you can summarize all experiment results into a single CSV file for easier analysis and comparison.
```
# Summarize the results of all experiments
./summarize_results.sh <rst_folder>
```
