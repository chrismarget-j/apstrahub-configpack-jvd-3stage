resource "apstra_datacenter_blueprint" "DC1-3Stage" {
    name        = "DC1-3Stage"
    template_id = apstra_template_rack_based.dc1_template.id
    depends_on = [ apstra_interface_map.DC1-Spine_QFX5220_32c,
                   apstra_interface_map.DC1-Spine_QFX5220_128c,
                   apstra_interface_map.DC1-Spine_QFX5120,
                   apstra_interface_map.DC1-Leaf_QFX5120_48YM,
                   apstra_interface_map.DC1-Leaf_QFX5700,
                   apstra_interface_map.DC1-Leaf_PTX10001_36MR,
                   apstra_interface_map.DC1-Leaf_QFX5130_32CD,
                   apstra_interface_map.DC1-Leaf_ACX7100_48L,
                   apstra_interface_map.DC1-Leaf_QFX5120_48Y,
                   apstra_interface_map.DC1-Leaf_QFX5110_48S,
                   apstra_interface_map.DC1-Leaf_QFX10002_36Q
    ]
    fabric_addressing = "ipv4_ipv6"
    fabric_mtu = 9170
    ipv6_applications = true
    evpn_type_5_routes = true
    esi_mac_msb = 2
}


# ASN pools, IPv4 pools and switch devices will be allocated using looping
# resources. These three `local` maps are what we'll loop over.
locals {
  asn_pools = {
    spine_asns = [apstra_asn_pool.DC1-ASNs.id]
    leaf_asns  = [apstra_asn_pool.DC1-ASNs.id]
    generic_asns = [apstra_asn_pool.DC1-External-ASN.id]
  }
  ipv4_pools = {
    spine_loopback_ips  = [apstra_ipv4_pool.DC1-Loopbacks.id]
    leaf_loopback_ips   = [apstra_ipv4_pool.DC1-Loopbacks.id]
    spine_leaf_link_ips = [apstra_ipv4_pool.DC1-Fabric-IPs.id]
  }
  ipv6_pools = {
    spine_loopback_ips_ipv6  = [apstra_ipv6_pool.DC1-IPv6-Loopbacks.id]
    leaf_loopback_ips_ipv6   = [apstra_ipv6_pool.DC1-IPv6-Loopbacks.id]
    spine_leaf_link_ips_ipv6 = [apstra_ipv6_pool.DC1-Fabric-IPv6.id]
  }
}


# Assign interface maps to fabric roles to eliminate build errors so we
# can deploy
resource "apstra_datacenter_device_allocation" "interface_map_assignment" {
  for_each         = local.devices
  blueprint_id     = apstra_datacenter_blueprint.DC1-3Stage.id
  node_name        = each.key
  initial_interface_map_id = each.value.interface_map
}


# Assign ASN pools to fabric roles to eliminate build errors so we
# can deploy
resource "apstra_datacenter_resource_pool_allocation" "asn" {
  for_each     = local.asn_pools
  blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
  role         = each.key
  pool_ids     = each.value
}

# Assign IPv4 pools to fabric roles to eliminate build errors so we
# can deploy
resource "apstra_datacenter_resource_pool_allocation" "ipv4" {
  for_each     = local.ipv4_pools
  blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
  role         = each.key
  pool_ids     = each.value
}

# Assign IPv6 pools to fabric roles to eliminate build errors so we
# can deploy
resource "apstra_datacenter_resource_pool_allocation" "ipv6" {
  for_each     = local.ipv6_pools
  blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
  role         = each.key
  pool_ids     = each.value
}
