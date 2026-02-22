local width = 704
local height = 704

local fort_units = {
  { "pirate-cannoniere-small",  { { 0.0, 0.7 }, { 0.1, 0.7 }, { 0.6, 0 } } },
  { "pirate-frigate-small",     { { 0.0, 0.3 }, { 0.1, 0.3 }, { 0.6, 0 } } },
  { "pirate-cannoniere-medium", { { 0.1, 0 }, { 0.6, 0.7 }, { 0.95, 0 } } },
  { "pirate-frigate-medium",    { { 0.1, 0 }, { 0.6, 0.3 }, { 0.95, 0 } } },
  { "pirate-cannoniere-big",    { { 0.6, 0 }, { 0.95, 0.7 }, { 1, 0.7 } } },
  { "pirate-frigate-big",       { { 0.6, 0 }, { 0.95, 0.3 }, { 1, 0.3 } } },
}

local island_units = {
  { "pirate-cannoniere-small",  { { 0.0, 0.7 }, { 0.1, 0.7 }, { 0.6, 0 } } },
  { "pirate-frigate-small",     { { 0.0, 0.3 }, { 0.1, 0.3 }, { 0.6, 0 } } },
  { "pirate-skirmisher-small",  { { 0.0, 0 }, { 0.4, 1 }, { 0.6, 0 } } },
  { "pirate-carrier-small",     { { 0.0, 0 }, { 0.4, 0.4 }, { 0.6, 0 } } },
  { "pirate-cannoniere-medium", { { 0.1, 0 }, { 0.6, 0.7 }, { 0.95, 0 } } },
  { "pirate-frigate-medium",    { { 0.1, 0 }, { 0.6, 0.3 }, { 0.95, 0 } } },
  { "pirate-skirmisher-medium", { { 0.4, 0 }, { 0.6, 1 }, { 0.95, 0 } } },
  { "pirate-carrier-medium",    { { 0.4, 0 }, { 0.6, 0.4 }, { 0.95, 0 } } },
  { "pirate-cannoniere-big",    { { 0.6, 0 }, { 0.95, 0.7 }, { 1, 0.7 } } },
  { "pirate-frigate-big",       { { 0.6, 0 }, { 0.95, 0.3 }, { 1, 0.3 } } },
  { "pirate-skirmisher-big",    { { 0.6, 0 }, { 0.95, 1 }, { 1, 2 } } },
  { "pirate-carrier-big",       { { 0.6, 0 }, { 0.95, 0.4 }, { 1, 0.8 } } },
}

if mods["behemoth-enemies"] or mods["virentis"] then
  fort_units = {
    { "pirate-cannoniere-small",    { { 0.0, 0.7 }, { 0.1, 0.7 }, { 0.6, 0 } } },
    { "pirate-frigate-small",       { { 0.0, 0.3 }, { 0.1, 0.3 }, { 0.6, 0 } } },
    { "pirate-cannoniere-medium",   { { 0.1, 0 }, { 0.6, 0.7 }, { 0.95, 0 } } },
    { "pirate-frigate-medium",      { { 0.1, 0 }, { 0.6, 0.3 }, { 0.95, 0 } } },
    { "pirate-cannoniere-big",      { { 0.6, 0 }, { 0.85, 0.7 }, { 1.5, 0 } } },
    { "pirate-frigate-big",         { { 0.6, 0 }, { 0.85, 0.3 }, { 1.5, 0 } } },
    { "pirate-cannoniere-behemoth", { { 0.85, 0 }, { 0.95, 0.7 }, { 1.0, 0.7 } } },
    { "pirate-frigate-behemoth",    { { 0.85, 0 }, { 0.95, 0.3 }, { 1.0, 0.3 } } },
  }
  island_units = {
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
  {
    type = "unit-spawner",
    name = "pirate-fort",
    icon = "__pirate-fleet-graphics__/icons/pirate-fort.png",
    flags = { "placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid" },
    max_health = 600,
    order = "va",
    subgroup = "enemies",
    impact_category = "stone",
    resistances = {
      { type = "physical",  percent = 90 },
      { type = "electric",  percent = 50 },
      { type = "explosion", percent = 50 },
      { type = "fire",      percent = 80 },
      { type = "piercing",  percent = -20 },
    },
    healing_per_tick = 0.2,
    map_generator_bounding_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },                                                           
    collision_box = { { -3.35, -3.35 }, { 3.35, 3.35 } },
    collision_mask = { layers = { object = true } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    hit_visualization_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    dying_explosion = "medium-explosion",
    damaged_trigger_effect = gleba_hit_effects(),
    max_count_of_owned_units = 4,
    max_count_of_owned_defensive_units = 2,
    max_friends_around_to_spawn = 6,
    max_defensive_friends_around_to_spawn = 4,
    graphics_set = {
      animations = {
        sheets = {
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fort/pirate-fort.png",
            width = width,
            height = height,
            scale = 0.5,
            line_length = 4,
            variation_count = 4,
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fort/pirate-fort-shadow.png",
            width = width,
            height = height,
            scale = 0.5,
            line_length = 4,
            variation_count = 4,
            draw_as_shadow = true,
          },
          {
            filename = "__pirate-fleet-graphics__/entities/pirate-fort/pirate-fort-glow.png",
            width = width,
            height = height,
            scale = 0.5,
            line_length = 4,
            variation_count = 4,
            draw_as_glow = true,
            blend_mode = "additive",
          }
        }
      },
      water_reflection = {
        pictures = {
          filename = "__pirate-fleet-graphics__/entities/pirate-fort/pirate-fort-water-reflection.png",
          width = width + 40,
          height = height + 40,
          scale = 0.5,
          line_length = 4,
          variation_count = 4,
        },
      }
    },
    result_units = fort_units,
    spawning_cooldown = { 360, 150 },
    spawning_radius = 12,
    spawning_spacing = 5,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    call_for_help_radius = 50,
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
    -- autoplace = space_enemy_autoplace.gleba_spawner_autoplace("gleba_spawner_small", "b[enemy]-c[spawner]-b[small]"),
    loot = { { item = "pentapod-egg", probability = 1, count_min = 1, count_max = 3 } }
  },
})
