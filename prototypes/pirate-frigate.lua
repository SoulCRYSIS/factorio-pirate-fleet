local width = 704
local height = 704

local function make_frigate(scale, health, size_name)
  local range_scale = (scale - 1) * 0.5 + 1
  return {
    type = "unit",
    name = "pirate-frigate-" .. size_name,
    icon = "__pirate-fleet__/graphics/icons/pirate-frigate.png",
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    subgroup = "enemies",
    order = "pirate-b",
    collision_box = { { -0.5 * scale, -0.75 * scale }, { 0.5 * scale, 0.75 * scale } },
    sticker_box = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
    selection_box = { { -1 * scale, -1.5 * scale }, { 1 * scale, 1.5 * scale } },
    attack_parameters = {
      type = "projectile",
      range = 20 * range_scale,
      cooldown = 360,
      ammo_category = "melee",
      ammo_type = {
        target_type = "entity",
        action = {
          type = "direct",
          action_delivery = {
            type = "delayed",
            delayed_trigger = "frigate-barrel-projectile-shooting-sequence-" .. size_name,
          },
        },
      },
      animation = {
        layers = {
          {
            filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate.png",
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
        shift = { 0, -5 * scale },
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
    dying_explosion = "pirate-skirmisher-explosion-" .. size_name,
    run_animation = {
      layers = {
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
        },
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate-shadow.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
          draw_as_shadow = true,
        },
        {
          filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate-glow.png",
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
        filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate-water-reflection.png",
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
  make_frigate(1, 2000, "small"),
  make_frigate(1.25, 4800, "medium"),
  make_frigate(1.6, 10000, "big"),
  make_frigate(2, 20000, "behemoth"),
})
