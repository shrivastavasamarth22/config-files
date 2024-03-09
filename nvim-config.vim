:set number
:set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=2
:set cursorline

let &g:guifont = 'JetBrains\ Mono:h10'

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
Plug 'lukas-reineke/indent-blankline.nvim' " Indent Blankline
Plug 'tpope/vim-commentary' " Commenting
Plug 'rebelot/kanagawa.nvim' " Kanagawa Theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
set encoding=UTF-8

call plug#end()

set hidden

" Refresh NERDTree on save
autocmd BufWritePost * NERDTreeRefresh

" Set up auto pairs
lua require('nvim-autopairs').setup{}

" Set up bufferline
lua require('bufferline').setup{}

" Set up Indent Blankline
lua require("ibl").setup()

" Set up commentary
autocmd FileType python,sh,html,xml,yaml,yml,vim,typescript,javascript,javascriptreact,typescriptreact setlocal commentstring=#\ %s 

" Set up NERDTree
let g:NERDTreeShowHidden=1

" Key Mappings
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
inoremap <expr> <CR> pumvisible() ? coc#pum#confirm(): "\<CR>"
nmap <F8> :TagbarToggle<CR>
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <C-g> :Telescope live_grep<CR>
nnoremap <C-b> :Telescope buffers<CR>

" Set up buffer switch shortcuts
nnoremap <C-Right> :BufferLineCycleNext<CR>
nnoremap <C-Left> :BufferLineCyclePrev<CR>
nnoremap <C-x> :BufferLinePick<CR>
nnoremap <C-q> :BufferLinePickClose<CR>
nnoremap <C-c> :bd<CR>

:set completeopt-=preview " For no previews

:set termguicolors
:colorscheme sonokai

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line 
let g:airline_powerline_fonts = 1
let g:airline_theme="sonokai"

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

" Declare python3 path
let g:python3_host_prog = 'D:\Installations\Python\python.exe'

" Use Lua code in init.vim
lua << EOF
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<Up>'] = function(prompt_bufnr)
          actions.move_selection_previous(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd('colorscheme ' .. selection.value)
        end,
        ['<Down>'] = function(prompt_bufnr)
          actions.move_selection_next(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd('colorscheme ' .. selection.value)
        end,
      },
    },
  },
}

function _G.colorscheme_picker()
  local colorschemes = vim.fn.getcompletion('', 'color')
  local finders = require('telescope.finders')
  local pickers = require('telescope.pickers')
  local conf = require('telescope.config').values

  pickers.new({}, {
    prompt_title = 'Colorschemes',
    finder = finders.new_table {
      results = colorschemes,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('colorscheme ' .. selection.value)
      end)

      -- Preview the colorscheme on highlight
      map('i', '<Up>', function(prompt_bufnr)
        actions.move_selection_previous(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd('colorscheme ' .. selection.value)
      end)

      map('i', '<Down>', function(prompt_bufnr)
        actions.move_selection_next(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd('colorscheme ' .. selection.value)
      end)

      return true
    end,
  }):find()
end
EOF

" Command to open the custom picker
command! ColorschemePicker lua _G.colorscheme_picker()