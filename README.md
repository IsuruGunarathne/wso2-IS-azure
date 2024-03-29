# wso2-IS-azure

## Building Docker image

Copy the IS 7.0 folder (named wso2is-7.0.0) to the docker folder and run the following commands

`docker build -t is7.0 .` image will be named IS7.0

## Uploading the image to Azure Container Registry

`az login` login to azure <br>
`az acr login --name <acrName>` login to the azure container registry <br>
`docker tag is7.0 <acrName>.azurecr.io/is7.0` tag the image <br>
`docker push <acrName>.azurecr.io/is7.0` push the image to the azure container registry <br>

## MSSQL

exec into a pod and install msodbcsql18

`curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc`
`curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list`
`apt-get update`
`apt-get install mssql-tools18 unixodbc-dev`
`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`
`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc`
`source ~/.bashrc`

run `sqlcmd -S <link-to-db>,1433 -U <username> -P <pw> -Q "SELECT DISTINCT type_desc FROM sys.all_objects;"`
to check if it's working

## Deploying the image to Azure Kubernetes Service

Navigate to IS folder and run the following commands <br>

`helm install is-release .` deploy the image to the kubernetes cluster

## Accessing the kubernetes cluster using a VM

`ssh -i <path-to-certificate> azureuser@<public-IP>` ssh into the VM <br>

## Accessing the kubernetes cluster using Azure CLI

`az aks get-credentials --resource-group <resource-group> --name <cluster-name>` get the credentials to access the kubernetes cluster <br>

## Accessing the kubernetes cluster using kubectl

`kubectl get pods` get the pods <br>
`kubectl exec -it <pod-name> -- /bin/bash` exec into a pod <br>

## Azure traffic maanger

Create a traffic manager profile and add the kubernetes clusters IP as an endpoint <br>
You will have to assign a DNS name before that <br>
To assign a DNS name go to the relavant ip address and click on the configuration tab <br>
Then click on the DNS name label and assign a DNS name <br>

You can now add the kubernetes cluster ip as an Azure endpoint

## Scripts

### build_uplaod.sh

This copies all jars from jar_files directory into the relavant directory of wso2is-7.0.0 and then builds the docker image and uploads it to the azure container registry

### switch_to_central.sh

initiates failover to the central US database and switched traffic

### switch_to_east.sh

initiates failover to the east US database and switched traffic
