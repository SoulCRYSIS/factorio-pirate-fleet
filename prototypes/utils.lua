local utils = {}

utils.tiers = {
  { name = "small",  scale = 1,    health_scale = 1,   pollution_scale = 1 },
  { name = "medium", scale = 1.25, health_scale = 2.4, pollution_scale = 4 },
  { name = "big",    scale = 1.55, health_scale = 5,   pollution_scale = 16 },
}

if mods["behemoth-enemies"] or mods["virentis"] then
  table.insert(utils.tiers, { name = "behemoth", scale = 1.9, health_scale = 10, pollution_scale = 64 })
end

utils.absorption_to_join_attack = function(scale, pollution_scale)
  return {
    pollution = 10 * pollution_scale * scale,
    spores = 20 * scale,
  }
end

return utils
