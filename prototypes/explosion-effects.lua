local explosion_animations = require("__base__.prototypes.entity.explosion-animations")
local sounds = require("__base__.prototypes.entity.sounds")

local function make_carrier_explosion(scale, size_name)
  return {
    type = "explosion",
    name = "pirate-carrier-explosion-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-carrier.png",
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
            offset_deviation = { { -0.5 * scale, -0.5977 * scale }, { 0.5 * scale, 0.5977 * scale } },
            initial_height = 0.3 * scale,
            initial_height_deviation = 0.14 * scale,
            initial_vertical_speed = 0.194 * scale,
            initial_vertical_speed_deviation = 0.012 * scale,
            speed_from_center = 0.06 * scale,
            speed_from_center_deviation = 0.025 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 52,
            probability = 1,
            particle_name = "rocket-silo-metal-particle-medium",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.2969 * scale, -0.5 * scale }, { 0.2969 * scale, 0.5 * scale } },
            initial_height = 0.8 * scale,
            initial_height_deviation = 0.48 * scale,
            initial_vertical_speed = 0.135 * scale,
            initial_vertical_speed_deviation = 0.047 * scale,
            speed_from_center = 0.09 * scale,
            speed_from_center_deviation = 0
          },
          {
            type = "create-particle",
            repeat_count = 50,
            probability = 1,
            particle_name = "rocket-silo-metal-particle-small",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5 * scale, -0.5977 * scale }, { 0.5 * scale, 0.5977 * scale } },
            initial_height = 2.5 * scale,
            initial_height_deviation = 0.63 * scale,
            initial_vertical_speed = 0.109 * scale,
            initial_vertical_speed_deviation = 0.042 * scale,
            speed_from_center = 0.09 * scale,
            speed_from_center_deviation = 0.044 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 36,
            probability = 1,
            particle_name = "artillery-wagon-mechanical-component-particle-medium",
            offsets = { { 0, 0 } },
            offset_deviation = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
            initial_height = 1 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.131 * scale,
            initial_vertical_speed_deviation = 0.041 * scale,
            speed_from_center = 0.09 * scale,
            speed_from_center_deviation = 0.05 * scale,
          }
        }
      }
    }
  }
end

local function make_frigate_explosion(scale, size_name)
  return {
    type = "explosion",
    name = "pirate-frigate-explosion-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-frigate.png",
    flags = { "not-on-map" },
    hidden = true,
    subgroup = "enemy-death-explosions",
    order = "pirate-b",
    height = 0,
    animations = explosion_animations.medium_explosion(),
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound = sounds.medium_explosion,
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
            repeat_count = 15,
            particle_name = "radar-metal-particle-big",
            offset_deviation = { { -0.5 * scale, -0.5977 * scale }, { 0.5 * scale, 0.5977 * scale } },
            initial_height = 0.3 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.071 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.05 * scale,
            speed_from_center_deviation = 0.05 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 22,
            particle_name = "radar-metal-particle-medium",
            offset_deviation = { { -0.5938 * scale, -0.5 * scale }, { 0.5938 * scale, 0.5 * scale } },
            initial_height = 0.3 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.082 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.05 * scale,
            speed_from_center_deviation = 0.05 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 20,
            particle_name = "radar-metal-particle-small",
            offset_deviation = { { -0.5 * scale, -0.5977 * scale }, { 0.5 * scale, 0.5977 * scale } },
            initial_height = 0.3 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.07 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.05 * scale,
            speed_from_center_deviation = 0.05 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 18,
            particle_name = "radar-long-metal-particle-medium",
            offset_deviation = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
            initial_height = 0.2 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.095 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.03 * scale,
            speed_from_center_deviation = 0.05 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 21,
            particle_name = "cable-and-electronics-particle-small-medium",
            offset_deviation = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
            initial_height = 0.3 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.082 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.05 * scale,
            speed_from_center_deviation = 0.05 * scale,
          }
        }
      }
    }
  }
end

local function make_cannoniere_explosion(scale, size_name)
  return {
    type = "explosion",
    name = "pirate-cannoniere-explosion-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-cannoniere.png",
    flags = { "not-on-map" },
    hidden = true,
    subgroup = "enemy-death-explosions",
    order = "pirate-a",
    height = 0,
    animations = explosion_animations.small_explosion(),
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound = sounds.small_explosion,
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
            repeat_count = 20,
            particle_name = "wooden-chest-wooden-splinter-particle-medium",
            offset_deviation = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
            initial_height = 0.5 * scale,
            initial_height_deviation = 0.5 * scale,
            initial_vertical_speed = 0.06 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.04 * scale,
            speed_from_center_deviation = 0.05 * scale,
          },
          {
            type = "create-particle",
            repeat_count = 20,
            particle_name = "wooden-chest-wooden-splinter-particle-small",
            offset_deviation = { { -0.5 * scale, -0.5 * scale }, { 0.5 * scale, 0.5 * scale } },
            initial_height = 0.5 * scale,
            initial_height_deviation = 0.44 * scale,
            initial_vertical_speed = 0.069 * scale,
            initial_vertical_speed_deviation = 0.05 * scale,
            speed_from_center = 0.02 * scale,
            speed_from_center_deviation = 0.046 * scale,
          }
        }
      }
    }
  }
end

local utils = require("prototypes.utils")
for _, tier in pairs(utils.tiers) do
  data:extend({
    make_carrier_explosion(tier.scale, tier.name),
    make_frigate_explosion(tier.scale, tier.name),
    make_cannoniere_explosion(tier.scale, tier.name),
  })
end
