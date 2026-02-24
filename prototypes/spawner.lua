local fortress_width = 832
local fortress_height = 832

local citadel_width = 1216
local citadel_height = 1216

local fortress_units = {
  { "pirate-cannoniere-small",  { { 0.0, 0.7 }, { 0.1, 0.7 }, { 0.6, 0 } } },
  { "pirate-frigate-small",     { { 0.0, 0.3 }, { 0.1, 0.3 }, { 0.6, 0 } } },
  { "pirate-cannoniere-medium", { { 0.1, 0 }, { 0.6, 0.7 }, { 0.95, 0 } } },
  { "pirate-frigate-medium",    { { 0.1, 0 }, { 0.6, 0.3 }, { 0.95, 0 } } },
  { "pirate-cannoniere-big",    { { 0.6, 0 }, { 0.95, 0.7 }, { 1, 0.7 } } },
  { "pirate-frigate-big",       { { 0.6, 0 }, { 0.95, 0.3 }, { 1, 0.3 } } },
}

local citadel_units = {
  { "pirate-cannoniere-small",  { { 0.0, 0.2 }, { 0.1, 0.2 }, { 0.6, 0 } } },
  { "pirate-frigate-small",     { { 0.0, 0.1 }, { 0.1, 0.1 }, { 0.6, 0 } } },
  { "pirate-skirmisher-small",  { { 0.0, 0 }, { 0.4, 0.5 }, { 0.6, 0 } } },
  { "pirate-carrier-small",     { { 0.0, 0 }, { 0.4, 0.2 }, { 0.6, 0 } } },
  { "pirate-cannoniere-medium", { { 0.1, 0 }, { 0.6, 0.2 }, { 0.95, 0 } } },
  { "pirate-frigate-medium",    { { 0.1, 0 }, { 0.6, 0.1 }, { 0.95, 0 } } },
  { "pirate-skirmisher-medium", { { 0.4, 0 }, { 0.6, 0.5 }, { 0.95, 0 } } },
  { "pirate-carrier-medium",    { { 0.4, 0 }, { 0.6, 0.2 }, { 0.95, 0 } } },
  { "pirate-cannoniere-big",    { { 0.6, 0 }, { 0.95, 0.2 }, { 1, 0.2 } } },
  { "pirate-frigate-big",       { { 0.6, 0 }, { 0.95, 0.1 }, { 1, 0.1 } } },
  { "pirate-skirmisher-big",    { { 0.6, 0 }, { 0.95, 0.5 }, { 1, 0.5 } } },
  { "pirate-carrier-big",       { { 0.6, 0 }, { 0.95, 0.2 }, { 1, 0.2 } } },
}

