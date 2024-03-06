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

1. Create a local folder (for example, `/data/huggingface-cache`) on the host machine for downloading the models:
2. Download new models:
   ```bash
   docker run -ti   -v /data/huggingface-cache:/root/.cache/huggingface  --entrypoint=bash vllm/vllm-openai
   ```
3. Then inside the container, download the model:
   ```bash
   huggingface-cli download TheBloke/Llama-2-13B-chat-GPTQ TheBloke/Mistral-7B-Instruct-v0.2-GPTQ
   ```
4. Run the vLLM and other monitor services:
   ```bash
   kubectl apply -f vLLM/vllm-deployment.yaml
   ```

If you want to use other models, just change the value of `MODEL_NAME` 
in [vllm-deployment.yaml](vLLM%2Fvllm-deployment.yaml). For a complete list of support models, 
see [vLLM Supported Models](https://docs.vllm.ai/en/latest/models/supported_models.html).

Noted that:
1. The GPTQ (quantized version) of the model are supported by vLLM out of box. (`TheBloke/Llama-2-13B-chat-GPTQ` vs 
   `meta-llama/Llama-2-13b-hf`)
2. For models with chat or instruction fine-tuned variants but with same model architecture, i.e., 
   `Llama-2-13B-chat` vs `Llama-2-13b`, vLLM also supports both out of box. This feature is realized via  
   FastChat implementation in early days but changed to the more standardized method using HuggingFace chat-template.
   For more technical details, see this PR: 
   [Add Chat Template Support to vLLM](https://github.com/vllm-project/vllm/pull/1493)
3. To add a new models to vLLM, please refer to: 
   [vLLM Adding a New Model](https://docs.vllm.ai/en/latest/models/adding_model.html)

### Setup Application
[LLM driven book club for cognitive health](twilight_chat/README.md) - 
[Twilight Chat](https://github.com/Twilight-Tales/Twilight-Chat)

Twilight Chat is a virtual book club host that helps elderly to engage in reading activities, in order to help 
mediate cognitive declines.

It is powered by Chainlit, Langchain, vLLM and OpenAI GPT-4 API.

### Quick Start on k8s

1. Change path `cd twilight_chat`

2. Set up environment variables:

    Copy `example.env` into `.env` and change the values.

3. Create secrets on k8s :
    ```bash
    kubectl create secret generic twilight-secret --from-env-file=.env
    ```
   (Or `make create-secret`)

4. Create pod and service:

    ```bash
    kubectl apply -f twilight-app-k8s.yaml
    ```
   (Or `make create-app`)

5. Port forward to access the app from host:

   ```bash
   kubectl port-forward service/twilight-service 1680:1680
   ```

## Measurement

[Measurement](docs/Measurement.md)

## Conclusion
