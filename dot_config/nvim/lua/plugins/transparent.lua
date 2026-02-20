return {
  -- Desabilita o background do Neo-tree e outros elementos UI
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight", -- ou o seu tema (ex: catppuccin)
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        popup_border_style = "none",
      },
    },
  },
  -- Plugin utilitário para forçar transparência em TUDO
  {
    {
      "xiyaowong/transparent.nvim",
      lazy = false,
      opts = {
        extra_groups = {
          -- Snacks (Explorer, Dashboard, etc)
          "SnacksNormal",
          "SnacksNormalNC",
          "SnacksWinBar",
          "SnacksTitle",
          "SnacksBackdrop",
          -- WhichKey (Menu de atalhos)
          "WhichKeyFloat",
          "FloatTitle",
          "WinSeparator",
          "NormalFloat", -- Janelas flutuantes genéricas
          "FloatBorder", -- As bordas das janelas flutuantes
          -- Neo-tree (caso ainda use em algum lugar)
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "NeoTreeWinSeparator",
        },
      },
      config = function(_, opts)
        require("transparent").setup(opts)
        vim.cmd("TransparentEnable")
      end,
    },
  },
}
