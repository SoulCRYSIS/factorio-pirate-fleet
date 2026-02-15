local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local sounds = space_age_sounds.stomper_pentapod.big

local vehicle_leg = table.deepcopy(data.raw["spider-leg"]["spidertron-leg-1"])
vehicle_leg.name = "skirmisher-invisible-leg"
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
vehicle_leg.stretch_force_scalar = 5
vehicle_leg.walking_sound_volume_modifier = 0
vehicle_leg.selectable_in_game = false

local shadow_width = 576
local shadow_height = 576
local width = 448
local height = 448
local glow_width = 224
local glow_height = 224

local function make_skirmisher(scale, health, size_name)
  local range_scale = (scale - 1) * 0.5 + 1
  return {
    type = "spider-unit",
    name = "pirate-skirmisher-" .. size_name,
    icon = "__pirate-fleet__/graphics/icons/pirate-skirmisher.png",
    subgroup = "enemies",
    order = "pirate-d",
    collision_box = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
    sticker_box = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
    selection_box = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
    drawing_box_vertical_extension = 0.5 * scale,
    torso_bob_speed = 0.1,
    flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
    max_health = health,
    resistances = {
      { type = "physical",  decrease = 5 * scale, percent = 50 },
      { type = "explosion", percent = 90 },
      { type = "electric",  percent = 95 },
      { type = "laser",     percent = 70 },
      { type = "piercing",  percent = -100 },
    },
    healing_per_tick = health / 60 / 60 / 4,
    distraction_cooldown = 300,
    min_pursue_time = 300,
    max_pursue_distance = 80,
    attack_parameters = {
      type = "projectile",
      ammo_category = "melee",
      health_penalty = 1,
      range_mode = "bounding-box-to-bounding-box",
      cooldown = 6,
      projectile_creation_distance = 1.3 * scale,
      ammo_type = {
        category = "bullet",
        target_type = "entity",
        action =
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects = {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot",
                  offset = { -0.5 * scale, 0 }
                },
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot",
                  offset = { 0.5 * scale, 0 }
                },
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-hit",
                  offset_deviation = { { -0.25, -0.25 }, { 0.25, 0.25 } },
                },
                {
                  type = "damage",
                  damage = { amount = 10 * scale, type = "physical" }
                }
              }
            }
          }
        }
      },
      range = 10 * range_scale,
      sound = sounds.gun_turret_gunshot
    },
    vision_distance = 50,
    ai_settings =
    {
      join_attacks = true,
      allow_try_return_to_spawner = true,
      strafe_settings =
      {
        max_distance = 10 * range_scale,
        ideal_distance = 8 * range_scale,
        ideal_distance_tolerance = 2 * range_scale,
        ideal_distance_variance = 2 * range_scale,
        ideal_distance_importance = 0.5,
        ideal_distance_importance_variance = 0.1,
        face_target = false
      },
    },
    dying_explosion = "pirate-skirmisher-explosion-" .. size_name,
    dying_sound = sounds.dying_sound,
    damaged_trigger_effect = gleba_hit_effects(),
    is_military_target = true,
    working_sound = sounds.working_sound,
    warcry = sounds.warcry,
    height = 0.5 * scale,
    torso_rotation_speed = 0.02,
    graphics_set = {
      render_layer = "elevated-higher-object",
      shadow_animation = {
        filename =
        "__pirate-fleet__/graphics/entities/pirate-skirmisher/pirate-skirmisher-shadow.png",
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
            filename = "__pirate-fleet__/graphics/entities/pirate-skirmisher/pirate-skirmisher.png",
            width = width,
            height = height,
            direction_count = 32,
            line_length = 16,
            lines_per_file = 16,
            frame_count = 8,
            animation_speed = 0.2,
            run_mode = "forward-then-backward",
            scale = 0.5 * scale,
            usage = "enemy",
          },
          {
            filename = "__pirate-fleet__/graphics/entities/pirate-skirmisher/pirate-skirmisher-glow.png",
            width = glow_width,
            height = glow_height,
            direction_count = 32,
            line_length = 16,
            lines_per_file = 16,
            frame_count = 8,
            animation_speed = 0.2,
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
          "__pirate-fleet__/graphics/entities/pirate-skirmisher/pirate-skirmisher-water-reflection.png",
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
      legs = { leg = "skirmisher-invisible-leg", mount_position = { 0, 0.5 }, ground_position = { 0, 0 }, blocking_legs = {}, walking_group = 1 },
    }
  }
end

data:extend({
  vehicle_leg,
  make_skirmisher(1, 200, "small"),
  make_skirmisher(1.25, 480, "medium"),
  make_skirmisher(1.6, 1000, "big"),
  make_skirmisher(2, 2000, "behemoth"),
})
