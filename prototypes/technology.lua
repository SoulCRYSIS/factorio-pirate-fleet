data:extend({
  {
    type = "technology",
    name = "ballista-technology",
    icon = "__pirate-fleet__/graphics/icons/ballista-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ballista-turret",
      },
      {
        type = "unlock-recipe",
        recipe = "ballista-bolt",
      },
    },
    prerequisites = { "tree-seeding", "carbon-fiber" },
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
    name = "ballista-damage-1",
    icons = util.technology_icon_constant_damage("__pirate-fleet__/graphics/icons/ballista-bolt-large.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "ballista-bolt",
        modifier = 0.3
      },
    },
    prerequisites = { "ballista-technology" },
    research_trigger = {
      type = "craft-item",
      item = "ballista-bolt",
      count = 2000,
    }
  },
  {
    type = "technology",
    name = "ballista-damage-2",
    icons = util.technology_icon_constant_damage("__pirate-fleet__/graphics/icons/ballista-bolt-large.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "ballista-bolt",
        modifier = 0.4
      },
    },
    prerequisites = { "ballista-damage-1" },
    research_trigger = {
      type = "craft-item",
      item = "ballista-bolt",
      count = 4000,
    }
  },
  {
    type = "technology",
    name = "ballista-damage-3",
    icons = util.technology_icon_constant_damage("__pirate-fleet__/graphics/icons/ballista-bolt-large.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "ballista-bolt",
        modifier = 0.5
      },
    },
    prerequisites = { "ballista-damage-2" },
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
    name = "ballista-speed-1",
    icons = util.technology_icon_constant_speed("__pirate-fleet__/graphics/icons/ballista-bolt-large.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "ballista-bolt",
        modifier = 0.2
      },
    },
    prerequisites = { "ballista-damage-2" },
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
  }
})
