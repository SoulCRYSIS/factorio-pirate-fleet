local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local item_sounds = require("__base__.prototypes.item_sounds")

local width = 448
local height = 448

local filenames = {
  "__pirate-fleet__/graphics/entities/ballista-turret/ballista-turret-1.png",
  "__pirate-fleet__/graphics/entities/ballista-turret/ballista-turret-2.png",
  "__pirate-fleet__/graphics/entities/ballista-turret/ballista-turret-3.png",
  "__pirate-fleet__/graphics/entities/ballista-turret/ballista-turret-4.png",
}
local shift = { 0, -0.75 }

data:extend({
  {
    type = "item",
    name = "ballista-turret",
    icon = "__pirate-fleet__/graphics/icons/ballista-turret.png",
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
    ingredients = {
      { type = "item", name = "processing-unit", amount = 2 },
      { type = "item", name = "carbon-fiber",    amount = 10 },
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
    icon = "__pirate-fleet__/graphics/icons/ballista-turret.png",
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "ballista-turret" },
    fast_replaceable_group = "ammo-turret",
    max_health = 800,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.2, -1.2 }, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    drawing_box_vertical_extension = 0.2,
    damaged_trigger_effect = hit_effects.entity(),
    allow_turning_when_starting_attack = true,
    start_attacking_only_when_can_shoot = true,
    rotation_speed = 0.015,
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.25,
    starting_attack_speed = 0.25,
    ending_attack_speed = 0.025,
    resistances = {
      { type = "fire", percent = -30 },
      { type = "electric", percent = 80 },
      { type = "physical", percent = 30 },
    },
    alert_when_attacking = true,
    circuit_connector = circuit_connector_definitions["gun-turret"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    open_sound = sounds.turret_open,
    close_sound = sounds.turret_close,
    folded_animation = {
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
    attacking_animation = {
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
    starting_attack_animation = {
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
    ending_attack_animation = {
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
    graphics_set = data.raw["ammo-turret"]["rocket-turret"].graphics_set,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "ballista-bolt",
      cooldown = 150,
      projectile_creation_distance = 1.75,
      projectile_center = { 0, shift[2] + 0.25},
      apply_projection_to_projectile_creation_position = false,
      range = 40,
      min_range = 5,
      sound = sounds.gun_turret_gunshot,
      true_collinear_ejection = true
    },

    call_for_help_radius = 40,
    water_reflection = data.raw["ammo-turret"]["rocket-turret"].water_reflection,
  }
})
