#!/bin/bash

# Check if a folder path is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <folder_path>"
  exit 1
fi

# Get the folder path from the script's argument
folder_path="$1"

# Define the output CSV file name, placed within the specified folder
output_file="${folder_path}/benchmark_results.csv"

# Write the CSV header
echo "concurrency,numprompt,request_inthroughput,input_throughput,output_throughput,mean_ttft_ms,median_ttft_ms,p99_ttft_ms,mean_tpot_ms,median_tpot_ms,p99_tpot_ms" > "$output_file"

# Loop through each json file in the specified folder matching the naming pattern
for file in "${folder_path}"/results_concurrency*_numprompt*.json; do
  # Extract 'concurrency' and 'numprompt' from the file name
  concurrency=$(echo "$file" | grep -oP '(?<=concurrency)\d+')
  numprompt=$(echo "$file" | grep -oP '(?<=numprompt)\d+')

  # Use jq to parse the json file and extract required values
  request_inthroughput=$(jq '.request_inthroughput' "$file")
  input_throughput=$(jq '.input_throughput' "$file")
  output_throughput=$(jq '.output_throughput' "$file")
  mean_ttft_ms=$(jq '.mean_ttft_ms' "$file")
  median_ttft_ms=$(jq '.median_ttft_ms' "$file")
  p99_ttft_ms=$(jq '.p99_ttft_ms' "$file")
  mean_tpot_ms=$(jq '.mean_tpot_ms' "$file")
  median_tpot_ms=$(jq '.median_tpot_ms' "$file")
  p99_tpot_ms=$(jq '.p99_tpot_ms' "$file")

  # Append the data as a new row in the CSV file
  echo "$concurrency,$numprompt,$request_inthroughput,$input_throughput,$output_throughput,$mean_ttft_ms,$median_ttft_ms,$p99_ttft_ms,$mean_tpot_ms,$median_tpot_ms,$p99_tpot_ms" >> "$output_file"
done
