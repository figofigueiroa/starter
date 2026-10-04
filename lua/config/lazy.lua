local lazierpath = vim.fn.stdpath("data") .. "/lazier/lazier.nvim"
if not (vim.uv or vim.loop).fs_stat(lazierpath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=lazyvim-v2",
    "https://github.com/figofigueiroa/lazier.nvim.git",
    lazierpath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazier.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "MoreMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazierpath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- booting LazyVim.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Specs live in `lua/plugins/`. The LazyVim distro import must be the
-- first user spec file, so name it `00-lazyvim.lua`.
require("lazier").setup("plugins", {
  lazier = {
    -- specs stay fully explicit: no keymap/autocmd codegen from profile runs
    generate_lazy_mappings = false,
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
