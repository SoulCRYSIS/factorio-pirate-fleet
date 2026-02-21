local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
  {
    type = "damage-type",
    name = "piercing",
  },
  {
    type = "ammo-category",
    name = "bolt",
    icon = "__pirate-fleet-graphics__/icons/steel-bolt.png",
    subgroup = "ammo-category"
  },
  -- Steel bolt
  {
    type = "ammo",
    name = "steel-bolt",
    icon = "__pirate-fleet-graphics__/icons/steel-bolt.png",
    order = "va",
    ammo_category = "bolt",
    subgroup = "ammo",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 5 * kg,
    ammo_type =
    {
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "steel-bolt",
          starting_speed = 3
        },
      }
    }
  },
  {
    type = "projectile",
    name = "steel-bolt",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0,
    turn_speed = 0.001,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 20,
            particle_name = "wooden-chest-wooden-splinter-particle-small",
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.5,
            initial_height_deviation = 0.44,
            initial_vertical_speed = 0.069,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.046
          },
          {
            type = "damage",
            damage = { amount = 500, type = "piercing" }
          },
          {
            type = "push-back",
            distance = 0.2,
          }
        }
      }
    },
    animation = {
      filename = "__pirate-fleet-graphics__/entities/ballista-turret/steel-bolt-projectile.png",
      width = 16,
      height = 210,
      scale = 0.5,
      priority = "high",
    },
    shadow = {
      filename = "__pirate-fleet-graphics__/entities/ballista-turret/steel-bolt-projectile.png",
      width = 16,
      height = 210,
      scale = 0.5,
      priority = "high",
      draw_as_shadow = true,
    },
    smoke = {
      {
        name = "smoke-fast",
        deviation = { 0.1, 0.1 },
        frequency = 1,
        position = { 0, 2 },
        starting_frame = 3,
        starting_frame_deviation = 5
      }
    },
  },
  {
    type = "recipe",
    name = "steel-bolt",
    category = "crafting",
    ingredients = {
      { type = "item", name = "steel-plate", amount = 2 },
      { type = "item", name = "wood",        amount = 2 },
    },
    results = { { type = "item", name = "steel-bolt", amount = 1 } },
    energy_required = 8,
    enabled = false,
  },

  -- Charged bolt
  {
    type = "ammo",
    name = "charged-bolt",
    icon = "__pirate-fleet-graphics__/icons/charged-bolt.png",
    order = "vb",
    ammo_category = "bolt",
    subgroup = "ammo",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 10 * kg,
    ammo_type =
    {
      target_type = "direction",
      clamp_position = true,
      action =
      {
        type = "line",
        range = 45,
        width = 1,
        force = "enemy",
        range_effects =
        {
          type = "create-explosion",
          entity_name = "charged-bolt-beam",
          only_when_visible = true
        },
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            damage = { amount = 300, type = "piercing" }
          },
        }
      }
    }
  },
  {
    type = "explosion",
    name = "charged-bolt-beam",
    icon = "__pirate-fleet-graphics__/icons/charged-bolt.png",
    flags = { "not-on-map" },
    hidden = true,
    subgroup = "explosions",
    rotate = true,
    beam = true,
    animations =
    {
      {
        filename = "__pirate-fleet-graphics__/entities/ballista-turret/charged-bolt-beam.png",
        priority = "extra-high",
        width = 32,
        height = 440,
        frame_count = 16,
        animation_speed = 1,
        draw_as_glow = true,
        blend_mode = "additive",
      }
    },
    light = { intensity = 1, size = 10, color = { r = 0.9, g = 0.7, b = 0.6 } },
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1
  },
  {
    type = "recipe",
    name = "charged-bolt",
    category = "crafting",
    ingredients = {
      { type = "item", name = "explosives", amount = 2 },
      { type = "item", name = "steel-bolt", amount = 1 },
    },
    results = { { type = "item", name = "charged-bolt", amount = 1 } },
    energy_required = 2,
    enabled = false,
  },

  -- Ignition bolt
  {
    type = "ammo",
    name = "ignition-bolt",
    icon = "__pirate-fleet-graphics__/icons/ignition-bolt.png",
    order = "vc",
    ammo_category = "bolt",
    subgroup = "ammo",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 10 * kg,
    ammo_type =
    {
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "ignition-bolt",
          starting_speed = 3
        },
      }
    }
  },
  {
    type = "projectile",
    name = "ignition-bolt",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0,
    turn_speed = 0.01,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "medium-explosion",
            only_when_visible = true
          },
          {
            type = "damage",
            damage = { amount = 100, type = "piercing" }
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 4.5,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = { amount = 300, type = "fire" }
                  },
                  {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    offset_deviation = { { -1, -1 }, { 1, 1 } },
                  },
                  {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    show_in_tooltip = true,
                  }
                }
              }
            }
          }
        }
      }
    },
    animation = {
      layers = {
        {
          filename = "__pirate-fleet-graphics__/entities/ballista-turret/steel-bolt-projectile.png",
          width = 64,
          height = 210,
          scale = 0.5,
          priority = "high",
          repeat_count = 8,
          rotate_shift = true,
        },
        {
          filename = "__pirate-fleet-graphics__/entities/ballista-turret/ignition-bolt-projectile.png",
          width = 64,
          height = 210,
          frame_count = 8,
          line_length = 8,
          scale = 0.5,
          animation_speed = 0.5,
          priority = "high",
          draw_as_glow = true,
          rotate_shift = true,
        },
      }
    },
    shadow = {
      filename = "__pirate-fleet-graphics__/entities/ballista-turret/steel-bolt-projectile.png",
      width = 64,
      height = 210,
      scale = 0.5,
      priority = "high",
      draw_as_shadow = true,
    },
    smoke = {
      {
        name = "smoke-explosion-particle",
        deviation = { 0.1, 0.1 },
        frequency = 1,
        position = { 0, 2 },
        starting_frame = 3,
        starting_frame_deviation = 5
      }
    },
    light = {
      intensity = 0.7,
      size = 5,
      color = { r = 1.0, g = 0.6, b = 0.4 },
      shift = { 0, -1.4 },
    },
  },
  {
    type = "recipe",
    name = "ignition-bolt",
    category = "crafting-with-fluid",
    ingredients = {
      { type = "fluid", name = "light-oil",  amount = 10 },
      { type = "item",  name = "steel-bolt", amount = 1 },
      { type = "item",  name = "explosives", amount = 1 },
    },
    results = { { type = "item", name = "ignition-bolt", amount = 1 } },
    energy_required = 2,
    enabled = false,
  },
})
