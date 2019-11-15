" Lukas Tillmann

" Vundle Plugins {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" emmet
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'             " automatic closing of quotes, etc
Plugin 'airblade/vim-gitgutter'           
" Plugin 'simeji/winresizer.git'            " resize vim panes with arrow keys
" Plugi"n 'altercation/vim-colors-solarized'   " replaced by gruvbox
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'          " better javascript syntax higlighting
Plugin 'mxw/vim-jsx'                      " syntax highlighting and indentation for jsx 
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-syntastic/syntastic'
" Plugin 'elzr/vim-json'
Plugin 'vim-airline/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-fugitive'               " git wrapper for vim (e.g. :GBlame etc);
Plugin 'prettier/vim-prettier'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'SirVer/ultisnips'                 " snippets
Plugin 'honza/vim-snippets'               " default snippets
Plugin 'posva/vim-vue'                    " syntax highlighting for vue files
" vim-vue: eslint is necessary: npm i -g eslint eslint-plugin-vue
Plugin 'kshenoy/vim-signature'            " toggle/display/navigate marks
Plugin 'w0rp/ale'                         " for using eslint with vim
Plugin 'neoclide/coc.nvim'                " autocomplete plugin
Plugin 'juneedahamed/svnj.vim'            " svn mappings
Plugin 'embear/vim-localvimrc'
Plugin 'ap/vim-css-color'                 " color previews in css

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" Base Options {{{
set ruler
set number

set autoindent
set ai

set nospell                         " disable spell-checking

set foldmethod=indent
set foldnestmax=10
set foldlevelstart=10

set shiftwidth=3
set tabstop=3
set expandtab

set cursorline                      " highlight the current line

set wildmenu                        " graphical autocomplete menu for files

set hlsearch                        " highlight search results
set incsearch                       " search as characters are entered
set ignorecase                      " ignore case when searching

set showmatch                       " show matching brackets

let mapleader = ","

set modelines=1                     " check first and last line for file specific configs

set exrc                            " allow project specific .vimrc files
set secure                          " disable unsave commands in project vimrc

set backspace=2                     " make backspace work like other programs

set omnifunc=syntaxcomplete#Complete

set nofixendofline                  " to prevent 'no end of line' warnings in git diff

set visualbell                      " disable beep sounds
set t_vb=                           " If 't_vb' is cleared and 'visualbell' is set, no beep and no flash will ever occur

" }}}

" Colors {{{
syntax enable
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
" }}}

" Mappings {{{

nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
imap <C-c> <CR><Esc>O       " mapping to split lines (e.g. between brackets)

" double dashes to toggle comments (with vim-commentary plugin)
map // gcc

" apply macros with Q
" hit qq to record, q to stop recording, and Q to apply.
nnoremap Q @q
vnoremap Q :norm @q<cr>

set pastetoggle=<leader>z " toggle paste mode with leader-z

map <C-n> :NERDTreeToggle<CR>

" increment/decrement number with Alt-a/Alt-x
" because Ctrl-a is used by tmux
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>

" add new line after opening brackets
" see https://stackoverflow.com/a/35711195/5888924
inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"

" copy to windows clipboard
map <C-c> :w !clip.exe<CR><CR>

" }}}

" Buffer/Saving {{{

" Starting from vim 7.3 undo can be persisted across sessions
" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/c2onmqe
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Reload changes to .vimrc automatically
autocmd BufWritePost  ~/.vimrc source ~/.vimrc

" deactivate safe write
set backupcopy=yes


"}}}

" Pane Handling / Tmux {{{

" switching between panes
" taken over by vim-tmux-navigator
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" resize panes with arrow keys
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Auto resize Vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

" split new panes left/down/up/right
nnoremap <C-W><C-J> <C-W>s<C-W><C-J>
nnoremap <C-W><C-K> <C-W>s<C-W><C-K>
nnoremap <C-W><C-L> <C-W>v<C-W><C-L>
nnoremap <C-W><C-H> <C-W>v<C-W><C-H>

"}}}

" Syntastic {{{
" npm install -g csslint jshint jsonlint
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" let g:syntastic_mode="passive"
" let g:syntastic_enable_signs=0
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_json_checkers= ['jsonlint']
let g:syntastic_quiet_messages = { "level": "warnings" }

nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>
" }}}

" Prettier {{{
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#tab_width = 3
let g:prettier#config#html_whitespace_sensitivity = 'ignore'
" use F9 to trigger Prettier
nnoremap <F9> :Prettier<CR>
" }}}

" UltiSnips {{{

" UltiSnips needs python support
" check for python with `:ech has('python')` or `:echo has('python3')`
" put custom snippets into folder .vim/custom-snippets
" filename: [language]*.snippet (e.g. javascript-react.snippet) where * is a
" wildcard and can be anything
" use 'all' for all language
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-snippets"]
" }}}

" CTRLP {{{
" let ctrlp ignore files and directorys in .gitignore files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" }}}

" Other plugins {{{

" vim-jsx configuration
let g:jsx_ext_required = 0
" faster syntax highlighting in vue files
let g:vue_disable_pre_processors = 1
" }}}

" localvimrc config {{{
let g:localvimrc_whitelist=['/home/lukas/*']
" }}}

" Misc {{{

" javascript syntax for helma hac files
autocmd BufNewFile,BufRead *.hac set filetype=javascript
autocmd BufNewFile,BufRead *.skin set filetype=html

" }}}

" Custom Functions {{{

" Functions to remove all gutters (used for tmux copy function)
nnoremap <F3> :call RemoveGutter()<CR>
nnoremap <F4> :call AddGutter()<CR>

function! RemoveGutter()
  execute "set nonumber"
  execute "GitGutterDisable"
endfunction
function! AddGutter()
  execute "set number"
  execute "GitGutterEnable"
endfunction

" reset syntax highlighting in vue files
nnoremap <C-s> :syntax sync fromstart<CR>
" set autocommand for this, may have performance issues, try out later
autocmd FileType vue syntax sync fromstart

" }}}

" Often used commands {{{
" <C-W>R - swap splits
" }}}

" vim:foldmethod=marker:foldlevel=0
