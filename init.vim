call plug#begin()
	Plug 'tomasiser/vim-code-dark'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-gocode.vim'
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
call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

    let g:lsp_format_sync_timeout = 1000
    " allow modifying the completeopt variable, or it will
    " be overridden all the time
    let g:asyncomplete_auto_completeopt = 0

    set completeopt=menuone,noinsert,noselect,preview
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    " refer to doc to add more commands
endfunction

" Call the function when an LSP client attaches to a buffer
augroup lsp_install
	au!
 	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Make it so neotree always opens when you do `nvim .`
augroup NeotreeOpen
  autocmd!
  autocmd VimEnter * if isdirectory(expand('%')) | execute 'Neotree' | endif
augroup END

" Disable Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-remote=auto']},
        \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
        \ })
    autocmd BufWritePre *.go
        \ call execute('LspDocumentFormatSync') |
        \ call execute('LspCodeActionSync source.organizeImports')
endif
lua <<EOF
require('init')
EOF

set number
syntax on
colorscheme codedark
