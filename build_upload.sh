#!/bin/bash

# Define source and destination directories
source_dir="jar_files"
source_lib="libraries"
dest_dir_dropins="wso2is-7.0.0/repository/components/dropins"
dest_dir_lib="wso2is-7.0.0/repository/components/lib"
registry_name="acrasgardeomainrnd001"

# Delete the existing wso2is-7.0.0 folder
rm -rf wso2is-7.0.0

# Extract the ZIP file
# rc7
unzip wso2is-7.0.0.zip

echo "Extraction and copying completed."

# Copy files to dropins directory
rm -rf wso2is-7.0.0/repository/components/dropins/org.wso2.custom.user.operation.event.listener-1.0-SNAPSHOT.jar
cp -r "$source_dir"/* "$dest_dir_dropins"

# Copy files to lib directory
cp -r "$source_lib"/* "$dest_dir_lib"

echo "JAR files copied successfully."

# copy .env to wso2is-7.0.0
cp .env wso2is-7.0.0
cp reference.conf wso2is-7.0.0/repository/conf

echo " "
echo " "

echo "applying patch"
# Applying patch
patch_dir="patch_files"
j2_path="wso2is-7.0.0/repository/resources/conf/templates/repository/conf"
json_path="wso2is-7.0.0/repository/resources/conf"

# Deleting existing files
rm -f "$j2_path"/registry.xml.j2
rm -f "$json_path"/key-mappings.json
rm -f "$json_path"/default.json

# Copy files to j2 directory
cp "$patch_dir"/registry.xml.j2 "$j2_path"

# Copy files to json directory
cp "$patch_dir"/key-mappings.json "$json_path"
cp "$patch_dir"/default.json "$json_path"

echo "Patch applied successfully."
echo " "
echo " "

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
