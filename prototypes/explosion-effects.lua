local explosion_animations = require("__base__.prototypes.entity.explosion-animations")
local sounds = require("__base__.prototypes.entity.sounds")

local function make_carrier_explosion(scale, size_name)
  return {
    type = "explosion",
    name = "pirate-carrier-explosion-" .. size_name,
    icon = "__pirate-fleet__/graphics/icons/pirate-carrier.png",
    flags = {"not-on-map"},
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
            offsets = { { 0, 0 }  },
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
            offsets = { { 0, 0 }  },
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
            offsets = { { 0, 0 }  },
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
            offsets = { { 0, 0 }  },
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

data:extend({
  make_carrier_explosion(1, "small"),
  make_carrier_explosion(1.25, "medium"),
  make_carrier_explosion(1.6, "big"),
  make_carrier_explosion(2, "behemoth"),
  make_skirmisher_explosion(1, "small"),
  make_skirmisher_explosion(1.25, "medium"),
  make_skirmisher_explosion(1.6, "big"),
  make_skirmisher_explosion(2, "behemoth"),
})