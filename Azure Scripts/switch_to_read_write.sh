# delete the is-configmap.yaml file in IS/templates folder

rm -f ../IS/templates/is-configmap.yaml
echo "read-only is-configmap.yaml file deleted successfully."
echo " "
echo " "

echo "replacing configmap with read-write configmap"
cp configmaps/read_write/is-configmap.yaml ../IS/templates/
echo "read-write is-configmap.yaml file copied successfully."
echo " "
echo " "

echo "upgrading the IS deployment"
helm upgrade is-release ../IS
echo "IS deployment upgraded successfully."
echo " "
echo " "

echo "replacing configmap with read-only is-configmap again"
cp configmaps/read_only/is-configmap.yaml ../IS/templates/
echo "read-only is-configmap.yaml file copied successfully."
echo " "
echo " "

echo "deployment refreshed"