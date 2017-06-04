# webservers, for life!

resource "vsphere_virtual_machine" "webservers" {
  name       = "web${lookup(var.web_last_octets, count.index)}"
  folder     = "${vsphere_folder.web_experiment.path}"
  vcpu       = "${var.web_vcpu}"
  memory     = "${var.web_mem}"
  datacenter = "${var.vsphere_datacenter_name}"
  cluster    = "${var.vsphere_cluster_name}"
  time_zone  = "${var.vsphere_instance_tz}"

  # how many to launch? variable configured to launch upwards of 6 in example
  count = "${var.web_how_many}"

  dns_suffixes = "${var.dns_suffixes}"

  dns_servers = [
    "${var.dns_servers[0]}",
    "${var.dns_servers[1]}",
    "${var.dns_servers[2]}",
    "${var.dns_servers[3]}",
  ]

  # external facing
  network_interface {
    label = "${var.web_ext_network_switch}"

    ipv4_address       = "${var.web_ext_ip_network}.${lookup(var.web_last_octets, count.index)}"
    ipv4_prefix_length = "${var.web_ext_ip_cidr}"
    ipv4_gateway       = "${var.web_ext_ip_gateway}"
  }

  # internal only - no ipv4 gateway
  network_interface {
    label = "${var.web_int_network_switch}"

    ipv4_address       = "${var.web_int_ip_network}.${lookup(var.web_last_octets, count.index)}"
    ipv4_prefix_length = "${var.web_int_ip_cidr}"
  }

  disk {
    datastore = "nas001-exp01"
    template  = "Ansible/ubuntu-16-ansible-template-001"
    type      = "thin"
  }

  provisioner "file" {
    source      = "${var.web_provision_src_path}"
    destination = "${var.web_provision_dest_path}"

    connection {
      type        = "ssh"
      user        = "ansible"
      private_key = "${file("${var.web_private_key_path}")}"
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ansible"
      private_key = "${file("${var.web_private_key_path}")}"
      agent       = false
    }

    inline = [
      "chmod +x ${var.web_provision_dest_path}",
      "sudo ${var.web_provision_dest_path} ${count.index}",
      "rm ${var.web_provision_dest_path}",
    ]
  }
}
