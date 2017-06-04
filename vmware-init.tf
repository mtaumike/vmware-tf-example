provider "vsphere" {
  # see variables for explanation  #  user           = "${var.vsphere_user}"  #  password       = "${var.vsphere_password}"  #  vsphere_server = "${var.vsphere_server}"

  allow_unverified_ssl = true
}
