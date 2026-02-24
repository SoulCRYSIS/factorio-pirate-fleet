local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local utils = require("prototypes.utils")
local sounds = space_age_sounds.stomper_pentapod.big

local vehicle_leg = table.deepcopy(data.raw["spider-leg"]["spidertron-leg-1"])
vehicle_leg.name = "carrier-invisible-leg"
vehicle_leg.graphics_set = {}
vehicle_leg.collision_mask = {
  layers = {
    ["rail"] = true,
  },
  colliding_with_tiles_only = true,
}
vehicle_leg.target_position_randomisation_distance = 0
vehicle_leg.working_sound = nil
vehicle_leg.minimal_step_size = 0.5
vehicle_leg.movement_based_position_selection_distance = 1.5 -- I have no idea what this does.
vehicle_leg.initial_movement_speed = 0.5
vehicle_leg.movement_acceleration = 0.01
vehicle_leg.stretch_force_scalar = 0.1
vehicle_leg.walking_sound_volume_modifier = 0
vehicle_leg.selectable_in_game = false

local shadow_width = 896
local shadow_height = 896
local width = 1024
local height = 1024
local glow_width = 512
local glow_height = 512

local function pictures_file_name(prefix, count)
  local filenames = {}
  for i = 1, count do
    table.insert(filenames, prefix .. "-" .. i .. ".png")
  end
  return filenames
end

local function make_carrier(tier, summon_positions)
  local scale = tier.scale
  local health = tier.health_scale * 5000
  local range_scale = tier.range_scale
  local size_name = tier.name
  local damage_scale = tier.damage_scale

  return {
    type = "spider-unit",
    name = "pirate-carrier-" .. size_name,
    icon = "__pirate-fleet-graphics__/icons/pirate-carrier.png",
    subgroup = "enemies",
    order = "pirate-c",
    collision_box = { { -2 * scale, -2 * scale }, { 2 * scale, 2 * scale } },
    sticker_box = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
    selection_box = { { -3 * scale, -3 * scale }, { 3 * scale, 3 * scale } },
    drawing_box_vertical_extension = 0.5 * scale,
    torso_bob_speed = 0.1,
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    resistances = {
      { type = "physical",  percent = 80 + scale * 10 },
      { type = "explosion", percent = 50 },
      { type = "fire",      percent = 80 },
      { type = "electric",  percent = 50 },
      { type = "laser",     percent = 80 },
      { type = "piercing",  percent = -20 },
    },
    healing_per_tick = health / 60 / 60 / 20,
    distraction_cooldown = 300,
    min_pursue_time = 300,
    max_pursue_distance = 100,
    attack_parameters = {
      type = "beam",
      cooldown = 600,
      range = 40 * range_scale,
      range_mode = "bounding-box-to-bounding-box",
      ammo_category = "melee",
      ammo_type = {
        target_type = "position",
        action = {
          type = "direct",
          force = "enemy",
          action_delivery = {
            type = "instant",
            source_effects = {
              type = "create-entity",
              entity_name = "pirate-skirmisher-" .. size_name,
              as_enemy = true,
              offsets = summon_positions,
            }
          }
        }
      }
    },
    vision_distance = 80,
    ai_settings =
    {
      join_attacks = true,
      allow_try_return_to_spawner = true,
      do_separation = true,
      size_in_group = 10,
      strafe_settings =
      {
        max_distance = 30 * range_scale,
        ideal_distance = 25 * range_scale,
        ideal_distance_tolerance = 5 * range_scale,
        ideal_distance_variance = 5 * range_scale,
        ideal_distance_importance = 0.5,
        ideal_distance_importance_variance = 0.1,
        face_target = false
      },
    },
    dying_explosion = "pirate-carrier-explosion-" .. size_name,
    dying_sound = sounds.dying_sound,
    damaged_trigger_effect = gleba_hit_effects(),
    is_military_target = true,
    working_sound = sounds.working_sound,
    warcry = sounds.warcry,
    height = 3 * scale,
    torso_rotation_speed = 0.01,
    absorptions_to_join_attack = utils.absorption_to_join_attack(6, tier.pollution_scale),
    graphics_set = {
      render_layer = "elevated-higher-object",
      shadow_animation = {
        filename =
        "__pirate-fleet-graphics__/entities/pirate-carrier/pirate-carrier-shadow.png",
        width = shadow_width,
        height = shadow_height,
        direction_count = 32,
        line_length = 8,
        lines_per_file = 4,
        scale = 0.5 * scale,
        usage = "enemy",
      },
      animation = {
        layers = {
          {
            filenames = pictures_file_name("__pirate-fleet-graphics__/entities/pirate-carrier/pirate-carrier", 4),
            width = width,
            height = height,
            direction_count = 32,
            line_length = 8,
            lines_per_file = 8,
            frame_count = 8,
            animation_speed = 0.1,
            run_mode = "forward-then-backward",
            scale = 0.5 * scale,
            usage = "enemy",
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-carrier/pirate-carrier-glow.png",
            width = glow_width,
            height = glow_height,
            direction_count = 32,
            line_length = 16,
            lines_per_file = 16,
            frame_count = 8,
            animation_speed = 0.1,
            run_mode = "forward-then-backward",
            scale = 1 * scale,
            draw_as_glow = true,
            blend_mode = "additive",
            usage = "enemy",
          },
        }
      },
      water_reflection = {
        rotate = true,
        pictures = {
          filename =
          "__pirate-fleet-graphics__/entities/pirate-carrier/pirate-carrier-water-reflection.png",
          width = shadow_width + 40,
          height = shadow_height + 40,
          variation_count = 16,
          line_length = 4,
          lines_per_file = 4,
          scale = 0.8 * scale,
          usage = "enemy",
        },
      }
    },
    spider_engine =
    {
      walking_group_overlap = 1,
      legs = {
        leg = "carrier-invisible-leg",
        mount_position = { 0, 0.5 },
        ground_position = { 0, 0 },
        blocking_legs = {},
        walking_group = 1,
        leg_hit_the_ground_when_attacking_trigger = {
          {
            type = "create-fire",
            entity_name = "fire-flame",
            probability = 0.5 * scale,
            offset_deviation = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 1.5 * scale,
              force = "enemy",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    show_in_tooltip = true
                  },
                  {
                    type = "damage",
                    damage = { amount = 10 * damage_scale, type = "fire" },
                    apply_damage_to_trees = false
                  }
                }
              }
            }
          }
        }
      },
    }
  }
end

data:extend({
  vehicle_leg,
})

local summon_positions = {
  small = { { -2, 0 }, { 2, 0 } },
  medium = { { -2, 1 }, { 2, 1 }, { 0, -3 } },
  big = { { -4, -4 }, { 4, 4 }, { -4, 4 }, { 4, -4 } },
  behemoth = { { -4, -4 }, { 4, 4 }, { -4, 4 }, { 4, -4 }, { 0, 0 } },
}
for _, tier in pairs(utils.tiers) do
  data:extend({
    make_carrier(tier, summon_positions[tier.name]),
  })
end
