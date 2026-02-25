data:extend({
  {
    type = "autoplace-control",
    name = "pirate_base_nauvis",
    richness = false,
    order = "pa",
    category = "enemy",
  },
  {
    type = "autoplace-control",
    name = "pirate_base_gleba",
    richness = false,
    order = "pb",
    category = "enemy",
  },

  {
    type = "noise-expression",
    name = "pirate_base_radius_nauvis",
    expression = "sqrt(control:pirate_base_nauvis:size) * (20 + 5 * enemy_base_intensity)"
  },
  {
    type = "noise-expression",
    name = "pirate_base_frequency_nauvis",
    expression = "(0.000003 + 0.0000015 * enemy_base_intensity) * control:pirate_base_nauvis:frequency"
  },
  {
    type = "noise-expression",
    name = "pirate_base_radius_gleba",
    expression = "sqrt(control:pirate_base_gleba:size) * (20 + 5 * enemy_base_intensity)"
  },
  {
    type = "noise-expression",
    name = "pirate_base_frequency_gleba",
    expression = "(0.000003 + 0.0000015 * enemy_base_intensity) * control:pirate_base_gleba:frequency"
  },

  {
    type = "noise-expression",
    name = "pirate_base_probability",
    expression = "spot_noise{x = x,\z
                             y = y,\z
                             density_expression = spot_quantity_expression * max(0, pirate_base_frequency),\z
                             spot_quantity_expression = spot_quantity_expression,\z
                             spot_radius_expression = spot_radius_expression,\z
                             spot_favorability_expression = 1,\z
                             seed0 = map_seed,\z
                             seed1 = 12345,\z
                             region_size = 512,\z
                             candidate_point_count = 100,\z
                             hard_region_target_quantity = 0,\z
                             basement_value = -1000,\z
                             maximum_spot_basement_radius = 128} + \z
                  (blob(1/8, 1) + blob(1/24, 1) + blob(1/64, 2) - 0.5) * spot_radius_expression / 150 * \z
                  (0.1 + 0.9 * clamp(distance / 3000, 0, 1)) - 0.3 + min(0, 20 / starting_area_radius * distance - 20)",
    local_expressions =
    {
      spot_radius_expression = "max(0, pirate_base_radius)",
      spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
    },
    local_functions =
    {
      blob =
      {
        parameters = { "input_scale", "output_scale" },
        expression =
        "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 12345, input_scale = input_scale, output_scale = output_scale}"
      }
    }
  },
  {
    type = "noise-function",
    name = "pirate_base_autoplace",
    parameters = { "distance_factor", "seed" },
    expression = "random_penalty{x = x + seed,\z
                                 y = y,\z
                                 source = min(pirate_base_probability * max(0, 1 + 0.002 * distance_factor * (-312 * distance_factor - starting_area_radius + distance)),\z
                                              0.25 + distance_factor * 0.05),\z
                                 amplitude = 0.1}"
  },
  {
    type = "noise-expression",
    name = "pirate_fortress_probability",
    expression = "min(0.02, pirate_base_autoplace(0, 9)) * gleba_select(elevation, -500, -10, 3, 0, 1) / 3",
  },
  {
    type = "noise-expression",
    name = "pirate_citadel_probability",
    -- distance factor is 1, making early game easier
    expression = "min(0.02, pirate_base_autoplace(1, 10)) * gleba_select(elevation, -500, -10, 3, 0, 1) / 20",
  },
})

local nauvis_map_gen = data.raw["planet"]["nauvis"].map_gen_settings
if nauvis_map_gen then
  nauvis_map_gen.property_expression_names["pirate_base_radius"] = "pirate_base_radius_nauvis"
  nauvis_map_gen.property_expression_names["pirate_base_frequency"] = "pirate_base_frequency_nauvis"
  nauvis_map_gen.property_expression_names["entity:pirate-fortress:control"] = "pirate_base_nauvis"
  nauvis_map_gen.property_expression_names["entity:pirate-fortress:probability"] = "pirate_fortress_probability"
  nauvis_map_gen.property_expression_names["entity:pirate-citadel:control"] = "pirate_base_nauvis"
  nauvis_map_gen.property_expression_names["entity:pirate-citadel:probability"] = "pirate_citadel_probability"
  nauvis_map_gen.autoplace_controls["pirate_base_nauvis"] = {}
  nauvis_map_gen.autoplace_settings["entity"].settings["pirate-fortress"] = {}
  nauvis_map_gen.autoplace_settings["entity"].settings["pirate-citadel"] = {}
end

local gleba_map_gen = data.raw["planet"]["gleba"].map_gen_settings
if gleba_map_gen then
  gleba_map_gen.property_expression_names["pirate_base_radius"] = "pirate_base_radius_gleba"
  gleba_map_gen.property_expression_names["pirate_base_frequency"] = "pirate_base_frequency_gleba"
  gleba_map_gen.property_expression_names["entity:pirate-fortress:control"] = "pirate_base_gleba"
  gleba_map_gen.property_expression_names["entity:pirate-fortress:probability"] = "pirate_fortress_probability"
  gleba_map_gen.property_expression_names["entity:pirate-citadel:control"] = "pirate_base_gleba"
  gleba_map_gen.property_expression_names["entity:pirate-citadel:probability"] = "pirate_citadel_probability"
  gleba_map_gen.autoplace_controls["pirate_base_gleba"] = {}
  gleba_map_gen.autoplace_settings["entity"].settings["pirate-fortress"] = {}
  gleba_map_gen.autoplace_settings["entity"].settings["pirate-citadel"] = {}
end
