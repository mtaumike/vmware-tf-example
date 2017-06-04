# appservers, for life!

resource "vsphere_virtual_machine" "appservers" {
  name       = "app${lookup(var.app_last_octets, count.index)}"
  folder     = "${vsphere_folder.app_experiment.path}"
  vcpu       = "${var.app_vcpu}"
  memory     = "${var.app_mem}"
  datacenter = "${var.vsphere_datacenter_name}"
  cluster    = "${var.vsphere_cluster_name}"
  time_zone  = "${var.vsphere_instance_tz}"

  # how many to launch? variable configured to launch upwards of 6 in example
  count = "${var.app_how_many}"

  dns_suffixes = "${var.dns_suffixes}"

  dns_servers = [
    "${var.dns_servers[0]}",
    "${var.dns_servers[1]}",
    "${var.dns_servers[2]}",
    "${var.dns_servers[3]}",
  ]

  # external facing
  network_interface {
    label = "${var.app_ext_network_switch}"

    ipv4_address       = "${var.app_ext_ip_network}.${lookup(var.app_last_octets, count.index)}"
    ipv4_prefix_length = "${var.app_ext_ip_cidr}"
    ipv4_gateway       = "${var.app_ext_ip_gateway}"
  }

  # internal only - no ipv4 gateway
  network_interface {
    label = "${var.app_int_network_switch}"

    ipv4_address       = "${var.app_int_ip_network}.${lookup(var.app_last_octets, count.index)}"
    ipv4_prefix_length = "${var.app_int_ip_cidr}"
  }

  disk {
    datastore = "nas001-exp01"
    template  = "Ansible/ubuntu-16-ansible-template-001"
    type      = "thin"
  }

  provisioner "file" {
    source      = "${var.app_provision_src_path}"
    destination = "${var.app_provision_dest_path}"

    connection {
      type        = "ssh"
      user        = "ansible"
      private_key = "${file("${var.app_private_key_path}")}"
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ansible"
      private_key = "${file("${var.app_private_key_path}")}"
      agent       = false
    }

    inline = [
      "chmod +x ${var.app_provision_dest_path}",
      "sudo ${var.app_provision_dest_path} ${count.index}",
      "rm ${var.app_provision_dest_path}",
    ]
  }
}
