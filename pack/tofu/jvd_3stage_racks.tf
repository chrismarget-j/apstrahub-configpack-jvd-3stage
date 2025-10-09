resource "apstra_rack_type" "DC1-Single" {
  name                       = "DC1-Single"
  description                = "Created by Terraform"
  fabric_connectivity_design = "l3clos"
  leaf_switches = { 
    "single_leaf" = { 
      logical_device_id   = local.derived_logical_device_size[var.single_leaf_model]
      spine_link_count    = 1
      spine_link_speed    = "100G"
    }
  }
  generic_systems = {
    single = {
      count             = 1
      logical_device_id = "AOS-1x10-1"
      links = {
        single_10G = {
          tag_ids            = [
                                resource.apstra_tag.vntags["red_all"].id,
                                resource.apstra_tag.vntags["blue_all"].id
                               ]
          speed              = "10G"
          target_switch_name = "single_leaf"
        }
      }
    }
  }
}



resource "apstra_rack_type" "DC1-ESI" {
  name                       = "DC1-ESI"
  description                = "Created by Terraform"
  fabric_connectivity_design = "l3clos"
  leaf_switches = {
    "esi_leaf" = {
      logical_device_id   = local.derived_logical_device_size[var.esi_leaf_model]
      spine_link_count    = 1
      spine_link_speed    = "100G"
      redundancy_protocol = "esi"
    }
  }
  generic_systems = {
    esi_single1 = {
      count             = 1
      logical_device_id = "AOS-1x10-1"
      links = {
        esi_single1_10G = {
          tag_ids            = [
                                resource.apstra_tag.vntags["red_all"].id,
                                resource.apstra_tag.vntags["blue_all"].id
                               ]
          speed              = "10G"
          target_switch_name = "esi_leaf"
          switch_peer        = "first"
        }
      }
    },
    esi_single2 = {
      count             = 1
      logical_device_id = "AOS-1x10-1"
      links = {
        esi_single2_10G = {
          tag_ids            = [
                                resource.apstra_tag.vntags["red_all"].id,
                                resource.apstra_tag.vntags["blue_all"].id
                               ]
          speed              = "10G"
          target_switch_name = "esi_leaf"
          switch_peer        = "second"
        }
      }
    },
    esi3 = {
      count             = 1
      logical_device_id = "AOS-2x10-1"
      links = {
        esi3_lag = {
          tag_ids            = [
                                resource.apstra_tag.vntags["red_all"].id,
                                resource.apstra_tag.vntags["blue_all"].id
                               ]
          speed              = "10G"
          target_switch_name = "esi_leaf"
          lag_mode           = "lacp_active"
        }
      }
    },
    esi4 = {
      count             = 1
      logical_device_id = "AOS-2x10-1"
      links = {
        esi4_lag = {
          tag_ids            = [
                                resource.apstra_tag.vntags["red_all"].id,
                                resource.apstra_tag.vntags["blue_all"].id
                               ]
          speed              = "10G"
          target_switch_name = "esi_leaf"
          lag_mode           = "lacp_active"
        }
      }
    }
  }
}




resource "apstra_rack_type" "DC1-BorderLeaf" {
  name                       = "DC1-BorderLeaf"
  description                = "Created by Terraform"
  fabric_connectivity_design = "l3clos"
  leaf_switches = {
    "border_leaf" = {
      logical_device_id   = local.derived_logical_device_size[var.borderleaf_model]
      spine_link_count    = 1
      spine_link_speed    = "100G"
      redundancy_protocol = "esi"
    }
  }
  generic_systems = {
    dc1_external = {
      count             = 1
      logical_device_id = "AOS-2x10-1"
      links = {
        dc1_external_10G = {
          tag_ids            = [
                                resource.apstra_tag.vntags["mx_external_link1"].id
                               ]
          speed              = "10G"
          target_switch_name = "border_leaf"
          switch_peer        = "first"
        },
        dc1_externa1_10G_2 = {
          tag_ids            = [
                                resource.apstra_tag.vntags["mx_external_link2"].id
                               ]
          speed              = "10G"
          target_switch_name = "border_leaf"
          switch_peer        = "second"
        }
      }
    }
  }
 }




data "apstra_datacenter_interfaces_by_link_tag" "red_all" {
    blueprint_id= apstra_datacenter_blueprint.DC1-3Stage.id
    tags= ["red_all"]
}

data "apstra_datacenter_interfaces_by_link_tag" "blue_all" {
    blueprint_id= apstra_datacenter_blueprint.DC1-3Stage.id
    tags= ["blue_all"]
}

data "apstra_datacenter_interfaces_by_link_tag" "mx_external_link1" {
    blueprint_id= apstra_datacenter_blueprint.DC1-3Stage.id
    tags= ["mx_external_link1"]
}

data "apstra_datacenter_interfaces_by_link_tag" "mx_external_link2" {
    blueprint_id= apstra_datacenter_blueprint.DC1-3Stage.id
    tags= ["mx_external_link2"]
}

