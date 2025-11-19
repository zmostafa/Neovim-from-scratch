local colorscheme = "tokyonight"
-- local colorscheme = "darkplus"
-- local colorscheme = "solarized-osaka"

require("tokyonight").setup {
    transparent = true,
    styles = {
       sidebars = "transparent",
       floats = "transparent",
    }
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

