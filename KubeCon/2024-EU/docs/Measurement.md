# Measurement
This section describes how to use Kepler to monitor vLLM performance and power metrics.

## Install Kepler

Follow instructions [here]([url](https://sustainable-computing.io/installation/kepler/)https://sustainable-computing.io/installation/kepler/) and remember to enable `DCGM_DEPLOY` option.

## Install Promtheus and Grafana

Following the same instructions to install kube-prometheus and Grafana.

## Installing Kepler-vLLM Grafana Dashboard 

Login to the Grafana service and create a new dashboard by importing the dashboard [here]([url](https://github.com/sustainable-computing-io/Kepler-Demo/blob/main/KubeCon/2024-EU/dashboards/vllm-kepler.json)https://github.com/sustainable-computing-io/Kepler-Demo/blob/main/KubeCon/2024-EU/dashboards/vllm-kepler.json)

If the imported Promethesus data source is missing, point the data source to the default prometheus data source.


