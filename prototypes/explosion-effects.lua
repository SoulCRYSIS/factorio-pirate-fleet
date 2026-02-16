local explosion_animations = require("__base__.prototypes.entity.explosion-animations")
local sounds = require("__base__.prototypes.entity.sounds")

local function make_carrier_explosion(scale, size_name)
  return {
    type = "explosion",
    name = "pirate-carrier-explosion-" .. size_name,
    icon = "__pirate-fleet__/graphics/icons/pirate-carrier.png",
    flags = { "not-on-map" },
    hidden = true,
    subgroup = "enemy-death-explosions",
    order = "pirate-c",
    height = 1 * scale,
    animations = explosion_animations.massive_explosion(),
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound = sounds.large_explosion(0.8, 1.0),
    scale = scale,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 35,
            probability = 1,
            particle_name = "rocket-silo-metal-particle-big",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5, -0.5977 }, { 0.5, 0.5977 } },
            initial_height = 0.3,
            initial_height_deviation = 0.14,
            initial_vertical_speed = 0.194,
            initial_vertical_speed_deviation = 0.012,
            speed_from_center = 0.06,
            speed_from_center_deviation = 0.025
          },
          {
            type = "create-particle",
            repeat_count = 52,
            probability = 1,
            particle_name = "rocket-silo-metal-particle-medium",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.2969, -0.5 }, { 0.2969, 0.5 } },
            initial_height = 0.8,
            initial_height_deviation = 0.48,
            initial_vertical_speed = 0.135,
            initial_vertical_speed_deviation = 0.047,
            speed_from_center = 0.09,
            speed_from_center_deviation = 0
          },
          {
            type = "create-particle",
            repeat_count = 50,
            probability = 1,
            particle_name = "rocket-silo-metal-particle-small",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5, -0.5977 }, { 0.5, 0.5977 } },
            initial_height = 2.5,
            initial_height_deviation = 0.63,
            initial_vertical_speed = 0.109,
            initial_vertical_speed_deviation = 0.042,
            speed_from_center = 0.09,
            speed_from_center_deviation = 0.044
          },
          {
            type = "create-particle",
            repeat_count = 36,
            probability = 1,
            particle_name = "artillery-wagon-mechanical-component-particle-medium",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 1,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.131,
            initial_vertical_speed_deviation = 0.041,
            speed_from_center = 0.09,
            speed_from_center_deviation = 0.05
          }
        }
      }
    }
  }
end

local function make_skirmisher_explosion(scale, size_name)
  local explosion = table.deepcopy(data.raw["explosion"]["radar-explosion"])
  explosion.name = "pirate-skirmisher-explosion-" .. size_name
  explosion.icon = "__pirate-fleet__/graphics/icons/pirate-skirmisher.png"
  explosion.subgroup = "enemy-death-explosions"
  explosion.order = "pirate-d"
  explosion.height = 0.3 * scale
  explosion.scale = scale
  return explosion
end

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
        force = "enemy",
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
                radius = 1 * damage_scale,
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
        filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate-barrel.png",
        width = 96,
        height = 96,
        animation_speed = 0.5,
        frame_count = 16,
        line_length = 4,
        scale = 0.4 * scale,
      },
      shadow = {
        draw_as_shadow = true,
        filename = "__pirate-fleet__/graphics/entities/pirate-frigate/pirate-frigate-barrel-shadow.png",
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

local function make_cannoniere_projectile(scale, size_name)
  local damage_scale = (scale - 1) * 0.5 + 1
  data:extend({
    {
      type = "trivial-smoke",
      name = "cannoniere-projectile-smoke-trail-" .. size_name,
      animation =
      {
        filename = "__base__/graphics/entity/smoke-fast/smoke-fast.png",
        priority = "high",
        width = 50,
        height = 50,
        frame_count = 16,
        animation_speed = 16 / 60,
        scale = 0.4 * scale,
      },
      duration = 60,
      fade_away_duration = 30,
      show_when_smoke_off = true,
    },
    {
      type = "stream",
      name = "pirate-cannoniere-projectile-stream-" .. size_name,
      action = {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects = {
            {
              type = "create-entity",
              entity_name = "big-explosion",
              only_when_visible = true
            },
            {
              type = "damage",
              damage = { amount = 75 * damage_scale, type = "explosion" }
            },
            {
              type = "create-entity",
              entity_name = "medium-scorchmark-tintable",
              check_buildability = true
            },
            {
              type = "invoke-tile-trigger",
              repeat_count = 1
            },
            {
              type = "destroy-decoratives",
              from_render_layer = "decorative",
              to_render_layer = "object",
              include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
              include_decals = false,
              invoke_decorative_trigger = true,
              decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
              radius = 3.5                           -- large radius for demostrative purposes
            },
            {
              type = "nested-result",
              action =
              {
                type = "area",
                radius = 2.5 * damage_scale,
                force = "enemy",
                action_delivery =
                {
                  type = "instant",
                  target_effects =
                  {
                    {
                      type = "damage",
                      damage = { amount = 50 * damage_scale, type = "explosion" }
                    },
                    {
                      type = "create-entity",
                      entity_name = "explosion",
                      only_when_visible = true
                    }
                  }
                }
              }
            }
          }
        }
      },
      flags = { "not-on-map" },
      hidden = true,
      ground_light = {
        color = { r = 1, g = 0.9, b = 0.5 },
        intensity = 0.4,
        size = 10 * scale
      },
      stream_light = {
        color = { r = 1, g = 0.9, b = 0.5 },
        intensity = 1,
        size = 3 * scale
      },
      oriented_particle = true,
      particle = {
        filename = "__base__/graphics/entity/cluster-grenade/cluster-grenade.png",
        width = 48,
        height = 54,
        animation_speed = 0.25,
        frame_count = 16,
        line_length = 8,
        shift = { 0.015625, 0.015625 },
        scale = 0.4 * scale,
      },
      shadow = {
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
        width = 50,
        height = 40,
        animation_speed = 0.25,
        frame_count = 16,
        line_length = 8,
        shift = { 0.0625, 0.1875 },
        scale = 0.4 * scale,
      },
      particle_buffer_size = 1,
      particle_end_alpha = 1,
      particle_fade_out_threshold = 1,
      particle_horizontal_speed = 0.2,
      particle_horizontal_speed_deviation = 0.04,
      particle_loop_exit_threshold = 1,
      particle_loop_frame_count = 1,
      particle_spawn_interval = 0,
      particle_spawn_timeout = 1,
      particle_start_alpha = 1,
      particle_start_scale = 1,
      particle_vertical_acceleration = 0.005,
      progress_to_create_smoke = 0.03,
      smoke_sources = {
        {
          name = "cannoniere-projectile-smoke-trail-" .. size_name,
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

data:extend({
  make_carrier_explosion(1, "small"),
  make_carrier_explosion(1.25, "medium"),
  make_carrier_explosion(1.6, "big"),
  make_carrier_explosion(2, "behemoth"),
  make_skirmisher_explosion(1, "small"),
  make_skirmisher_explosion(1.25, "medium"),
  make_skirmisher_explosion(1.6, "big"),
  make_skirmisher_explosion(2, "behemoth"),
  make_frigate_barrel_projectile(1, "small"),
  make_frigate_barrel_projectile(1.25, "medium"),
  make_frigate_barrel_projectile(1.6, "big"),
  make_frigate_barrel_projectile(2, "behemoth"),
  make_cannoniere_projectile(1, "small"),
  make_cannoniere_projectile(1.25, "medium"),
  make_cannoniere_projectile(1.6, "big"),
  make_cannoniere_projectile(2, "behemoth"),
})
