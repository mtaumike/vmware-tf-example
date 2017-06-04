## ## specific to app servers

# if you want this to talk and run the setup scripts then you gotta give
# some pathing so that execution can happen
variable "app_public_key_path" {
  description = "public key"
  default     = "~/.ssh/ansible.pub"
}

variable "app_private_key_path" {
  description = "private key"
  default     = "~/.ssh/ansible"
}

# and which script do we push up? It can do anything!
variable "app_provision_src_path" {
  description = "script source to feed the monsters"
  default     = "scripts/app_install.sh"
}

variable "app_provision_dest_path" {
  description = "script destination to feed the monsters"
  default     = "/tmp/install.sh"
}

# let's configure the vCPU and RAM allocations
variable "app_vcpu" {
  description = "how many vCPUs do we want?"
  default     = "2"
}

variable "app_mem" {
  description = "how much RAM do we want?"
  default     = "2048"
}

# this is a little tricky - we need to have <x> number of appservers
# running but we need to have allocated IPs to match up and we can not
# do this programmatically
#
# this is important - if you are changing the number of servers then you
# *must* also make sure you have enough IPs to support such
variable "app_how_many" {
  default = "4"
}

# create map of the final octet for networking

variable "app_last_octets" {
  default = {
    "0" = "100"
    "1" = "101"
    "2" = "102"
    "3" = "103"
    "4" = "104"
    "5" = "105"
  }
}

variable "app_ext_network_switch" {
  description = "which standard or vDS switch will the VM live?"
  default     = "application_network"
}

variable "app_ext_ip_network" {
  description = "first three octets of network"
  default     = "172.20.145"
}

variable "app_ext_ip_cidr" {
  description = "cidr bit-length"
  default     = "24"
}

variable "app_ext_ip_gateway" {
  description = "default IPv4 gateway"
  default     = "172.20.145.254"
}

# commented out in appservers.tf - do you have a reason for
# multiple networks? If so, then have at it!
variable "app_int_network_switch" {
  description = "which standard or vDS switch will the VM live?"
  default     = "app_internal_network"
}

variable "app_int_ip_network" {
  description = "first three octets of network"
  default     = "172.30.145"
}

variable "app_int_ip_cidr" {
  description = "cidr bit-length"
  default     = "24"
}
