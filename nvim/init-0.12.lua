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


--- netrw (Built in file explorer) --------------
-------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_keepdir = 0
vim.g.netrw_browse_split = 0

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

keymap("n", "<leader>dd", vim.diagnostic.open_float, {desc = "Open diagnostic window"})
keymap("n", "<leader>dp", function()vim.diagnostic.jump({count = -1, float = true})end, { desc = "Go to previous diagnostic" })
keymap("n", "<leader>dn", function()vim.diagnostic.jump({count = 1, float = true})end, { desc = "Go to next diagnostic" })


--- Plugins -------------------------------------
-------------------------------------------------
local gh = function(x) return "https://github.com/" .. x end
vim.pack.add({
    { src = gh("mason-org/mason.nvim") },                           -----------------   Lsp-servers     -----------------
    { src = gh("neovim/nvim-lspconfig") },                          -----------------   Lsp-config      -----------------
    { src = gh("saghen/blink.cmp") },                               -----------------   completions     -----------------
    { src = gh("rafamadriz/friendly-snippets") },                   -----------------   snippets        -----------------
    { src = gh("nvim-lualine/lualine.nvim") },                      -----------------   LuaLine         -----------------
    { src = gh("ibhagwan/fzf-lua") },                               -----------------   fzf             -----------------
    { src = gh("rose-pine/neovim"), name = "rose-pine" },           -----------------   theme           -----------------
    { src = gh("tpope/vim-fugitive") },                             -----------------   git             -----------------
    { src = gh("nvim-lua/plenary.nvim") },                          -----------------   gitsigns dep    -----------------
    { src = gh("lewis6991/gitsigns.nvim") },                        -----------------   gitsigns        -----------------
    { src = gh("nvim-tree/nvim-web-devicons") },                    -----------------   icons           -----------------
    { src = gh("prichrd/netrw.nvim") },                             -----------------   netrw icons     -----------------
})

vim.cmd("colorscheme rose-pine")
require("lualine").setup {}
require("fzf-lua").setup {}
require("netrw").setup{}


--- Lsp config ----------------------------------
-------------------------------------------------
require("mason").setup {}

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")

--- Completions ---------------------------------
--- You will need rust and cargo to build plugin in ~/.local/share/nvim/site/pack/core/opt/blink.cmp/
--- run 'cargo build --release' in said directory
--- or
--- change implementation to 'lua'
-------------------------------------------------
require("blink.cmp").setup{
    keymap = { preset = 'default' },

    completion = { documentation = { auto_show = true } },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },

    fuzzy = {
        implementation = "prefer_rust_with_warning"
    },
}


--- Diagnosticts --------------------------------
-------------------------------------------------
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
})
