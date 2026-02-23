local sounds = require("__base__/prototypes/entity/sounds")
local utils = require("prototypes.utils")

local width = 256
local height = 256

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

local function make_cannoniere(tier)
  local scale = tier.scale
  local health = tier.health_scale * 800
  local size_name = tier.name

  make_cannoniere_projectile(scale, size_name)
  local range_scale = (scale - 1) * 0.7 + 1
  return {
    type = "unit",
    name = "pirate-cannoniere-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-cannoniere.png",
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    subgroup = "enemies",
    order = "pirate-a",
    collision_box = { { -0.25 * scale, -0.4 * scale }, { 0.25 * scale, 0.4 * scale } },
    sticker_box = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
    selection_box = { { -0.5 * scale, -0.8 * scale }, { 0.5 * scale, 0.8 * scale } },
    resistances = {
      { type = "physical",  decrease = 3 * scale, percent = 20 },
      { type = "explosion", percent = 30 },
      { type = "electric",  percent = 50 },
      { type = "laser",     percent = 50 },
      { type = "piercing",  percent = -20 },
    },
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
            filename = "__pirate-fleet-graphics__/entities/pirate-cannoniere/pirate-cannoniere.png",
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
    dying_explosion = "pirate-cannoniere-explosion-" .. size_name,
    run_animation = {
      layers = {
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-cannoniere/pirate-cannoniere.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
        },
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-cannoniere/pirate-cannoniere-shadow.png",
          width = width,
          height = height,
          scale = 0.5 * scale,
          line_length = 8,
          lines_per_file = 8,
          direction_count = 64,
          draw_as_shadow = true,
        },
        {
          filename = "__pirate-fleet-graphics__/entities/pirate-cannoniere/pirate-cannoniere-glow.png",
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
        filename = "__pirate-fleet-graphics__/entities/pirate-cannoniere/pirate-cannoniere-water-reflection.png",
        lines_per_file = 4,
        line_length = 4,
        width = width + 40,
        height = height + 40,
        scale = 0.5 * scale,
      }
    },
    collision_mask = { layers = { object = true, train = true, ground_tile = true } }, -- Can move on water
    absorptions_to_join_attack = utils.absorption_to_join_attack(1, tier.pollution_scale),
    ai_settings = {
      join_attacks = true,
      allow_try_return_to_spawner = true,
      do_separation = true,
    },
  }
end

for _, tier in pairs(utils.tiers) do
  data:extend({
    make_cannoniere(tier),
  })
end
