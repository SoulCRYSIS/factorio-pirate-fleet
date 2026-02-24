local utils = {}

local setting_health_scale = settings.startup["pirate-health"].value
local setting_damage_scale = settings.startup["pirate-damage"].value

utils.tiers = {
  { name = "small",  scale = 1,    health_scale = setting_health_scale,       damage_scale = setting_damage_scale,       range_scale = 1,    pollution_scale = 1 },
  { name = "medium", scale = 1.25, health_scale = setting_health_scale * 2.4, damage_scale = setting_damage_scale * 1.3, range_scale = 1.15, pollution_scale = 2 },
  { name = "big",    scale = 1.55, health_scale = setting_health_scale * 5,   damage_scale = setting_damage_scale * 1.6, range_scale = 1.35, pollution_scale = 4 },
}

if mods["behemoth-enemies"] or mods["virentis"] then
  table.insert(utils.tiers,
    { name = "behemoth", scale = 1.9, health_scale = setting_health_scale * 10, damage_scale = setting_damage_scale * 2, range_scale = 1.6, pollution_scale = 8 })
end

utils.absorption_to_join_attack = function(scale, pollution_scale)
  return {
    pollution = 10 * pollution_scale * scale,
    spores = 20 * scale,
  }
end

return utils
