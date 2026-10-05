-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("figo_" .. name, { clear = true })
end

-- Grupos de keyword do treesitter + grupos legados (syntax regex)
local keyword_groups = {
  "@keyword",
  "@keyword.coroutine",
  "@keyword.function",
  "@keyword.operator",
  "@keyword.import",
  "@keyword.type",
  "@keyword.modifier",
  "@keyword.repeat",
  "@keyword.return",
  "@keyword.debug",
  "@keyword.exception",
  "@keyword.conditional",
  "@keyword.conditional.ternary",
  "@keyword.directive",
  "@keyword.directive.define",
  "Keyword",
  "Statement",
  "Conditional",
  "Repeat",
  "Exception",
  "Include",
}

-- Definição efetiva do grupo, subindo na hierarquia se não existir
-- (@keyword.return -> @keyword), como o fallback do treesitter faz
local function resolve_hl(name)
  while name do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false, create = false })
    if next(hl) then
      return hl
    end
    name = name:match("^(.*)%.[^.]+$")
  end
  return {}
end

-- nvim_set_hl SUBSTITUI o grupo inteiro; isto mescla só o que você passar
local function extend_hl(name, attrs)
  local hl = vim.tbl_deep_extend("force", resolve_hl(name), attrs)
  ---@cast hl vim.api.keyset.highlight
  vim.api.nvim_set_hl(0, name, hl)
end

local function habamax_overrides()
  -- Fundo transparente, preservando o fg do habamax
  extend_hl("Normal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#767676", bg = "NONE" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#767676", bg = "NONE" })

  vim.api.nvim_set_hl(0, "TabLineSel", { link = "PmenuSel" })
  vim.api.nvim_set_hl(0, "TabLine", { link = "StatusLineNC" })
  vim.api.nvim_set_hl(0, "TabLineFill", { link = "StatusLineNC" })

  -- Diffs mais legíveis que os do habamax (#274733/#373737/#2f1f1a); o neogit
  -- deriva os fundos dos diffs dele (line_green/line_red) do bg de
  -- DiffAdd/DiffDelete, e o codediff linka direto nesses grupos.
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2e5c46", ctermbg = 22 })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#39434f", ctermbg = 238 })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#462626", fg = "#d78787", ctermbg = 52, ctermfg = 138 })
  vim.api.nvim_set_hl(0, "DiffText", { bg = "#1c6a75", ctermbg = 30 })

  -- Keywords em negrito (gui e cterm)
  for _, group in ipairs(keyword_groups) do
    extend_hl(group, { bold = true, cterm = { bold = true } })
  end
end

if vim.g.colors_name == "habamax" then
  habamax_overrides()
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "habamax",
  group = augroup("habamax_overrides"),
  callback = habamax_overrides,
})