if mods["behemoth-enemies"] or mods["virentis"] then
  fortress_units = {
    { "pirate-cannoniere-small",    { { 0.0, 0.7 }, { 0.1, 0.7 }, { 0.6, 0 } } },
    { "pirate-frigate-small",       { { 0.0, 0.3 }, { 0.1, 0.3 }, { 0.6, 0 } } },
    { "pirate-cannoniere-medium",   { { 0.1, 0 }, { 0.6, 0.7 }, { 0.95, 0 } } },
    { "pirate-frigate-medium",      { { 0.1, 0 }, { 0.6, 0.3 }, { 0.95, 0 } } },
    { "pirate-cannoniere-big",      { { 0.6, 0 }, { 0.85, 0.7 }, { 1.5, 0 } } },
    { "pirate-frigate-big",         { { 0.6, 0 }, { 0.85, 0.3 }, { 1.5, 0 } } },
    { "pirate-cannoniere-behemoth", { { 0.85, 0 }, { 0.95, 0.7 }, { 1.0, 0.7 } } },
    { "pirate-frigate-behemoth",    { { 0.85, 0 }, { 0.95, 0.3 }, { 1.0, 0.3 } } },
  }
  citadel_units = {
    { "pirate-cannoniere-small",  { { 0.0, 0.2 }, { 0.1, 0.2 }, { 0.6, 0 } } },
    { "pirate-frigate-small",     { { 0.0, 0.1 }, { 0.1, 0.1 }, { 0.6, 0 } } },
    { "pirate-skirmisher-small",  { { 0.0, 0 }, { 0.4, 0.5 }, { 0.6, 0 } } },
    { "pirate-carrier-small",     { { 0.0, 0 }, { 0.4, 0.2 }, { 0.6, 0 } } },
    { "pirate-cannoniere-medium", { { 0.1, 0 }, { 0.6, 0.2 }, { 0.95, 0 } } },
    { "pirate-frigate-medium",    { { 0.1, 0 }, { 0.6, 0.1 }, { 0.95, 0 } } },
    { "pirate-skirmisher-medium", { { 0.4, 0 }, { 0.6, 0.5 }, { 0.95, 0 } } },
    { "pirate-carrier-medium",    { { 0.4, 0 }, { 0.6, 0.2 }, { 0.95, 0 } } },
    { "pirate-cannoniere-big",    { { 0.6, 0 }, { 0.85, 0.2 }, { 1.5, 0.2 } } },
    { "pirate-frigate-big",       { { 0.6, 0 }, { 0.85, 0.1 }, { 1.5, 0.1 } } },
    { "pirate-skirmisher-big",    { { 0.85, 0 }, { 0.95, 0.5 }, { 1, 0.5 } } },
    { "pirate-carrier-big",       { { 0.85, 0 }, { 0.95, 0.2 }, { 1, 0.2 } } },
  }
end

