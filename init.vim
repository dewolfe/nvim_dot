call plug#begin()
" Neovim-only, use in true color terminal
Plug 'flazz/vim-colorschemes'
Plug 'ap/vim-css-color'
Plug 'groenewege/vim-less'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Chiel92/vim-autoformat'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'janko-m/vim-test'
Plug 'danchoi/ri.vim'
Plug 'xolox/vim-misc'
Plug 'qpkorr/vim-bufkill'
Plug 'bkad/CamelCaseMotion'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'vim-ruby/vim-ruby'
Plug 'ianks/vim-tsx'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'jacoborus/tender'
Plug 'dag/vim-fish'
Plug 'sgur/vim-editorconfig'
Plug 'fatih/vim-go', { 'branch': 'master', 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'ruanyl/vim-gh-line'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()
filetype plugin indent on

" LanguageClient Settings
let g:LanguageClient_autoStop = 0
let g:LanguageClient_serverCommands = {
			\ 'ruby': ['tcp://localhost:7658']
			\ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

" Search with ripgrep
let g:rg_command = '
			\ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
			\ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
			\ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
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
set number


"Visuals
syntax on
set termguicolors
set background=dark
colorscheme hybrid_material
hi VertSplit ctermbg=235 ctermfg=235
set go-=L " remove left scrollbar
set go-=r " remove right scrollbar


" Visuals: ALE
highlight ALEWarningSign guifg=#f0f166
highlight ALEErrorSign guifg=#ff4d47
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '⚠'

" Visuals: airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1 " https://github.com/bling/vim-airline/wiki/FAQ
let g:airline#extensions#whitespace#enabled = 0 " too obtrusive
let g:airline_theme = "tender"
let g:airline#extensions#hunks#enabled = 0 " no room :(
let g:airline_section_y = '' " no room :'(
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 0 " just nevever found it that useful :/

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

"let g:loaded_python3_provider=1
let NERDTreeQuitOnOpen=1
nnoremap <C-p> :Files<Cr>

let g:deoplete#enable_at_startup = 1

" CtrlP -> directories to ignore when fuzzy finding
"let g:ctrlp_custom_ignore = '\v[\/]((node_modules)|\.(git|svn|grunt|sass-cache))$'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Ack (uses Ag behind the scenes)
let g:ackprg = 'ag --nogroup --nocolor --column'
" Maps
map <leader>' :NERDTreeToggle<cr>
nmap <C-o> :FZF<CR>
" Camel Case Motion (for dealing with programming code)
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <leader>af :Autoformat<CR>

sunmap w
sunmap b
sunmap e

noremap  <silent> <C-S>              :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
"
"Manage tabs
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

map <C-j> :cn<CR>
map <C-k> :cp<CR>

set nowrap
nmap <leader>cs :let @*=expand("%")<CR>
nmap <leader>tn :tabnew
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'vue': ['eslint']
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['prettier'],
\    'vue': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\}

