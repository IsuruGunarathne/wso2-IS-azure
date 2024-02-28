database="ismssqldbprimary"
DatabaseResourceGroup="rnd-charindut-isuru"
Server="is-mssql-server-primary"

trafficManagerProfile="wso2-is"
endpointType="azureEndpoints"
endpointResourceGroup="rnd-isurug-charindu"

echo "Initialting failover to east-us"
az sql db replica set-primary --name $database --resource-group $DatabaseResourceGroup --server $Server
echo "Database switched to east-us"

echo "Updating traffic manager endpoint status to east-us"
az network traffic-manager endpoint update --name east-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Enabled
az network traffic-manager endpoint update --name central-us --profile-name $trafficManagerProfile --resource-group $endpointResourceGroup --type $endpointType --endpoint-status Disabled
echo "Traffic manager endpoint status updated"