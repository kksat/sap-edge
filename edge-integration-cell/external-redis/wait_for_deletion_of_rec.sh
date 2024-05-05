#!/bin/bash

# Define the name of the RedisEnterpriseCluster
cluster_name="rec"

# Define the namespace
namespace="sap-eic-external-redis"

# Loop until the RedisEnterpriseCluster is deleted
while true; do
    # Check if the RedisEnterpriseCluster still exists
    cluster_exists=$(oc get RedisEnterpriseCluster "$cluster_name" -n "$namespace" &>/dev/null; echo $?)

    if [[ "$cluster_exists" != 0 ]]; then
        echo "Redis Enterprise Cluster $cluster_name is deleted. Exiting loop."
        break
    else
        echo "Redis Enterprise Cluster $cluster_name still exists. Waiting..."
        sleep 5  # Adjust the sleep time as needed
    fi
done
