database="ismssqldbprimary"
DatabaseResourceGroup="rnd-charindut-isuru"
Server="is-mssql-server-primary"

trafficManagerProfile="wso2-is"
endpointType="azureEndpoints"
endpointResourceGroup="rnd-isurug-charindu"

# Capture start time
start_time=$(date +%s)

echo "Initialting failover to east-us"
az sql db replica set-primary --name $database --resource-group $DatabaseResourceGroup --server $Server &
echo "Database switched to east-us"
echo " "
echo " "

echo "Updating traffic manager endpoint status to east-us"
az network traffic-manager endpoint update --name east-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Enabled &
az network traffic-manager endpoint update --name central-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Disabled &
echo "Traffic manager endpoint status updated"

wait

# Capture end time
end_time=$(date +%s)

# Calculate elapsed time
elapsed_time=$((end_time - start_time))

echo " "
echo " "
echo "Time taken: $elapsed_time seconds"
echo " "
echo " "
echo "Failover to east-us completed"
