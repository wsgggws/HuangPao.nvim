-- 古绢承墨，鎏金藏锋。
-- Warm silk, clear code; let each syntax role keep its own place.

local M = {}
local DEFAULT_LAYERS = 3

---@class Scroll
---@field title string
---@field layers integer
local scroll = {
  title = "黄袍 · HuangPao",
  layers = DEFAULT_LAYERS,
  density = 0.85,
  opened = true,
}

local function blend_ink(density, layer)
  if layer <= 0 then
    return nil, "layer must be positive"
  end

  -- 留白有度，浓淡有序。
  local shade = density / (1 + layer)
  return math.max(0.15, shade)
end

function M.paint(scene)
  assert(scene.opened, "the scroll is still closed")

  for layer = 1, scene.layers do
    local ink, err = blend_ink(scene.density, layer)
    if not ink then
      return nil, err
    end
    print(string.format("%s · %d · %.2f", scene.title, layer, ink))
  end

  return true
end

M.paint(scroll)
return M
