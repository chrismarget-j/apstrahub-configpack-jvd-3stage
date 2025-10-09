
# Create a Connectivity Template for the RED VNs and assign to all interfaces tagged with dc_3stage_red TAG.

resource "apstra_datacenter_connectivity_template_interface" "red_ct" {
  blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
  name         = "dc_3stage_red_ct"
  description  = "DC VN1 Red"
  virtual_network_multiples = {
     group1 = {
         tagged_vn_ids = [apstra_datacenter_virtual_network.dc_3stage_vn1_red.id,
                          apstra_datacenter_virtual_network.dc_3stage_vn2_red.id,
         ]
    }
  }
}

resource "apstra_datacenter_connectivity_template_assignments" "assign_ct_dc_3stage_vn_red" {
  blueprint_id              = apstra_datacenter_blueprint.DC1-3Stage.id
  application_point_ids     = data.apstra_datacenter_interfaces_by_link_tag.red_all.ids
  connectivity_template_id =  apstra_datacenter_connectivity_template_interface.red_ct.id
}




# Create a Connectivity Template for the BLUE VNs and assign to all interfaces tagged with dc_3stage_blue TAG.

resource "apstra_datacenter_connectivity_template_interface" "blue_ct" {
  blueprint_id = apstra_datacenter_blueprint.DC1-3Stage.id
  name         = "dc_3stage_blue_ct"
  description  = "DC VN1 Blue"
  virtual_network_multiples = {
     group1 = {
         tagged_vn_ids = [apstra_datacenter_virtual_network.dc_3stage_vn1_blue.id,
                          apstra_datacenter_virtual_network.dc_3stage_vn2_blue.id,
         ]
    }
  }
}

resource "apstra_datacenter_connectivity_template_assignments" "assign_ct_dc_3stage_vn_blue" {
  blueprint_id              = apstra_datacenter_blueprint.DC1-3Stage.id
  application_point_ids     = data.apstra_datacenter_interfaces_by_link_tag.blue_all.ids
  connectivity_template_id =  apstra_datacenter_connectivity_template_interface.blue_ct.id
}

