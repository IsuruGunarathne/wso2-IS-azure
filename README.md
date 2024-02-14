# wso2-IS-azure

## Building Docker image

Copy the IS 7.0 folder (named wso2is-7.0.0) to the docker folder and run the following commands

`docker build -t is7.0 .` image will be named IS7.0

## Uploading the image to Azure Container Registry

`az login` login to azure <br>
`az acr login --name <acrName>` login to the azure container registry <br>
`docker tag is7.0 <acrName>.azurecr.io/is7.0` tag the image <br>
`docker push <acrName>.azurecr.io/is7.0` push the image to the azure container registry <br>

## Deploying the image to Azure Kubernetes Service

Navigate to IS folder and run the following commands

`helm install is-release .` deploy the image to the kubernetes cluster
