local sounds = require("__base__/prototypes/entity/sounds")

local width = 256
local height = 256

local function make_cannoniere(scale, health, size_name)
  local range_scale = (scale - 1) * 0.5 + 1
  return {
    type = "unit",
    name = "pirate-cannoniere-" .. size_name,
    icon = "__pirate-fleet__/graphics/icons/pirate-cannoniere.png",
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    subgroup = "enemies",
    order = "pirate-a",
    collision_box = { { -0.25 * scale, -0.4 * scale }, { 0.25 * scale, 0.4 * scale } },
    sticker_box = { { -0.25 * scale, -0.25 * scale }, { 0.25 * scale, 0.25 * scale } },
    selection_box = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.8 * scale } },
    attack_parameters = {
      type = "projectile",
      range = 16 * range_scale,
      cooldown = 180,
      ammo_category = "melee",
      projectile_creation_distance = 0.5 * scale,
      sound = sounds.tank_gunshot,
      ammo_type = {
        target_type = "entity",
        clamp_position = true,
        action = {
          type = "direct",
          action_delivery = {
            type = "stream",
            stream = "pirate-cannoniere-projectile-stream-" .. size_name,
            source_offset = { 0, 0.25 },
          },
        },
      },
      animation = {
        layers = {
          {
            filename = "__pirate-fleet__/graphics/entities/pirate-cannoniere/pirate-cannoniere.png",
            width = width,
            height = height,
            scale = 0.5 * scale,
            line_length = 8,
            lines_per_file = 8,
            direction_count = 64
          }
        }
      }
    },
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = { 0, -4 * scale },
        size = 1 * scale,
        intensity = 0.7,
        color = { 0.8, 0.7, 0.5 }
      },
    },
    vision_distance = 50,
    movement_speed = 0.05,
    rotation_speed = 0.005,
    distance_per_frame = 1,
    healing_per_tick = health / 60 / 60 / 5,
    distraction_cooldown = 300,
    min_pursue_time = 300,
    max_pursue_distance = 100,
    dying_explosion = "explosion",
    run_animation = {
      layers = {
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-cannoniere/pirate-cannoniere.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
        },
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-cannoniere/pirate-cannoniere-shadow.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
          draw_as_shadow = true,
        },
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-cannoniere/pirate-cannoniere-glow.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
          draw_as_glow = true,
          blend_mode = "additive",
        }
      }
    },
    water_reflection = {
      rotate = true,
      pictures = {
        variation_count = 16,
        filename = "__pirate-fleet__/graphics/entities/pirate-cannoniere/pirate-cannoniere-water-reflection.png",
        lines_per_file = 4,
        line_length = 4,
        width = width + 40,
        height = height + 40,
        scale = 0.5 * scale,
      }
    },
    collision_mask = { layers = { object = true, train = true, ground_tile = true } }, -- Can move on water
  }
end

data:extend({
  make_cannoniere(1, 500, "small"),
  make_cannoniere(1.25, 1200, "medium"),
  make_cannoniere(1.6, 2500, "big"),
  make_cannoniere(2, 5000, "behemoth"),
})
