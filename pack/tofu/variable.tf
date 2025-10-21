#  SPDX-License-Identifier: MIT


# To choose the appropriate interface map for your setup
variable "spine_model" {
  type        = string
  description = "Supported options are QFX5220_32c, QFX5220_128c, QFX5120"
  default     = "QFX5220_32c"

  validation {
    condition     = var.spine_model == "QFX5220_32c" || var.spine_model == "QFX5220_128c" || var.spine_model == "QFX5120"
    error_message = "The spine_model value must be one of QFX5220_32c, QFX5220_128c, QFX5120"
  }
}

variable "single_leaf_model" {
  type        = string
  description = "Model used for the rack with 1 single leaf. Supported options are QFX5120_48Y, QFX5120_48YM, QFX5110_48S"
  default     = "QFX5120_48YM"

  validation {
    condition     = var.single_leaf_model == "QFX5120_48Y" || var.single_leaf_model == "QFX5120_48YM" || var.single_leaf_model == "QFX5110_48S"
    error_message = "The single_leaf_model value must be one of QFX5120_48Y, QFX5120_48YM, QFX5110_48S"
  }
}

variable "esi_leaf_model" {
  type        = string
  description = "Model used for the rack with 1 ESI leaf pair. Supported options are QFX5120_48Y, QFX5120_48YM, QFX5110_48S"
  default     = "QFX5120_48YM"

  validation {
    condition     = var.esi_leaf_model == "QFX5120_48Y" || var.esi_leaf_model == "QFX5120_48YM" || var.esi_leaf_model == "QFX5110_48S"
    error_message = "The esi_leaf_model value must be one of QFX5120_48Y, QFX5120_48YM, QFX5110_48S"
  }
}


variable "borderleaf_model" {
  type        = string
  description = "Model used for the rack with 1 Border Leaf pair. Supported options are QFX5700, QFX5120_48Y, QFX5120_48YM, PTX10001, QFX5130_32CD, ACX7100_48L, QFX10002_36Q"
  default     = "QFX5120_48YM"

  validation {
    condition     = var.borderleaf_model == "QFX5700" || var.borderleaf_model == "QFX5120_48Y" || var.borderleaf_model == "QFX5120_48YM" || var.borderleaf_model == "PTX10001_36MR" || var.borderleaf_model == "QFX5130_32C" || var.borderleaf_model == "ACX7100_48L" || var.borderleaf_model == "QFX10002_36Q"
    error_message = "The borderleaf_model value must be one of QFX5700, QFX5120_48Y, QFX5120_48YM, PTX10001_36MR, QFX5130_32CD, ACX7100_48L, QFX10002_36Q"
  }
}

locals {
  derived_if_map_id = {
    "QFX5220_32c"   = apstra_interface_map.DC1-Spine_QFX5220_32c.id
    "QFX5220_128c"  = apstra_interface_map.DC1-Spine_QFX5220_128c.id
    "QFX5120"       = apstra_interface_map.DC1-Spine_QFX5120.id
    "QFX5120_48YM"  = apstra_interface_map.DC1-Leaf_QFX5120_48YM.id
    "QFX5700"       = apstra_interface_map.DC1-Leaf_QFX5700.id
    "PTX10001_36MR" = apstra_interface_map.DC1-Leaf_PTX10001_36MR.id
    "QFX5130_32CD"  = apstra_interface_map.DC1-Leaf_QFX5130_32CD.id
    "ACX7100_48L"   = apstra_interface_map.DC1-Leaf_ACX7100_48L.id
    "QFX5120_48Y"   = apstra_interface_map.DC1-Leaf_QFX5120_48Y.id
    "QFX5110_48S"   = apstra_interface_map.DC1-Leaf_QFX5110_48S.id
    "QFX10002_36Q"  = apstra_interface_map.DC1-Leaf_QFX10002_36Q.id
  }
}

locals {
  derived_logical_device_size = {
    "QFX5220_32c"   = apstra_logical_device.DC1-Spine-large.id
    "QFX5220_128c"  = apstra_logical_device.DC1-Spine-large.id
    "QFX5120"       = apstra_logical_device.DC1-Spine-small.id
    "QFX5120_48YM"  = apstra_logical_device.DC1-Leaf.id
    "QFX5700"       = apstra_logical_device.DC1-Leaf.id
    "PTX10001_36MR" = apstra_logical_device.DC1-Leaf.id
    "QFX5130_32CD"  = apstra_logical_device.DC1-Leaf.id
    "ACX7100_48L"   = apstra_logical_device.DC1-Leaf.id
    "QFX5120_48Y"   = apstra_logical_device.DC1-Leaf.id
    "QFX5110_48S"   = apstra_logical_device.DC1-Leaf-small.id
    "QFX10002_36Q"  = apstra_logical_device.DC1-Leaf.id
  }
}


