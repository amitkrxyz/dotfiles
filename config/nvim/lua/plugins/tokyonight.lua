-- folke/tokyonight.nvim
return {
  "folke/tokyonight.nvim",
  opts = {},
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      transparent = true
    })
    vim.cmd[[colorscheme tokyonight]]
  end
}
