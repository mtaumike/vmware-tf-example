# variables required for operation

# can use environment variable VSPHERE_USER
#variable "vsphere_user" {
#  default = "iamtoor"
#}

# can use environment variable VSPHERE_PASSWORD
#variable "vsphere_password" {
#  default = "lolzers"
#}

# can use environment variable VSPHERE_SERVER
#variable "vsphere_server" {
#  default = "localhost.r.us"
#}

######### for this environment

# vSphere entries needed

# vSphere cluster to deploy to
variable "vsphere_cluster_name" {
  default = "Platypus"
}

# vSphere datacenter to deploy to
variable "vsphere_datacenter_name" {
  default = "MPLS-Lab"
}

# time zone for instances
variable "vsphere_instance_tz" {
  default = "US/Central"
}

# the folders to store things
resource "vsphere_folder" "web_experiment" {
  path       = "web_experiment"
  datacenter = "${var.vsphere_datacenter_name}"
}

resource "vsphere_folder" "app_experiment" {
  path       = "app_experiment"
  datacenter = "${var.vsphere_datacenter_name}"
}

# DNS servers for all
variable "dns_servers" {
  default = [
    "127.0.0.1",
    "204.153.247.1",
    "8.8.4.4",
    "8.8.8.8",
  ]
}

variable "dns_suffixes" {
  default = [
    "geeks.org",
  ]
}