variable "fabric_asn_range" {
  type        = string
  description = "Internal Fabric ASN range, i.e. 65000-65010"
  default     = "64512-64999"

  validation {
    condition     = (length(regexall("^[0-9]+-[0-9]+$", var.fabric_asn_range)) == 1)
    error_message = "The ASN range must be ASN1-ASN2"
  }
}

variable "external_asn_range" {
  type        = string
  description = "External Device ASN range, i.e. 65000-65010"
  default     = "65000-65099"

  validation {
    condition     = (length(regexall("^[0-9]+-[0-9]+$", var.external_asn_range)) == 1)
    error_message = "The ASN range must be ASN1-ASN2"
  }
}

variable "ipv4_fabric_loopback_pool" {
  type        = string
  description = "IPv4 loopback address pool for the fabric, i.e. 192.168.10.0/24"
  default     = "192.168.0.0/24"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.ipv4_fabric_loopback_pool)) == 1)
    error_message = "The IP pool must be IP_ADDR/MASK"
  }
}

variable "ipv4_fabric_address_pool" {
  type        = string
  description = "IPv4 interface address pool for the fabric, i.e. 192.168.100.0/24"
  default     = "192.168.1.0/24"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.ipv4_fabric_address_pool)) == 1)
    error_message = "The IP pool must be IP_ADDR/MASK"
  }
}

variable "ipv4_external_address_pool" {
  type        = string
  description = "IPv4 interface addresses pool for the external connections, i.e. 192.168.110.0/24"
  default     = "192.168.2.0/24"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.ipv4_external_address_pool)) == 1)
    error_message = "The IP pool must be IP_ADDR/MASK"
  }
}

variable "ipv4_evpn_loopback_pool" {
  type        = string
  description = "IPv4 EVPN loopback address pool, i.e. 192.168.120.0/24"
  default     = "192.168.3.0/24"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.ipv4_evpn_loopback_pool)) == 1)
    error_message = "The IP pool must be IP_ADDR/MASK"
  }
}



variable "ipv6_fabric_loopback_pool" {
  type        = string
  description = "IPv6 loopback address pool for the fabric, i.e. fdf6:ed70:1fac:f2d1::1000/116"
  default     = "fc00:0:1::/56"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.ipv6_fabric_loopback_pool)) == 1)
    error_message = "The IPv6 pool must be IPv6_ADDR/MASK"
  }
}

variable "ipv6_fabric_address_pool" {
  type        = string
  description = "IPv6 interface address pool for the fabric, i.e. fdf6:ed70:1fac:f2d1::/116"
  default     = "fc00:0:2::/56"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.ipv6_fabric_address_pool)) == 1)
    error_message = "The IPv6 pool must be IPv6_ADDR/MASK"
  }
}

variable "ipv6_evpn_loopback_pool" {
  type        = string
  description = "IPv6 EVPN loopback address pool, i.e. fdf6:ed70:1fac:f2d1::2000/116"
  default     = "fc00:0:3::/56"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.ipv6_evpn_loopback_pool)) == 1)
    error_message = "The IPv6 pool must be IPv6_ADDR/MASK"
  }
}

variable "ipv6_external_address_pool" {
  type        = string
  description = "IPv6 interface addresses pool for the external connections, i.e. 2001:db8:dc1:10:200::/80"
  default     = "fc00:0:4::/56"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.ipv6_external_address_pool)) == 1)
    error_message = "The IPv6 pool must be IPv6_ADDR/MASK"
  }
}





variable "red_rz_vlan_id" {
  type        = number
  description = "VLAN ID used for RED routing zone"
  default     = 101

  validation {
    condition     = var.red_rz_vlan_id < 4001
    error_message = "The VLAN ID must be between 1-4000"
  }
}

variable "blue_rz_vlan_id" {
  type        = number
  description = "VLAN ID used for BLUE routing zone"
  default     = 102

  validation {
    condition     = var.blue_rz_vlan_id < 4001
    error_message = "The VLAN ID must be between 1-4000"
  }
}

variable "red_rz_vni" {
  type        = number
  description = "VNI used for RED routing zone i.e. 10.10.0.200, 10.10.0.200"
  default     = 10001

  validation {
    condition     = var.red_rz_vni < 16777214
    error_message = "The VNI must be between 1-16777214"
  }
}

variable "blue_rz_vni" {
  type        = number
  description = "VNI used for BLUE routing zone"
  default     = 10002

  validation {
    condition     = var.blue_rz_vni < 16777214
    error_message = "The VNI must be between 1-16777214"
  }
}

