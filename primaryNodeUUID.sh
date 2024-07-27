#!/bin/bash

# Define the list of PVCs to search for
pvc_list=(
    "pvc-dccc228d-5eff-4ce5-939f-576038d607f7"
    "pvc-e870c852-4c61-4082-981d-b46ee6afa5e4"
    "pvc-e089994b-e249-4a47-9e70-e99115e69a4e"
    "pvc-fdd0f0fc-73fc-4a28-b38d-2b17fc1bc8fd"
    "pvc-56c7f1bd-eb4c-43d1-9d6c-b48f81a3f7e4"
    "pvc-21c64f51-3f0c-466c-850b-121d10b4c4b7"
    "pvc-462fa3c3-de8b-4c00-b202-d07c8db35c28"
    "pvc-e5f65a33-49ef-4f08-9150-1a8e75c19590"
    "pvc-1f8aae65-6930-4f9a-a542-fd8885f69aeb"
    "pvc-002aa171-d1e5-4d9a-9027-a9107ae4a6df"
    "pvc-4d820d6e-82e7-4f2a-af49-c21fc2969e6d"
    "pvc-2010e546-3270-46f1-99b1-3cd05563e23e"
    "pvc-3f38524a-a6ae-4b5e-9634-0d69983f4b8d"
    "pvc-75c93e1f-191d-46c0-93ae-2b71ea26469a"
    "pvc-cb7c74c0-174e-4f12-ac6a-661e66e39fdd"
    "pvc-22d1acc2-4cae-466c-908f-0f2ab9c66611"
    "pvc-771f83b1-2d67-43f0-b889-4619dc3c81fd"
)

# Log file to search
log_file="lbcli_list_volumes.log"

# Check if the log file exists
if [[ ! -f "$log_file" ]]; then
    echo "Error: $log_file not found."
    exit 1
fi

# Loop through each PVC and search for the corresponding primaryNodeUUID
for pvc in "${pvc_list[@]}"; do
    # Extract the primaryNodeUUID for the current PVC
    primaryNodeUUID=$(jq -r --arg pvc "$pvc" '.volumes[] | select(.name == $pvc) | .primaryNodeUUID' "$log_file")

    # Check if primaryNodeUUID was found
    if [[ -n "$primaryNodeUUID" && "$primaryNodeUUID" != "null" ]]; then
        echo "PVC: $pvc, primaryNodeUUID: $primaryNodeUUID"
    else
        echo "PVC: $pvc not found or primaryNodeUUID not available."
    fi
done

