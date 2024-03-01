# what happens in this script?
# 1. delete the is-deployment.yaml file in IS/templates folder
# 2. copy the read-write is-deployment.yaml file to IS/templates folder
# 3. upgrade the IS deployment
# 4. delete the is-deployment.yaml file in IS/templates folder
# 5. copy the read-only is-deployment.yaml file to IS/templates folder

# if we want to switch to read-write mode, we can run this script, that's it

# if we want to switch to read-only mode, we can run a helm upgrade command from the IS directory 
# helm upgrade is-release ../IS


rm -f ../IS/templates/is-deployment.yaml
echo "read-only is-configmap.yaml file deleted successfully."
echo " "
echo " "

echo "replacing deployment with read-write deployment"
cp deployments/read_write/is-deployment.yaml ../IS/templates/
echo "read-write is-deployment.yaml file copied successfully."
echo " "
echo " "

echo "upgrading the IS deployment"
helm upgrade is-release ../IS
echo "IS deployment upgraded successfully."
echo " "
echo " "

echo "replacing configmap with read-only is-configmap again"
rm -f ../IS/templates/is-deployment.yaml
cp deployments/read_only/is-deployment.yaml ../IS/templates/
echo "read-only is-configmap.yaml file copied successfully."
echo " "
echo " "

echo "deployment refreshed"