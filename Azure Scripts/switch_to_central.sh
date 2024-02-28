database="ismssqldbprimary"
DatabaseResourceGroup="rnd-isurug-charindu"
Server="wso2is-db-secondary"

trafficManagerProfile="wso2-is"
endpointType="azureEndpoints"
endpointResourceGroup="rnd-isurug-charindu"

echo "Initialting failover to central-us"
az sql db replica set-primary --name $database --resource-group $DatabaseResourceGroup --server $Server
echo "Database switched to central-us"

echo "Updating traffic manager endpoint status to central-us"
az network traffic-manager endpoint update --name east-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Disabled
az network traffic-manager endpoint update --name central-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Enabled
echo "Traffic manager endpoint status updated"