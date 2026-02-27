data:extend({
  {
    type = "double-setting",
    name = "pirate-health",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.1,
    maximum_value = 100.0,
    order = "pirate-a",
  },
  {
    type = "double-setting",
    name = "pirate-damage",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.1,
    maximum_value = 100.0,
    order = "pirate-b",
  },
  {
    type = "bool-setting",
    name = "pirate-nauvis-enable",
    setting_type = "startup",
    default_value = false,
    order = "pirate-ca",
  },
  {
    type = "bool-setting",
    name = "pirate-gleba-enable",
    setting_type = "startup",
    default_value = true,
    order = "pirate-cb",
  },
})
