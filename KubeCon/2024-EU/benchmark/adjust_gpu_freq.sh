#!/bin/bash

# Define the desired SM (Streaming Multiprocessor) clock frequencies
sm_levels=("540" "810" "1110" "1410")

# Loop through each frequency level
for level in "${sm_levels[@]}"; do
	echo "Setting GPU Clock to $level MHz"
	
	# Set the GPU SM clock speed (modify --id=0 to target a specific GPU if necessary)
	nvidia-smi -i 1 -ac 1215,$level
	
	# Check if the nvidia-smi command was successful
	if [ $? -ne 0 ]; then
		echo "Failed to set GPU Clock to $level MHz. Please check your settings and permissions."
		exit 1
	fi
	
	# Sleep for 1 minute
	sleep 600
done

echo "Completed adjusting GPU Clock frequencies."
