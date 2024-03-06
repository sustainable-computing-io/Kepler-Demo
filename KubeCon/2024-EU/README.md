# Cloud Native Sustainable AI

Chen Wang, Eun Kyung Lee & Bo Wen, IBM Research

Huamin Chen, Red Hat

## Mission
It is well known that the energy consumption of developing (and deploying) Large Language Models (LLM) is becoming alarming rate [1]. Our broader mission is to 1) accurately quantify/account for the energy consumption of the entire cycle of AI model development, 2) evaluate any energy inefficiencies of utilizing hardware/software features in Cloud Native environment, and 3) optimize the performance and energy usage. 

Specifically in this demo, we will delve into the cutting-edge realm of energy implications of LLM inference, and discover how Kepler is employed to meticulously measure power consumption while processing different types of LLM inference workloads. Kepler is a CNCF Sandbox tool to measure pod-level energy in the Cloud environment. We will also demonstrate how to use the Multi-instance GPU (MIG) feature and frequency scaling in order to save energy for GPUs to process inference workloads.  

[1] https://spectrum.ieee.org/ai-energy-consumption

## Architecture

[Architecture](docs/Architecture.md)

## LLM

[LLM](docs/LLM.md)

## Measurement

[Measurement](docs/Measurement.md)

## Conclusion