variable "red_rz_dhcp" {
  type        = string
  description = "list of DHCP servers for RED routing zone, i.e. 10.10.0.200, 10.10.0.200"
  default     = "172.16.1.11"
}

variable "blue_rz_dhcp" {
  type        = string
  description = "list of DHCP servers for BLUE routing zone, i.e. 10.10.0.200, 10.10.0.200"
  default     = "172.16.2.11"
}


variable "leaf1_red_to_external_ip" {
  type        = string
  description = "IPv4 address with subnet mask for leaf1 to external gateway in RED VRF, i.e. 10.1.0.0/31"
  default     = "172.17.0.0/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.leaf1_red_to_external_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "leaf1_red_to_external_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for leaf1 to external gateway in RED VRF, i.e. 2001:db8:dc1:10:200::/127"
  default     = "fc00::/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.leaf1_red_to_external_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}


variable "external_to_leaf1_red_ip" {
  type        = string
  description = "IPv4 address with subnet mask for external Gateway to leaf1 in RED VRF, i.e. 10.1.0.1/31"
  default     = "172.17.0.1/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.external_to_leaf1_red_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "external_to_leaf1_red_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for external Gateway to leaf1 in RED VRF, i.e. 2001:db8:dc1:10:200::1/127"
  default     = "fc00::1/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.external_to_leaf1_red_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}


variable "leaf2_red_to_external_ip" {
  type        = string
  description = "IPv4 address with subnet mask for leaf2 in RED VRF to external gateway, i.e. 10.2.0.0/31"
  default     = "172.17.0.2/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.leaf2_red_to_external_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "leaf2_red_to_external_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for leaf2 to external gateway in RED VRF, i.e. 2001:db8:dc1:10:200::/127"
  default     = "fc00::2/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.leaf2_red_to_external_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}

variable "external_to_leaf2_red_ip" {
  type        = string
  description = "IPv4 address with subnet mask for external Gateway to leaf2 in RED VRF, i.e. 10.2.0.1/31"
  default     = "172.17.0.3/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.external_to_leaf2_red_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "external_to_leaf2_red_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for external Gateway to leaf2 in RED VRF, i.e. 2001:db8:dc1:10:200::1/127"
  default     = "fc00::3/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.external_to_leaf2_red_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}

variable "leaf1_blue_to_external_ip" {
  type        = string
  description = "IPv4 address with subnet mask for leaf1 in BLUE VRF to external gateway, i.e. 10.1.0.0/31"
  default     = "172.17.0.4/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.leaf1_blue_to_external_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "leaf1_blue_to_external_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for leaf1 to external gateway in BLUE VRF, i.e. 2001:db8:dc1:10:200::/127"
  default     = "fc00::4/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.leaf1_blue_to_external_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}

variable "external_to_leaf1_blue_ip" {
  type        = string
  description = "IPv4 address with subnet mask for external Gateway to leaf1 in BLUE VRF, i.e. 10.1.0.1/31"
  default     = "172.17.0.5/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.external_to_leaf1_blue_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "external_to_leaf1_blue_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for external Gateway to leaf1 in BLUE VRF, i.e. 10.1.0.1/31"
  default     = "fc00::5/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.external_to_leaf1_blue_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}

variable "leaf2_blue_to_external_ip" {
  type        = string
  description = "IPv4 address with subnet mask for leaf2 in BLUE VRF to external gateway, i.e. 10.2.0.0/31"
  default     = "172.17.0.6/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.leaf2_blue_to_external_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "leaf2_blue_to_external_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for leaf2 in BLUE VRF to external gateway, i.e. 10.2.0.0/31"
  default     = "fc00::6/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.leaf2_blue_to_external_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}

variable "external_to_leaf2_blue_ip" {
  type        = string
  description = "IPv4 address with subnet mask for external Gateway to leaf2 in BLUE VRF, i.e. 10.2.0.1/31"
  default     = "172.17.0.7/31"

  validation {
    condition     = (length(regexall("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}$", var.external_to_leaf2_blue_ip)) == 1)
    error_message = "The IP address must be IP_ADDR/MASK"
  }
}

variable "external_to_leaf2_blue_ipv6" {
  type        = string
  description = "IPv6 address with subnet mask for external Gateway to leaf2 in BLUE VRF, i.e. 2001:db8:dc1:10:200::1/127"
  default     = "fc00::7/127"

  validation {
    condition     = (length(regexall("^(([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,6}:|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:))(/[0-9]{1,3})$", var.external_to_leaf2_blue_ipv6)) == 1)
    error_message = "The IPv6 address must be IPv6_ADDR/MASK"
  }
}
