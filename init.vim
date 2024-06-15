" Neovim-only, use in true color terminal

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'flazz/vim-colorschemes'
Plug 'ap/vim-css-color'
Plug 'groenewege/vim-less'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'vim-autoformat/vim-autoformat'
Plug 'ervandew/supertab'
Plug 'jlanzarotta/bufexplorer'
Plug 'janko-m/vim-test'
Plug 'danchoi/ri.vim'
Plug 'xolox/vim-misc'
Plug 'qpkorr/vim-bufkill'
Plug 'bkad/CamelCaseMotion'
Plug 'elixir-tools/elixir-tools.nvim'
Plug 'ianks/vim-tsx'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'github/copilot.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'jacoborus/tender'
Plug 'dag/vim-fish'
Plug 'sgur/vim-editorconfig'
Plug 'leafgarland/typescript-vim'
Plug 'ruanyl/vim-gh-line'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jackMort/ChatGPT.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()


filetype plugin indent on

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft :lua require'telescope.builtin'.treesitter{}<cr>



" Search with ripgrep
let g:rg_command = '
      \ rg --column --line-number --no-heading --fixed-strings --no-ignore --hidden --follow --color "always"
      \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
      \ -g "!{.git,node_modules,vendor}/*"
      \ '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
" Tabs
set tabstop=2
set shiftwidth=2
set expandtab

au FileType make setlocal noexpandtab

" Override editorconfig
" We add the BufReadPost, BufNewFile autocmds in VimEnter so that they run
" after the plugin runs (apparently the events are not added at this point
" in vimrc). Also set it right in VimEnter since it fires after Buf autocmds
au VimEnter * set tabstop=2 shiftwidth=2|au BufReadPost,BufNewFile * set tabstop=2 shiftwidth=2

" Indent
set autoindent
set smartindent

"use system clipboard
set clipboard=unnamedplus


" Editorconfig
let g:editorconfig_blacklist = {'filetype': ['git.*']}

" Misc
set inccommand=split
set incsearch
set mouse=a
set hidden " allow switching from unsaved buffers to others
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Editor features
set cursorline
set rnu
set nu


"Visuals
syntax on
set termguicolors
set background=dark
colorscheme hybrid_material
hi VertSplit ctermbg=235 ctermfg=235
set go-=L " remove left scrollbar
set go-=r " remove right scrollbar

" Visuals: airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1 " https://github.com/bling/vim-airline/wiki/FAQ
let g:airline#extensions#whitespace#enabled = 0 " too obtrusive
let g:airline_theme = "tender"
let g:airline#extensions#hunks#enabled = 0 " no room :(
let g:airline_section_y = '' " no room :'(
let g:airline#extensions#syntastic#enabled = 1

" Visuals: gitgutter
hi SignColumn guibg=#222222
hi GitGutterAdd guibg=#222222 guifg=#afd702
hi GitGutterDelete guibg=#222222 guifg=#ff4d47
hi GitGutterChange guibg=#222222 guifg=#0087af
hi GitGutterChangeDelete guibg=#222222 guifg=#0087af

set laststatus=2

"Indentation
let g:indentLine_color_term = 239

" Rainbow parenthesis always on!
if exists(':RainbowParenthesesToggle')
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
endif

"Auto Correct
iabbrev teh the
iabbrev het the
iabbrev authoirty authority
iabbrev Authoirty Authority
iabbrev distrcit district
iabbrev distrcits districts

" Enable ALE
let g:ale_enable = 1

" Set linters
let g:ale_linters = {
      \  'python': ['flake8'],
      \  'elixir': ['credo'],}

let g:ale_fixers = {
      \ 'elixir': ['credo'],}


" Set linting to occur on file save and text change
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'

let NERDTreeQuitOnOpen=1
nnoremap <C-p> :Files<Cr>


" Ack (uses Ag behind the scenes)
let g:ackprg = 'ag --nogroup --nocolor --column'
" Maps
map <leader>' :NERDTreeToggle<cr>
map <leader>af :Autoformat<CR>
map <leader>nf :NERDTreeFind<cr>
map <leader>vs :vsp

"Buffers
" Move to the next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Move to the previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>

"Manage tabs
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
nmap <leader>tn :tabnew<CR>
map <C-j> :cn<CR>
map <C-k> :cp<CR>

"" Camel Case Motion (for dealing with programming code)
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

sunmap w
sunmap b
sunmap e

noremap  <silent> <C-S>              :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
noremap  <leader>co :Copilot panel<CR>
noremap  <leader>c :ChatGPT<CR>
noremap  <leader>ca :ChatGPTActAs<CR>


set nowrap
nmap <leader>cs :let @*=expand("%")<CR>



let g:python3_host_prog = '/home/dewolfe/.asdf/installs/python/3.12.3/bin/python'

" Lua script
lua << EOF
require("chatgpt").setup()
require("elixir").setup({
  nextls = {enable = false},
  credo = {enable = true},
  elixirls = {enable = true},
})
require'nvim-treesitter.configs'.setup {
  -- A list ofuparser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query","elixir","ruby"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
local nvim_lsp = require('lspconfig')

-- Attach LSP mappings when the LSP client attaches to a buffer
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- Example: Configure the language server for Python
EOF

