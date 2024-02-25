:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set cursorline

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview			
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/windwp/nvim-autopairs' " Auto pairs
Plug 'akinsho/bufferline.nvim', {'tag': '*'} " Bufferline
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter
Plug 'nvim-lua/plenary.nvim' " Plenary
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.5'} " Telescope
set encoding=UTF-8

call plug#end()

" Set up auto pairs
lua require('nvim-autopairs').setup{}

" Set up bufferline
lua require('bufferline').setup{}

" Key Mappings
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For no previews

:set termguicolors
:colorscheme gotham

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line 
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <CR> pumvisible() ? coc#pum#confirm(): "\<CR>"
