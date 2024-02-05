local M = {}

---@param group string
function M.highlight(group, hl)
  if hl.style then
    if type(hl.style) == "table" then
      hl = vim.tbl_extend("force", hl, hl.style)
    end
    hl.style = nil
  end
  vim.api.nvim_set_hl(0, group, hl)
end

function M.syntax(syntax)
  for group, colors in pairs(syntax) do
    M.highlight(group, colors)
  end
end

---@param theme Theme
function M.load(theme)
  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "mostly-off"

  M.syntax(theme.highlights)
end

return M
