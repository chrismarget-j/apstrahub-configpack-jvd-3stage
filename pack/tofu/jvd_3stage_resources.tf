resource "apstra_asn_pool" "DC1-ASNs" {
  name = "DC1-ASNs"
  ranges = [
    {
      first = split("-", var.fabric_asn_range)[0]
      last  = split("-", var.fabric_asn_range)[1]
    }
  ]
}

resource "apstra_asn_pool" "DC1-External-ASN" {
  name = "DC1-External-ASN"
  ranges = [
    {
      first = split("-", var.external_asn_range)[0]
      last  = split("-", var.external_asn_range)[1]
    }
  ]
}

resource "apstra_ipv4_pool" "DC1-Loopbacks" {
  name = "DC1-Loopbacks"
  subnets = [
    { network = var.ipv4_fabric_loopback_pool }
  ]
}

resource "apstra_ipv4_pool" "DC1-Fabric-IPs" {
  name = "DC1-Fabric-IPs"
  subnets = [
    { network = var.ipv4_fabric_address_pool }
  ]
}

resource "apstra_ipv4_pool" "DC1-EVPN-Loopbacks" {
  name = "DC1-EVPN-Loopbacks"
  subnets = [
    { network = var.ipv4_evpn_loopback_pool }
  ]
}

resource "apstra_ipv4_pool" "EXT-DC1" {
  name = "EXT-DC1"
  subnets = [
    { network = var.ipv4_external_address_pool }
  ]
}


resource "apstra_ipv6_pool" "DC1-IPv6-Loopbacks" {
  name = "DC1-IPv6-Loopbacks"
  subnets = [
    { network = var.ipv6_fabric_loopback_pool }
  ]
}

resource "apstra_ipv6_pool" "DC1-Fabric-IPv6" {
  name = "DC1-Fabric-IPv6"
  subnets = [
    {  network = var.ipv6_fabric_address_pool }
  ]
}

resource "apstra_ipv6_pool" "DC1-IPv6-EVPN-Loopbacks" {
  name = "DC1-IPv6-EVPN-Loopbacks"
  subnets = [
    { network = var.ipv6_evpn_loopback_pool }
  ]
}

resource "apstra_ipv6_pool" "EXT-IPv6-DC1" {
  name = "EXT-IPv6-DC1"
  subnets = [
    { network = var.ipv6_external_address_pool }
  ]
}






locals {
  device_owners = toset([
    "blue_all",
    "red_all",
    "mx_external_link1",
    "mx_external_link2"
  ])
}

resource "apstra_tag" "vntags" {
  for_each    = local.device_owners
  name        = each.key
}



