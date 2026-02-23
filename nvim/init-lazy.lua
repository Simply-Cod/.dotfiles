--- [init.lua] ---

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Options -------------------------------------

-------------------------------------------------
local opt = vim.opt

opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.winborder = "rounded"
opt.showmode = false
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.wrap = false
opt.confirm = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Indentation & tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- completions
opt.completeopt = { "menu", "menuone", "noinsert" }

opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣"
}

--- netrw ---------------------------------------

-------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_keepdir = 0
vim.g.netrw_browse_split = 0

--- Keymap --------------------------------------

-------------------------------------------------
local keymap = vim.keymap.set

keymap("n", "<C-e>", "<cmd>20Lexplore<CR>", { silent = true, desc = "netrw file explorer" })
keymap('n', '<leader>cd', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = "Change Directory" })

keymap("n", "<C-q>", "<cmd>quit<CR>", {desc = "quit"})
keymap("n", "<C-s>", "<cmd>write<CR>", {desc = "Write"})

keymap("n", "<C-d>", "<C-d>zz", { silent = true })
keymap("n", "<C-u>", "<C-u>zz", { silent = true })

-- Moving between windows
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")

-- Yank to and from clipboard
keymap("v", "gy", '"+y', { desc = "Yank to clipboard" })
keymap("n", "gp", '"+p', { desc = "Paste from clipboard" })

-- fzf
keymap("n", "<C-p>", "<cmd>FzfLua files<CR>", { silent = true, desc = "fzf files" })
keymap("n", "<C-b>", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "fzf buffers"})
keymap("n", "<C-g>", "<cmd>FzfLua live_grep<CR>", { silent = true, desc = "fzf grep" })

keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { silent = true, desc = "fzf files" })
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "fzf buffers" })
keymap("n", "<leader>fg", "<cmd>FzfLua grep<CR>", { silent = true, desc = "fzf grep" })
keymap("n", "<leader>fd", "<cmd>FzfLua diagnostics_workspace<CR>", { silent = true, desc = "fzf diagnostics" })
keymap("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { silent = true, desc = "fzf marks" })
keymap("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { silent = true, desc = "fzf keymaps" })

-- Code
keymap("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "grD", vim.lsp.buf.declaration, { desc = "Go to decleration" })
keymap("n", "grf", function() vim.lsp.buf.format { async = true } end, { desc = "Format", silent = true })
keymap("n", "grn", vim.lsp.buf.rename, { desc = "Rename", silent = true })
keymap("n", "grs", vim.lsp.buf.signature_help, { desc = "Signature help", silent = true })

-- diagnostics
keymap("n", "<leader>dd", vim.diagnostic.open_float, {desc = "Open diagnostic window"})
keymap("n", "<leader>dp", function()vim.diagnostic.jump({count = -1, float = true})end, { desc = "Go to previous diagnostic" })
keymap("n", "<leader>dn", function()vim.diagnostic.jump({count = 1, float = true})end, { desc = "Go to next diagnostic" })

--- Plugins (Lazy)-------------------------------

-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup{

    { --- Mason ---------------------------------
        "mason-org/mason.nvim",
        opts = {}
    },
    { --- Lsp config ----------------------------
        "neovim/nvim-lspconfig",
    },
    { --- Completion ----------------------------
          'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        cmdline = {
            enabled = true,

            completion = {
                list = {
                    selection = {preselect = false},
                },
                menu = {
                    auto_show = function()
                    return vim.fn.getcmdtype() == ":"
                    end,
                },
                ghost_text = {enabled = true},
            },
        },
        opts = {

            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = true } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    { --- fzf -----------------------------------
        "ibhagwan/fzf-lua",
        opts = {},
    },
    { --- Git -----------------------------------
        "tpope/vim-fugitive"
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup{}
        end,
    },
    { --- Lualine -------------------------------
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup{}
        end,
    },
    { --- Theme ---------------------------------
        "rose-pine/neovim",
        name = "rose-pine",
        init = function()
            vim.cmd.colorscheme("rose-pine")
        end,
        opts = {...},
    },
    { --- netrw icons ---------------------------
        "prichrd/netrw.nvim",
        opts = {},
    },


}

--- Lsp -----------------------------------------

-------------------------------------------------
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")

--- Diagnosticts --------------------------------

-------------------------------------------------
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = false,
    underline = true,

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    }

})

--- Autocommands --------------------------------
-------------------------------------------------

-- Auto highligt Yanked
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch", -- The highlight group to use (e.g., IncSearch, Visual)
            timeout = 200,         -- Duration of the highlight in milliseconds
        })
    end,
})
