-- require 'lsp.lsp'
-- Look at 
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/jpmcb/nvim-lua-conf/blob/main/lua/plugins/packer.lua
-- https://microsoft.github.io/language-server-protocol/implementors/servers/
-- https://github.com/regen100/cmake-language-server
-- https://github.com/MaskRay/ccls/wiki/Build
-- https://github.com/python-lsp/python-lsp-server
--
-- Config was built using the following config:
-- https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim/

local g   = vim.g
local o   = vim.o
local opt = vim.opt
local A   = vim.api

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'
t_check = 0
--function ToggleBG()
--    if t_check == 0 then
--        vim.cmd([[
--        augroup transparency
--        autocmd!
--        command! hi Normal guibg=NONE ctermbg=NONE
--        augroup end
--        ]])
--        t_check = 1
--    else
--        t_check = 0
--        vim.cmd([[
--        augroup no_transperency
--        autocmd!
--        autocmd background=dark
--        augroup end
--        ]])
--    end
--end

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'
o.undodir = vim.env.HOME .. '/undo/'

somedir = '../fish/config.fish'
--somedir = '~/.config/fish/config.fish'
-- Remember 500 items in commandline history
o.history = 500

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumpingrequire('lualine').get_config()
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--
-- opt.mouse = "a"

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

require('lualine').setup()

-- COLORSCHEMES
-- Uncomment just ONE of the following colorschemes!
local ok, _ = pcall(vim.cmd, 'colorscheme challenger_deep')


-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

-- Pressing enter after bracket
--npairs.setup({ map_cr = true })


-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<F2>', ':NERDTreeToggle<CR>')
map('n', '<leader>h', '<C-W>h')
map('n', '<leader>j', '<C-W>j')
map('n', '<leader>k', '<C-W>k')
map('n', '<leader>l', '<C-W>l')
map('n', '<leader>f', function() 
    --pwd | echo expand('%:p:h')
    vim.cmd([[
    if empty(glob('<cfile>:h')) || empty(glob('<cfile>'))
        Fe %:h/<cfile>
    else
        Fe <cfile>
    endif
    ]])
--    if vim.fn['echo'](vim.fn['empty'](vim.api.nvim_command("glob('<cfile>')"))) or vim.fn['echo'](vim.fn['empty'](vim.api.nvim_command("glob('<cfile>:h')"))) then
--        vim.api.nvim_command("Fe expand('%:h')/<cfile>")
--    else
--    vim.api.nvim_command("Fe <cfile>")
--    end
end
)

vim.keymap.set("n", "<leader>t", function()
    if t_check == 0 then
        vim.cmd([[ execute 'hi Normal guibg=NONE ctermbg=NONE' ]])
        --print "Incolorino Mode"
        t_check = 1
    else
        vim.cmd([[ execute 'set background=dark' ]])
        --print "Back in colour"
        t_check = 0
  end
end, { desc = "Transparent background toggler", noremap = true })

vim.g.user_emmet_leader_key='¿'

require('njacf.floaty')
-- Press enter after a bracket
require("nvim-autopairs").setup({map_cr=true})

-- PLUGINS
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A better status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- File management --
  use 'preservim/nerdtree'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'

  -- Tim Pope Plugins --
  use 'tpope/vim-surround'
  use 'tpope/vim-obsession'

  -- Syntax Highlighting and Colors --
  use 'vim-python/python-syntax'
  use 'chrisbra/Colorizer'
  use 'vim-syntastic/syntastic'
  use 'mechatroner/rainbow_csv'

  -- Junegunn Choi Plugins --
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'junegunn/vim-emoji'

  -- Colorschemes
  use {
      'challenger-deep-theme/vim',
      name = "challenger-deep"
  }

  -- Coding
  use 'mattn/emmet-vim'
  use 'lervag/vimtex'

  -- Typing
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
    }
end)
