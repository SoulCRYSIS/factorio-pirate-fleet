local utils = require("prototypes.utils")

local width = 704
local height = 704

local function make_frigate_barrel_projectile(scale, size_name)
  local damage_scale = (scale - 1) * 0.5 + 1
  data:extend({
    {
      type = "delayed-active-trigger",
      name = "frigate-barrel-projectile-shooting-sequence-" .. size_name,
      delay = 1,
      repeat_delay = 20,
      repeat_count = 2,
      action = {
        type = "direct",
        action_delivery = {
          type = "stream",
          stream = "frigate-barrel-projectile-stream-" .. size_name,
        },
      }
    },
    {
      type = "trivial-smoke",
      name = "frigate-barrel-projectile-smoke-trail-" .. size_name,
      animation =
      {
        filename = "__base__/graphics/entity/smoke-fast/smoke-fast.png",
        priority = "high",
        width = 50,
        height = 50,
        frame_count = 16,
        animation_speed = 16 / 60,
        scale = 0.8 * scale,
      },
      duration = 60,
      fade_away_duration = 60,
      show_when_smoke_off = true,
    },
    {
      type = "stream",
      name = "frigate-barrel-projectile-stream-" .. size_name,
      action = {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = size_name .. "-strafer-pentapod-die",
              only_when_visible = true
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
                radius = 2 * damage_scale,
                force = "enemy",
                action_delivery =
                {
                  type = "instant",
                  target_effects =
                  {
                    type = "damage",
                    damage = { amount = 20 * damage_scale, type = "physical" }
                  },
                }
              }
            },
            {
              type = "create-entity",
              entity_name = size_name .. "-wriggler-pentapod-premature",
              offset_deviation = { { -1 * scale, -1 * scale }, { 1 * scale, 1 * scale } },
              check_buildability = true,
              find_non_colliding_position = true,
              repeat_count = 3,
            },
          }
        }
      },
      flags = { "not-on-map" },
      hidden = true,
      ground_light = {
        color = { r = 1, g = 0.5, b = 0.9 },
        intensity = 0.2,
        size = 10 * scale
      },
      stream_light = {
        color = { r = 1, g = 0.5, b = 0.9 },
        intensity = 0.5,
        size = 3 * scale
      },
      oriented_particle = true,
      particle = {
        filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate-barrel.png",
        width = 96,
        height = 96,
        animation_speed = 0.5,
        frame_count = 16,
        line_length = 4,
        scale = 0.4 * scale,
      },
      shadow = {
        draw_as_shadow = true,
        filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate-barrel-shadow.png",
        width = 96,
        height = 96,
        animation_speed = 0.5,
        frame_count = 16,
        line_length = 4,
        scale = 0.4 * scale,
      },
      particle_buffer_size = 1,
      particle_end_alpha = 1,
      particle_fade_out_threshold = 1,
      particle_horizontal_speed = 0.15,
      particle_horizontal_speed_deviation = 0.03,
      particle_loop_exit_threshold = 1,
      particle_loop_frame_count = 1,
      particle_spawn_interval = 0,
      particle_spawn_timeout = 1,
      particle_start_alpha = 1,
      particle_start_scale = 1,
      particle_vertical_acceleration = 0.003,
      progress_to_create_smoke = 0.03,
      smoke_sources = {
        {
          name = "frigate-barrel-projectile-smoke-trail-" .. size_name,
          deviation = { 0.1, 0.1 },
          frequency = 1 / scale,
          position = { 0, 0 },
          starting_frame = 4,
          starting_frame_deviation = 4,
        }
      },
    }
  })
end

local function make_frigate(tier)
  local scale = tier.scale
  local health = tier.health_scale * 2000
  local size_name = tier.name
  make_frigate_barrel_projectile(scale, size_name)
  local range_scale = (scale - 1) * 0.7 + 1
  return {
    type = "unit",
    name = "pirate-frigate-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-frigate.png",
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    subgroup = "enemies",
    order = "pirate-b",
    collision_box = { { -0.5 * scale, -0.75 * scale }, { 0.5 * scale, 0.75 * scale } },
    sticker_box = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
    selection_box = { { -1 * scale, -1.5 * scale }, { 1 * scale, 1.5 * scale } },
    resistances = {
      { type = "physical",  decrease = 5 * scale, percent = 30 },
      { type = "explosion", percent = 30 },
      { type = "electric",  percent = 80 },
      { type = "laser",     percent = 50 },
      { type = "piercing",  percent = -20 },
    },
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
            filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate.png",
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
    dying_explosion = "pirate-frigate-explosion-" .. size_name,
    run_animation = {
      layers = {
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
        },
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate-shadow.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
          draw_as_shadow = true,
        },
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate-glow.png",
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
        filename = "__pirate-fleet-graphics__/entities/pirate-frigate/pirate-frigate-water-reflection.png",
        lines_per_file = 4,
        line_length = 4,
        width = width + 40,
        height = height + 40,
        scale = 0.5 * scale,
      }
    },
    collision_mask = { layers = { object = true, train = true, ground_tile = true } }, -- Can move on water
    absorptions_to_join_attack = utils.absorption_to_join_attack(2, tier.pollution_scale),
    ai_settings = {
      join_attacks = true,
      allow_try_return_to_spawner = true,
      do_separation = true,
    },
  }
end

for _, tier in pairs(utils.tiers) do
  data:extend({
    make_frigate(tier),
  })
end