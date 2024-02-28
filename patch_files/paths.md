https://medium.com/@isuru623/updating-configurations-using-values-from-a-toml-file-wso2-identity-server-06b5a734b93b

### registry.xml.js

path = /wso2is-7.0.0/repository/resources/conf/templates/repository/conf

### key-mappings.json

path = /wso2is-7.0.0/repository/resources/conf

### default.json

path = /wso2is-7.0.0/repository/resources/conf

### add to deployment.toml

[registry_mode]
registry_read_only = "true”
