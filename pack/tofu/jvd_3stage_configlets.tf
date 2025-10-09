resource "apstra_configlet" "dhcp_no_snoop" {
  name = "dhcp-no-snoop"
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_set_delete"
      template_text = <<-EOT
               set routing-instances blue forwarding-options dhcp-relay no-snoop
               set routing-instances red forwarding-options dhcp-relay no-snoop
      EOT
    }
  ]
}


resource "apstra_datacenter_configlet" "dhcp-no-snoop" {
 blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
 depends_on = [apstra_datacenter_routing_zone.red,
               apstra_datacenter_routing_zone.blue 
 ]
  catalog_configlet_id = apstra_configlet.dhcp_no_snoop.id
  condition = "hostname in [\"dc1-borderleaf-001-leaf1\",\"dc1-borderleaf-001-leaf2\"]"
  name = "dhcp-no-snoop"
}
