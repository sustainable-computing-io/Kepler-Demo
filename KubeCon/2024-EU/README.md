# Cloud Native Sustainable AI

Chen Wang, Eun Kyung Lee & Bo Wen, IBM Research

Huamin Chen, Red Hat

## Mission
It is well known that the energy consumption of developing (and deploying) Large Language Models (LLM) is becoming alarming rate [1]. Our broader mission is to 1) accurately quantify/account for the energy consumption of the entire cycle of AI model development, 2) evaluate any energy inefficiencies of utilizing hardware/software features in Cloud Native environment, and 3) optimize the performance and energy usage. 

Specifically in this demo, we will delve into the cutting-edge realm of energy implications of LLM inference, and discover how Kepler is employed to meticulously measure power consumption while processing different types of LLM inference workloads. Kepler is a CNCF Sandbox tool to measure pod-level energy in the Cloud environment. We will also demonstrate how to use the Multi-instance GPU (MIG) feature and frequency scaling in order to save energy for GPUs to process inference workloads.  

[1] https://spectrum.ieee.org/ai-energy-consumption

## Architecture

[Architecture](docs/Architecture.md)

## LLM and application

### Setup vLLM

### Setup Application
[LLM driven book club for cognitive health](twilight_chat/README.md) - 
[Twilight Chat](https://github.com/Twilight-Tales/Twilight-Chat)

Twilight Chat is a virtual book club host that helps elderly to engage in reading activities, in order to help 
mediate cognitive declines.

It is powered by Chainlit, Langchain, vLLM and OpenAI GPT-4 API.

### Quick Start on k8s

1. Set up environment variables:

    Copy `example.env` into `.env` and change the values.

2. Create secrets on k8s :
    ```bash
    kubectl create secret generic twilight-secret --from-env-file=.env
    ```
   (Or `make create-secret`)

3. Create pod and service:

    ```bash
    kubectl apply -f twilight-app-k8s.yaml
    ```
   (Or `make create-app`)

4. Port forward to access the app from host:

   ```bash
   kubectl port-forward service/twilight-service 1680:1680
   ```

## Measurement

[Measurement](docs/Measurement.md)

## Conclusion
