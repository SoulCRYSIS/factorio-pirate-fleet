local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local item_sounds = require("__base__.prototypes.item_sounds")

local width = 448
local height = 448

local filenames = {
  "__pirate-fleet-graphics__/entities/ballista-turret/ballista-turret-1.png",
  "__pirate-fleet-graphics__/entities/ballista-turret/ballista-turret-2.png",
  "__pirate-fleet-graphics__/entities/ballista-turret/ballista-turret-3.png",
  "__pirate-fleet-graphics__/entities/ballista-turret/ballista-turret-4.png",
}
local shift = { 0, -0.75 }
local function shadow_layers(frame_count)
  return {
    filename = "__pirate-fleet-graphics__/entities/ballista-turret/ballista-turret-shadow.png",
    width = 384,
    height = 384,
    direction_count = 64,
    line_length = 8,
    lines_per_file = 8,
    frame_count = 1,
    repeat_count = frame_count,
    scale = 0.5,
    shift = { 0.75, 0 },
    draw_as_shadow = true,
  }
end

data:extend({
  {
    type = "item",
    name = "ballista-turret",
    icon = "__pirate-fleet-graphics__/icons/ballista-turret.png",
    order = "v",
    subgroup = "turret",
    stack_size = 20,
    weight = 50 * kg,
    inventory_move_sound = item_sounds.turret_inventory_move,
    pick_sound = item_sounds.turret_inventory_pickup,
    drop_sound = item_sounds.turret_inventory_move,
    place_result = "ballista-turret",
    default_import_location = "nauvis",
  },
  {
    type = "recipe",
    name = "ballista-turret",
    order = "v",
    category = "crafting",
    ingredients = {
      { type = "item", name = "processing-unit", amount = 4 },
      { type = "item", name = "steel-plate",     amount = 20 },
      { type = "item", name = "wood",            amount = 20 },
    },
    results = { { type = "item", name = "ballista-turret", amount = 1 } },
    energy_required = 10,
    enabled = false,
  },
  {
    type = "ammo-turret",
    name = "ballista-turret",
    icon = "__pirate-fleet-graphics__/icons/ballista-turret.png",
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "ballista-turret" },
    max_health = 800,
    corpse = "rocket-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    drawing_box_vertical_extension = 0.2,
    damaged_trigger_effect = hit_effects.entity(),
    allow_turning_when_starting_attack = true,
    start_attacking_only_when_can_shoot = true,
    rotation_speed = 0.01,
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.25,
    starting_attack_speed = 0.25,
    ending_attack_speed = 0.025,
    resistances = {
      { type = "fire",     percent = -30 },
      { type = "electric", percent = 80 },
      { type = "physical", percent = 30 },
    },
    alert_when_attacking = true,
    circuit_connector = circuit_connector_definitions["gun-turret"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    open_sound = sounds.turret_open,
    close_sound = sounds.turret_close,
    folded_animation = {
      layers = {
        {
          filenames = filenames,
          direction_count = 64,
          line_length = 1,
          lines_per_file = 16,
          frame_count = 1,
          scale = 0.5,
          width = width,
          height = height,
          shift = shift,
          x = width * 7,
        },
        shadow_layers(1),
      }
    },
    attacking_animation = {
      layers = {
        {
          filenames = filenames,
          direction_count = 64,
          line_length = 1,
          lines_per_file = 16,
          frame_count = 1,
          scale = 0.5,
          width = width,
          height = height,
          shift = shift,
        },
        shadow_layers(1),
      },
    },
    starting_attack_animation = {
      layers = {
        {
          filenames = filenames,
          direction_count = 64,
          line_length = 8,
          lines_per_file = 16,
          frame_count = 8,
          scale = 0.5,
          width = width,
          height = height,
          shift = shift,
          frame_sequence = { 6, 4 }
        },
        shadow_layers(2),
      }
    },
    ending_attack_animation = {
      layers = {
        {
          filenames = filenames,
          direction_count = 64,
          line_length = 8,
          lines_per_file = 16,
          frame_count = 8,
          scale = 0.5,
          width = width,
          height = height,
          shift = shift,
        },
        shadow_layers(8),
      }
    },
    graphics_set = data.raw["ammo-turret"]["rocket-turret"].graphics_set,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt",
      cooldown = 150,
      projectile_creation_distance = 1.75,
      fire_penalty = 1,
      rotate_penalty = 1,
      health_penalty = 0.5,
      projectile_center = { 0, shift[2] + 0.25 },
      apply_projection_to_projectile_creation_position = false,
      range = 40,
      min_range = 8,
      sound = sounds.gun_turret_gunshot,
      true_collinear_ejection = true
    },

    call_for_help_radius = 40,
    water_reflection = data.raw["ammo-turret"]["rocket-turret"].water_reflection,
  }
})
