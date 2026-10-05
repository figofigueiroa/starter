-- lua/lualine/themes/habamax.lua  (ou direto no setup)
local c = {
  bg = "#1c1c1c",
  bg_alt = "#303030",
  bg_mid = "#444444",
  fg = "#bcbcbc",
  fg_dim = "#767676",
  blue = "#87afd7",
  green = "#87af87",
  yellow = "#d7af87",
  red = "#d75f5f",
  magenta = "#af87af",
  cyan = "#5f8787",
}

local theme = {
  normal = {
    a = { fg = c.bg, bg = c.blue, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_mid },
    c = { fg = c.fg, bg = c.bg_alt },
  },
  insert = { a = { fg = c.bg, bg = c.green, gui = "bold" } },
  visual = { a = { fg = c.bg, bg = c.magenta, gui = "bold" } },
  replace = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
  command = { a = { fg = c.bg, bg = c.yellow, gui = "bold" } },
  inactive = {
    a = { fg = c.fg_dim, bg = c.bg_alt },
    b = { fg = c.fg_dim, bg = c.bg_alt },
    c = { fg = c.fg_dim, bg = c.bg_alt },
  },
}

return theme
