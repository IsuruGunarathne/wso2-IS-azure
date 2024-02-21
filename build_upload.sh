#!/bin/bash

# Define source and destination directories
source_dir="jar_files"
dest_dir_dropins="wso2is-7.0.0/repository/components/dropins"
dest_dir_lib="wso2is-7.0.0/repository/components/lib"
registry_name="acrasgardeomainrnd001"

# Copy files to dropins directory
cp -r "$source_dir"/* "$dest_dir_dropins"

# Copy files to lib directory
cp -r "$source_dir"/* "$dest_dir_lib"

echo "Files copied successfully."

# Ask for the tag input
read -p "Enter tag for the Docker image: " tag

# Build Docker image
docker build -t is7.0:$tag .

# Login to Azure Container Registry (ACR)
az acr login --name $registry_name

# Tag the Docker image
docker tag is7.0:$tag $registry_name.azurecr.io/is7.0:$tag

# Push Docker image to ACR
docker push $registry_name.azurecr.io/is7.0:$tag

echo "Docker image tagged and pushed to Azure Container Registry successfully."
