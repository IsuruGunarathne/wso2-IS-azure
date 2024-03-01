# delete the is-configmap.yaml file in IS/templates folder

rm -f ../IS/templates/is-configmap.yaml
rm -f ../IS/templates/is-deployment.yaml
echo "read-only is-configmap.yaml file deleted successfully."
echo " "
echo " "

echo "replacing configmap with read-write configmap"
cp configmaps/read_write/is-configmap.yaml ../IS/templates/
cp configmaps/read_write/is-deployment.yaml ../IS/templates/
echo "read-write is-configmap.yaml file copied successfully."
echo " "
echo " "

echo "upgrading the IS deployment"
helm upgrade is-release -f configmaps/read_write/is-configmap.yaml ../IS --force
echo "IS deployment upgraded successfully."
echo " "
echo " "

echo "replacing configmap with read-only is-configmap again"
rm -f ../IS/templates/is-configmap.yaml
rm -f ../IS/templates/is-deployment.yaml
cp configmaps/read_only/is-configmap.yaml ../IS/templates/
cp configmaps/read_only/is-deployment.yaml ../IS/templates/
echo "read-only is-configmap.yaml file copied successfully."
echo " "
echo " "

echo "deployment refreshed"