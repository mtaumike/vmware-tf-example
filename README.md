# Deploy servers within vSphere environment

## All variables are required

* webservers-vars.tf - variables for webservers being deployed
* appservers-vars.tf - variables for application servers being deployed
* global-vars.tf - definitions to launch against vSphere

## Environmental variables (can be hard coded)
* VSPHERE_SERVER = servername - no https, just raw FQDN
* VSPHERE_USER = username for vSphere environment
* VSPHERE_PASSWORD = password for vSphere environment
