local function convert_remove_collision(name)
  local decorative = table.deepcopy(data.raw["optimized-decorative"][name])
  decorative.name = "pirate-" .. name
  decorative.collision_mask = { layers = {} }
  return decorative
end

data:extend({
  convert_remove_collision("curly-roots-grey"),
  convert_remove_collision("red-croton"),
  convert_remove_collision("green-croton"),
  convert_remove_collision("pink-phalanges"),
  convert_remove_collision("coral-stunted"),
  convert_remove_collision("pink-phalanges"),
  convert_remove_collision("coral-water"),
  convert_remove_collision("split-gill-2x2"),
  convert_remove_collision("split-gill-red-2x2"),
  convert_remove_collision("urchin-cactus"),
  convert_remove_collision("brambles"),
})
