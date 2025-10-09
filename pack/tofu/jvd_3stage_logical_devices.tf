resource "apstra_logical_device" "DC1-Leaf" {
  name = "DC1-Leaf"
  panels = [
    {
      rows = 2
      columns = 24
      port_groups = [
        {
          port_count = 48
          port_speed = "10G"
          port_roles = ["generic", "peer", "access"]
        }
      ]
    },
    {
      rows = 2
      columns = 3
      port_groups = [
        {
          port_count = 6
          port_speed = "100G"
          port_roles = ["generic", "spine"]
        }
      ]
    }
  ]
}

resource "apstra_logical_device" "DC1-Leaf-small" {
  name = "DC1-Leaf-small"
  panels = [
    {
      rows = 2
      columns = 24
      port_groups = [
        {
          port_count = 48
          port_speed = "10G"
          port_roles = ["generic", "peer", "access"]
        }
      ]
    },
    {
      rows = 2
      columns = 2
      port_groups = [
        {
          port_count = 4
          port_speed = "100G"
          port_roles = ["generic", "spine"]
        }
      ]
    }
  ]
}


resource "apstra_logical_device" "DC1-Spine-small" {
  name = "DC1-Spine-small"
  panels = [
    {
      rows = 2
      columns = 4
      port_groups = [
        {
          port_count = 8
          port_speed = "100G"
          port_roles = ["leaf", "generic"]
        }
      ]
    }
  ]
}

resource "apstra_logical_device" "DC1-Spine-large" {
  name = "DC1-Spine-large"
  panels = [
    {
      rows = 2
      columns = 16
      port_groups = [
        {
          port_count = 32
          port_speed = "100G"
          port_roles = ["leaf", "generic"]
        }
      ]
    }
  ]
}
