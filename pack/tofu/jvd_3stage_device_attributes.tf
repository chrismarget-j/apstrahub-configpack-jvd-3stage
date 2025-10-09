# define mgmt addresses for each device to be onboarded

locals {
    devices = {
        spine1 = {
            label = "spine1", 
            interface_map = local.derived_if_map_id[var.spine_model]
        },
        spine2 = {
            label = "spine2", 
            interface_map = local.derived_if_map_id[var.spine_model]
        },
        dc1_single_001_leaf1 = {
            label = "dc1_single_001_leaf1", 
            interface_map = local.derived_if_map_id[var.single_leaf_model]
        },   
        dc1_esi_001_leaf1 = {
            label = "dc1_esi_001_leaf1", 
            interface_map = local.derived_if_map_id[var.esi_leaf_model]
        },  
        dc1_esi_001_leaf2 = {
            label = "dc1_esi_001_leaf2",
            interface_map = local.derived_if_map_id[var.esi_leaf_model]
        },
        dc1_borderleaf_001_leaf1 = {
            label = "dc1_borderleaf_001_leaf1",
            interface_map = local.derived_if_map_id[var.borderleaf_model]
        },
        dc1_borderleaf_001_leaf2 = {
            label = "dc1_borderleaf_001_leaf2",
            interface_map = local.derived_if_map_id[var.borderleaf_model]
        }
    }
}

