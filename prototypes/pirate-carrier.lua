local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
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
vehicle_leg.minimal_step_size = 0
vehicle_leg.movement_based_position_selection_distance = 1.5 -- I have no idea what this does.
vehicle_leg.initial_movement_speed = 1
vehicle_leg.movement_acceleration = 0
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

local function make_carrier(scale, health, size_name, summon_positions)
  local range_scale = (scale - 1) * 0.5 + 1
  return {
    type = "spider-unit",
    name = "pirate-carrier-" .. size_name,
    icon = "__pirate-fleet__/icons/pirate-carrier.png",
    subgroup = "enemies",
    order = "pirate-c",
    collision_box = { { -3 * scale, -3 * scale }, { 3 * scale, 3 * scale } },
    sticker_box = { { -3 * scale, -3 * scale }, { 3 * scale, 3 * scale } },
    selection_box = { { -3 * scale, -3 * scale }, { 3 * scale, 3 * scale } },
    drawing_box_vertical_extension = 0.5 * scale,
    torso_bob_speed = 0.1,
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    resistances = {
      { type = "physical",  decrease = 15 * scale, percent = 50 },
      { type = "explosion", percent = 50 },
      { type = "electric",  percent = 90 },
      { type = "laser",     percent = 90 },
    },
    healing_per_tick = health / 60 / 60 / 5,
    distraction_cooldown = 300,
    min_pursue_time = 300,
    max_pursue_distance = 80,
    attack_parameters = {
      type = "beam",
      cooldown = 480,
      range = 30 * range_scale,
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
    vision_distance = 50,
    ai_settings =
    {
      join_attacks = true,
      allow_try_return_to_spawner = true,
      strafe_settings =
      {
        max_distance = 25 * range_scale,
        ideal_distance = 20 * range_scale,
        ideal_distance_tolerance = 5 * range_scale,
        ideal_distance_variance = 5 * range_scale,
        ideal_distance_importance = 0.5,
        ideal_distance_importance_variance = 0.1,
        face_target = false
      },
    },
    dying_explosion = "big-stomper-pentapod-die",
    dying_sound = sounds.dying_sound,
    damaged_trigger_effect = gleba_hit_effects(),
    is_military_target = true,
    working_sound = sounds.working_sound,
    warcry = sounds.warcry,
    height = 1.5 * scale,
    torso_rotation_speed = 0.01,
    graphics_set = {
      render_layer = "elevated-higher-object",
      shadow_animation = {
        filename =
        "__pirate-fleet__/entities/pirate-carrier/pirate-carrier-shadow.png",
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
            filenames = pictures_file_name("__pirate-fleet__/entities/pirate-carrier/pirate-carrier", 8),
            width = width,
            height = height,
            direction_count = 32,
            line_length = 8,
            lines_per_file = 8,
            frame_count = 16,
            animation_speed = 0.1,
            run_mode = "forward-then-backward",
            scale = 0.5 * scale,
            usage = "enemy",
          },
          {
            filenames = pictures_file_name("__pirate-fleet__/entities/pirate-carrier/pirate-carrier-glow",
              8),
            width = glow_width,
            height = glow_height,
            direction_count = 32,
            line_length = 8,
            lines_per_file = 8,
            frame_count = 16,
            animation_speed = 0.1,
            run_mode = "forward-then-backward",
            scale = 0.5 * scale,
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
          "__pirate-fleet__/entities/pirate-carrier/pirate-carrier-water-reflection.png",
          width = shadow_width + 40,
          height = shadow_height + 40,
          variation_count = 16,
          line_length = 4,
          lines_per_file = 4,
          scale = 0.5 * scale,
          usage = "enemy",
        },
      }
    },
    spider_engine =
    {
      walking_group_overlap = 1,
      legs = { leg = "carrier-invisible-leg", mount_position = { 0, 0.5 }, ground_position = { 0, 0 }, blocking_legs = {}, walking_group = 1 },
    }
  }
end

data:extend({
  vehicle_leg,
  make_carrier(1, 5000, "small", { { 0, 0 } }),
  make_carrier(1.25, 12000, "medium", { { -2, 0 }, { 2, 0 } }),
  make_carrier(1.6, 25000, "big", { { -2, 1 }, { 2, 1 }, { 0, -3 } }),
  make_carrier(2, 50000, "behemoth", { { -4, -4 }, { 4, 4 }, { -4, 4 }, { 4, -4 } }),
})
