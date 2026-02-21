data:extend({
  {
    type = "technology",
    name = "ballista-technology",
    icon = "__pirate-fleet-graphics__/icons/ballista-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ballista-turret",
      },
      {
        type = "unlock-recipe",
        recipe = "steel-bolt",
      },
    },
    prerequisites = { "tree-seeding" },
    unit =
    {
      ingredients =
      {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "military-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "space-science-pack",        1 },
        { "agricultural-science-pack", 1 }
      },
      time = 60,
      count = 2000
    },
  },
  {
    type = "technology",
    name = "bolt-damage-1",
    icon = "__pirate-fleet-graphics__/icons/charged-bolt-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt",
        modifier = 0.3
      },
      {
        type = "unlock-recipe",
        recipe = "charged-bolt",
      }
    },
    prerequisites = { "ballista-technology" },
    research_trigger = {
      type = "craft-item",
      item = "steel-bolt",
      count = 1000,
    }
  },

  {
    type = "technology",
    name = "bolt-damage-2",
    icons = util.technology_icon_constant_damage("__pirate-fleet-graphics__/icons/bolt-technology.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt",
        modifier = 0.4
      },
    },
    prerequisites = { "bolt-damage-1" },
    research_trigger = {
      type = "craft-item",
      item = "steel-bolt",
      count = 2000,
    }
  },
  {
    type = "technology",
    name = "bolt-damage-3",
    icons = util.technology_icon_constant_damage("__pirate-fleet-graphics__/icons/bolt-technology.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt",
        modifier = 0.5
      },
    },
    prerequisites = { "bolt-damage-2" },
    unit =
    {
      count_formula = "2^(L-3)*1000",
      ingredients =
      {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "military-science-pack",     1 },
        { "utility-science-pack",      1 },
        { "space-science-pack",        1 },
        { "agricultural-science-pack", 1 }
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true
  },
  {
    type = "technology",
    name = "bolt-speed-1",
    icons = util.technology_icon_constant_speed("__pirate-fleet-graphics__/icons/bolt-technology.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bolt",
        modifier = 0.2
      },
    },
    prerequisites = { "bolt-damage-2" },
    unit =
    {
      count_formula = "2^(L-1)*1000",
      ingredients =
      {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "military-science-pack",     1 },
        { "utility-science-pack",      1 },
        { "space-science-pack",        1 },
        { "agricultural-science-pack", 1 }
      },
      time = 60
    },
    max_level = 10,
    upgrade = true
  },
  {
    type = "technology",
    name = "ignition-bolt-technology",
    icon = "__pirate-fleet-graphics__/icons/ignition-bolt-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ignition-bolt",
      },
    },
    prerequisites = { "bolt-damage-2", "flammables" },
    unit =
    {
      count = 1000,
      ingredients =
      {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "military-science-pack",     1 },
        { "utility-science-pack",      1 },
        { "space-science-pack",        1 },
      },
      time = 60
    },
  }
})
