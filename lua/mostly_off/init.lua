local util = require("mostly_off.util")
local theme = require("mostly_off.theme")
local config = require("mostly_off.config")

local M = {}

function M._load(style)
  if style and not M._style then
    M._style = require("mostly_off.config").options.style
  end
  -- if not style and M._style then
  --   require("mostly_off.config").options.style = M._style
  --   M._style = nil
  -- end
  M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("mostly_off.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

return M