data:extend({
  -- Fortress
  {
    type = "unit-spawner",
    name = "pirate-fortress",
    icon = "__pirate-fleet-graphics__/icons/pirate-fortress.png",
    flags = { "placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid" },
    max_health = 800,
    order = "vsa",
    subgroup = "enemies",
    impact_category = "stone",
    resistances = {
      { type = "physical",  percent = 50, decrease = 10, },
      { type = "electric",  percent = 50 },
      { type = "explosion", percent = 50, decrease = 100, },
      { type = "fire",      percent = 80 },
      { type = "laser",     percent = 50 },
      { type = "poison",    percent = 100 },
      { type = "piercing",  percent = -10 },
    },
    healing_per_tick = 0.5,
    map_generator_bounding_box = { { -6, -6 }, { 6, 6 } },
    collision_box = { { -4.25, -4.25 }, { 4.25, 4.25 } },
    collision_mask = { layers = { is_object = true, ground_tile = true } },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    hit_visualization_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    dying_explosion = "big-explosion",
    damaged_trigger_effect = gleba_hit_effects(),
    max_count_of_owned_units = 2,
    max_count_of_owned_defensive_units = 1,
    max_friends_around_to_spawn = 3,
    max_defensive_friends_around_to_spawn = 2,
    graphics_set = {
      animations = {
        sheets = {
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fortress/pirate-fortress.png",
            width = fortress_width,
            height = fortress_height,
            scale = 0.5,
            line_length = 5,
            variation_count = 5,
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fortress/pirate-fortress-shadow.png",
            width = fortress_width,
            height = fortress_height,
            scale = 0.5,
            line_length = 5,
            variation_count = 5,
            draw_as_shadow = true,
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fortress/pirate-fortress-glow.png",
            width = fortress_width,
            height = fortress_height,
            scale = 0.5,
            line_length = 5,
            variation_count = 5,
            draw_as_glow = true,
            blend_mode = "additive",
          }
        }
      },
      water_reflection = {
        pictures = {
          filename = "__pirate-fleet-graphics__/entities/pirate-fortress/pirate-fortress-water-reflection.png",
          width = fortress_width + 40,
          height = fortress_height + 40,
          scale = 0.5,
          line_length = 5,
          variation_count = 5,
        },
      }
    },
    result_units = fortress_units,
    spawning_cooldown = { 540, 225 },
    spawning_radius = 12,
    spawning_spacing = 5,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    call_for_help_radius = 60,
    absorptions_per_second = {
      pollution = { absolute = 40, proportional = 0.02 },
      spores = { absolute = 40, proportional = 0.02 }
    },
    -- spawn_decorations_on_expansion = true,
    -- spawn_decoration =
    -- {
    --   {
    --     decorative = "gleba-spawner-slime",
    --     spawn_min = 2,
    --     spawn_max = 2,
    --     spawn_min_radius = 0,
    --     spawn_max_radius = 4
    --   }
    -- },
    autoplace = {
      force = "enemy",
      probability_expression = 0,
      order = "pb",
      richness_expression = 1,
    },
  },
  -- Citadel
  {
    type = "unit-spawner",
    name = "pirate-citadel",
    icon = "__pirate-fleet-graphics__/icons/pirate-citadel.png",
    flags = { "placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid" },
    max_health = 1500,
    order = "vsb",
    subgroup = "enemies",
    impact_category = "stone",
    resistances = {
      { type = "physical",  percent = 80, decrease = 100 },
      { type = "electric",  percent = 50 },
      { type = "explosion", percent = 80, decrease = 100 },
      { type = "fire",      percent = 80 },
      { type = "laser",     percent = 80 },
      { type = "poison",    percent = 100 },
      { type = "piercing",  percent = -20 },
    },
    healing_per_tick = 1,
    map_generator_bounding_box = { { -8, -8 }, { 8, 8 } },
    collision_box = { { -6.25, -6.25 }, { 6.25, 6.25 } },
    collision_mask = { layers = { is_object = true, ground_tile = true } },
    selection_box = { { -6.5, -6.5 }, { 6.5, 6.5 } },
    hit_visualization_box = { { -5, -5 }, { 5, 5 } },
    dying_explosion = "rocket-silo-explosion",
    damaged_trigger_effect = gleba_hit_effects(),
    max_count_of_owned_units = 4,
    max_count_of_owned_defensive_units = 2,
    max_friends_around_to_spawn = 6,
    max_defensive_friends_around_to_spawn = 4,
    graphics_set = {
      animations = {
        sheets = {
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-citadel/pirate-citadel.png",
            width = citadel_width,
            height = citadel_height,
            scale = 0.5,
            line_length = 4,
            variation_count = 4,
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-citadel/pirate-citadel-shadow.png",
            width = citadel_width,
            height = citadel_height,
            scale = 0.5,
            line_length = 4,
            variation_count = 4,
            draw_as_shadow = true,
          },
          -- {
          --   filename = "__pirate-fleet-graphics__/entities/pirate-citadel/pirate-citadel-glow.png",
          --   width = citadel_width,
          --   height = citadel_height,
          --   scale = 0.5,
          --   line_length = 4,
          --   variation_count = 4,
          --   draw_as_glow = true,
          --   blend_mode = "additive",
          -- }
        }
      },
      water_reflection = {
        pictures = {
          filename = "__pirate-fleet-graphics__/entities/pirate-citadel/pirate-citadel-water-reflection.png",
          width = citadel_width + 40,
          height = citadel_height + 40,
          scale = 0.5,
          line_length = 4,
          variation_count = 4,
        },
      }
    },
    result_units = citadel_units,
    spawning_cooldown = { 360, 150 },
    spawning_radius = 18,
    spawning_spacing = 5,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    call_for_help_radius = 60,
    absorptions_per_second = {
      pollution = { absolute = 80, proportional = 0.04 },
      spores = { absolute = 80, proportional = 0.04 }
    },
    -- spawn_decorations_on_expansion = true,
    -- spawn_decoration =
    -- {
    --   {
    --     decorative = "gleba-spawner-slime",
    --     spawn_min = 2,
    --     spawn_max = 2,
    --     spawn_min_radius = 0,
    --     spawn_max_radius = 4
    --   }
    -- },
    enemy_map_color = { 0, 0.9, 0},
    autoplace = {
      force = "enemy",
      probability_expression = 0,
      order = "pa",
      richness_expression = 1,
    },
  },
})
