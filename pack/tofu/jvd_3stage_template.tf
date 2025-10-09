# create template with three racks - single, ESI and border

resource "apstra_template_rack_based" "dc1_template" {
  name                     = "dc1_template"
  asn_allocation_scheme    = "unique"
  overlay_control_protocol = "evpn"
  spine = {
    logical_device_id = local.derived_logical_device_size[var.spine_model]
    count             = 2
  }
  rack_infos = {
     (apstra_rack_type.DC1-Single.id) = { count = 1 }
     (apstra_rack_type.DC1-ESI.id) = { count = 1 }
     (apstra_rack_type.DC1-BorderLeaf.id) = { count = 1 }
  }
}

