## ## specific to web servers

# if you want this to talk and run the setup scripts then you gotta give
# some pathing so that execution can hweben
variable "web_public_key_path" {
  description = "public key"
  default     = "~/.ssh/ansible.pub"
}

variable "web_private_key_path" {
  description = "private key"
  default     = "~/.ssh/ansible"
}

# and which script do we push up? It can do anything!
variable "web_provision_src_path" {
  description = "script source to feed the monsters"
  default     = "scripts/web_install.sh"
}

variable "web_provision_dest_path" {
  description = "script destination to feed the monsters"
  default     = "/tmp/install.sh"
}

# let's configure the vCPU and RAM allocations
variable "web_vcpu" {
  description = "how many vCPUs do we want?"
  default     = "2"
}

variable "web_mem" {
  description = "how much RAM do we want?"
  default     = "2048"
}

# this is a little tricky - we need to have <x> number of webservers
# running but we need to have allocated IPs to match up and we can not
# do this programmatically
#
# this is important - if you are changing the number of servers then you
# *must* also make sure you have enough IPs to support such
variable "web_how_many" {
  default = "4"
}

# create map of the final octet for networking

variable "web_last_octets" {
  default = {
    "0" = "100"
    "1" = "101"
    "2" = "102"
    "3" = "103"
    "4" = "104"
    "5" = "105"
  }
}

variable "web_ext_network_switch" {
  description = "which standard or vDS switch will the VM live?"
  default     = "external_network"
}

variable "web_ext_ip_network" {
  description = "first three octets of network"
  default     = "172.16.245"
}

variable "web_ext_ip_cidr" {
  description = "cidr bit-length"
  default     = "24"
}

variable "web_ext_ip_gateway" {
  description = "default IPv4 gateway"
  default     = "172.16.245.254"
}

# commented out in webservers.tf - do you have a reason for
# multiple networks? If so, then have at it!
variable "web_int_network_switch" {
  description = "which standard or vDS switch will the VM live?"
  default     = "web_internal_network"
}

variable "web_int_ip_network" {
  description = "first three octets of network"
  default     = "172.18.245"
}

variable "web_int_ip_cidr" {
  description = "cidr bit-length"
  default     = "24"
}
