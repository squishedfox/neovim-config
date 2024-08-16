call plug#begin()
	Plug 'tomasiser/vim-code-dark'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'BurntSushi/ripgrep'
	Plug 'stevearc/conform.nvim'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	" Debugging
	Plug 'mfussenegger/nvim-dap'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'David-Kunz/jester' " run jest unit tests see https://github.com/David-Kunz/jester?tab=readme-ov-file
	"" used for showing a good debugging ui
	Plug 'nvim-neotest/nvim-nio'
	Plug 'rcarriga/nvim-dap-ui'
	" neo Tree
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'nvim-neo-tree/neo-tree.nvim'
	" language server(s)
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	" For vsnip users.
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'pmizio/typescript-tools.nvim'
	Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  	Plug 'L3MON4D3/LuaSnip' " Snippets plugin
call plug#end()

" Make it so neotree always opens when you do `nvim .`
augroup NeotreeOpen
  autocmd!
  autocmd VimEnter * if isdirectory(expand('%')) | execute 'Neotree' | endif
augroup END

" Disable Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

lua <<EOF
require('init')
EOF

set number
syntax on
colorscheme codedark
