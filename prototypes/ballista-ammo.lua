local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
  {
    type = "damage-type",
    name = "piercing",
  },
  {
    type = "ammo-category",
    name = "ballista-bolt",
    icon = "__pirate-fleet__/graphics/icons/ballista-bolt.png",
    subgroup = "ammo-category"
  },
  {
    type = "ammo",
    name = "ballista-bolt",
    icon = "__pirate-fleet__/graphics/icons/ballista-bolt.png",
    ammo_category = "ballista-bolt",
    subgroup = "ammo",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 5 * kg,
    ammo_type =
    {
      target_type = "direction",
      clamp_position = true,
      action =
      {
        type = "line",
        range = 45,
        width = 5,
        force = "enemy",
        range_effects =
        {
          type = "create-explosion",
          entity_name = "ballista-bolt-beam",
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
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot",
            only_when_visible = true
          }
        }
      }
    }
  },
  {
    type = "recipe",
    name = "ballista-bolt",
    category = "crafting",
    ingredients = {
      { type = "item", name = "explosives",  amount = 2 },
      { type = "item", name = "steel-plate", amount = 1 },
      { type = "item", name = "wood",        amount = 1 },
    },
    results = { { type = "item", name = "ballista-bolt", amount = 1 } },
    energy_required = 4,
    enabled = false,
  },
  {
    type = "explosion",
    name = "ballista-bolt-beam",
    icon = "__pirate-fleet__/graphics/icons/ballista-bolt.png",
    flags = {"not-on-map"},
    hidden = true,
    subgroup = "explosions",
    rotate = true,
    beam = true,
    animations =
    {
      {
        filename = "__pirate-fleet__/graphics/entities/ballista-turret/ballista-beam.png",
        priority = "extra-high",
        width = 32,
        height = 440,
        frame_count = 16,
        animation_speed = 1,
        draw_as_glow = true,
        blend_mode = "additive",
      }
    },
    light = {intensity = 1, size = 10, color = {r = 0.9, g = 0.7, b = 0.6}},
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1
  }
})
