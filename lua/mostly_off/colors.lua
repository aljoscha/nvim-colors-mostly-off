local util = require("mostly_off.util")

local M = {}

local function load_palettes()
  -- stylua: ignore start
  local white           = "#F1F1F1"
  local actual_white    = "#FFFFFF"
  local black           = "#262626"
  local subtle_black    = "#303030"
  local light_black     = "#424242"
  local lighter_black   = "#545454"
  local medium_gray     = "#767676"
  local light_gray      = "#B2B2B2"
  local lighter_gray    = "#EEEEEE"
  local lightest_gray   = "#f9f9f9"
  local darker_red      = "#542328"
  local dark_red        = "#c03545"
  local red             = "#ff2222"
  local light_red       = "#ffeef0"
  local darker_blue     = "#2b4d80"
  local dark_blue       = "#3c71be"
  local blue            = "#b0ceff"
  local light_blue      = "#E6F3FE"
  local darker_green    = "#1f4f34"
  local dark_green      = "#1cad4c"
  local light_green     = "#e6ffed"
  local light_purple    = "#6855DE"
  local yellow          = "#F3E430"
  local orange          = "#F2A93B"
  -- stylua: ignore end

  local palettes = {}
  ---@class Palette
  palettes.common = {
    none = "NONE",
  }

  local dark_norm = lighter_gray
  ---@class Palette
  palettes.dark = {
    bg              = black,
    bg_subtle       = light_black,
    bg_very_subtle  = subtle_black,
    bg_extra_subtle = light_black,
    norm            = dark_norm,
    norm_subtle     = light_gray,

    red             = red,
    red_subtle      = light_red,
    green           = light_green,
    blue            = light_blue,
    orange          = orange,
    medium_gray     = medium_gray,
    subtle_gray     = lighter_gray,

    visual          = lighter_black,
    highlight       = medium_gray,
    search          = yellow,
    directory       = dark_blue,

    diff_info_fg    = dark_norm,
    diff_info_bg    = darker_blue,

    diff_add_fg     = dark_norm,
    diff_add_bg     = darker_green,

    diff_remove_fg  = dark_norm,
    diff_remove_bg  = darker_red,

    lsp_reference_read  = darker_green,
    lsp_reference_write = darker_red,
    lsp_reference_text  = darker_blue,
  }

  ---@class Palette
  palettes.light = {
    bg              = actual_white,
    bg_subtle       = light_gray,
    bg_very_subtle  = lighter_gray,
    bg_extra_subtle = lightest_gray,
    norm            = black,
    norm_subtle     = lighter_black,

    red             = red,
    red_subtle      = dark_red,
    green           = dark_green,
    blue            = dark_blue,
    orange          = orange,
    medium_gray     = medium_gray,
    subtle_gray     = lighter_gray,

    visual          = light_blue,
    highlight       = blue,
    search          = yellow,
    directory       = dark_blue,

    diff_info_fg    = dark_blue,
    diff_info_bg    = light_blue,

    diff_add_fg     = dark_green,
    diff_add_bg     = light_green,

    diff_remove_fg  = dark_red,
    diff_remove_bg  = light_red,

    lsp_reference_read  = light_green,
    lsp_reference_write = light_red,
    lsp_reference_text  = light_blue,
  }

  return palettes
end

M.palettes = load_palettes()

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("mostly_off.config")

  local style = config.is_light() and config.options.light_style or config.options.style
  local palette = M.palettes[style] or {}

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.palettes.common), palette)

  -- TODO
  colors.diff = {
    add = colors.diff_add_bg,
    delete = colors.diff_remove_bg,
    change = colors.diff_info_bg,
    text = colors.diff_info_bg,
  }

  colors.diagnostic = {
    error = colors.red,
    error_subtle = colors.red_subtle,
    todo = colors.red_subtle,
    warning = colors.orange,
    info = colors.blue,
    hint = colors.medium_gray,
    ok = colors.green,
  }

  -- colors.git.ignore = colors.red
  colors.border_highlight = colors.norm_subtle
  colors.border = colors.bg

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_subtle
  colors.bg_statusline = colors.bg_very_subtle
  colors.fg_statusline = colors.norm

  -- Sidebar and Floats are configurable
  colors.fg_sidebar = colors.norm
  colors.bg_sidebar = colors.bg_extra_subtle

  colors.fg_float = colors.norm
  colors.bg_float = colors.bg_extra_subtle

  colors.bg_visual = colors.visual
  colors.bg_search = colors.bg_subtle
  colors.bg_inc_search = colors.search
  colors.fg_inc_search = colors.norm_subtle
  colors.fg_gutter = colors.bg_subtle
  colors.fg_whitespace = colors.medium_gray
  colors.fg_gutter_cursor = colors.highlight
  colors.fg_match_paren = colors.highlight
  colors.bg_pmenu_sel = colors.highlight
  colors.fg_special_key = colors.green
  colors.fg_tab_sel = colors.norm
  colors.fg_title = colors.directory

  return colors
end

return M
