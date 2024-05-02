local util = require("mostly_off.util")
local theme = require("mostly_off.theme")
local config = require("mostly_off.config")

local M = {}

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("mostly_off.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

return M
