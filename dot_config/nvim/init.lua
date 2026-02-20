-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.termguicolors = true

require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        nvimtree = true, -- Se usar NvimTree
        neotree = true,  -- Se usar Neo-tree
        treesitter = true,
    },
    custom_highlights = function(colors)
        return {
            -- Força a transparência nos painéis laterais
            NvimTreeNormal = { bg = "none" },
            NvimTreeNormalNC = { bg = "none" },
            NeoTreeNormal = { bg = "none" },
            NeoTreeNormalNC = { bg = "none" },
            EndOfBuffer = { fg = colors.mantle, bg = "none" }, -- Limpa o fim da linha
        }
    end,
})


vim.cmd.colorscheme("catppuccin")
