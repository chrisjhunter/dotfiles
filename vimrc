"Vimrc


" ----------------------------------------------------------------------------
" Don't want to forget these
" ----------------------------------------------------------------------------
":! go run % -d=debug
" :find <regex>
" :b <regex>
" :%s/\s\+$//e trim whitepsace
" :args /<path to directory>/* open multiple files at once, after you're inside vim
" vim ** from command line will open all files recursively (-o[N] -O[N] limits the number of splits)
" opens files only, ignores directory listings
" find . -xtype f -exec vim {} +
" vim ./* ./*/* - open recursively, 1 dir deep
" C-v , arrow down, shift+i , then type, then esc (to add text to multiple lines
" How many lines in vimrc (grep -v '^\s*"' ~/.vimrc | grep -v "^$"|wc -l)
" Count number of matches :%s/pattern//gn
" Command foward slash(/) - find the cursor in iterm
" :help i_^n or :helpgrep
" diffthis diffoff to compare 2x open buffer files
" Gvdiff <branch>:<file> to view changes between files / names / removed stuff
" Gvdiff hash^ to view a before after change
"
" :%!jq .     - Json formatting

" ----------------------------------------------------------------------------
" Vimplug
" ----------------------------------------------------------------------------
" For Mac/Linux users
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'       "vim git plugin
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'     "handful of tpope pair mappings that I like
Plug 'tpope/vim-vinegar'        "Press - in any buffer to hop up to the directory listing, replaces nerdtree
Plug 'tpope/vim-eunuch'         "UNIX shell commands
"Plug 'ctrlpvim/ctrlp.vim'       "Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }      "default vim-go plugin, update binaries required on new hosts
Plug 'vim-ruby/vim-ruby'        "vim ruby plugin
Plug 'mileszs/ack.vim'          "vim grep replacement
Plug 'EinfachToll/DidYouMean'   "Vim plugin which asks for the right file to open.
"Plug 'maralla/completor.vim'
"Plug 'jiangmiao/auto-pairs'
Plug 'zhaocai/minibufexpl.vim'  "displays open buffers near your status bar ( I use buffers a lot )
Plug 'tyru/regbuf.vim'          "gives you list of registers
Plug 'dahu/vim-lotr'            "LOTR displays a persistent view of your Vim :registers in a sidebar window.
Plug 'junegunn/vim-peekaboo'    "Peekaboo extends \" and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers
Plug 'airblade/vim-gitgutter'   "shows git changes +-~ near the line numbers
Plug 'vim-scripts/scratch.vim'  "creates scratch buffer
"Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'plasticboy/vim-markdown'
Plug 'wlangstroth/vim-racket'
call plug#end()

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif
"gocode
let g:go_gocode_unimported_packages = 1
"let g:completor_python_binary = '/usr/bin/python'
"let g:asyncomplete_auto_popup = 0
"=======================jose de la o=======================
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
"let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabClosePreviewOnPopupClose = 1
set omnifunc=syntaxcomplete#Complete

" Write this in your vimrc file
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_open_list = 1
nnoremap <F7> :ALEToggle<cr>
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>
nnoremap ]A :ALELast<CR>
nnoremap [A :ALEFirst<CR>

" Write this in your vimrc file
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

" ----------------------------------------------------------------------------
"  Endplug 
" ----------------------------------------------------------------------------
" ----------------------------------------------------------------------------
"  General Config
" ----------------------------------------------------------------------------
syntax on                       " Syntax hi-lighting
filetype plugin indent on       " Turn on filetype detection, plugin and indent.vim's into runtimepath
set syntax=enable
set nomodeline                  "CVE-2016-1248 user perm vulnerablity
set nocompatible                " Ignore's vi compatablity
"set nowrap
set wrap 
set linebreak 
set nolist
set bs=indent,eol,start     " Backspace over everything in insert mode
set listchars=tab:\ \ ,trail:-,extends:>,nbsp:\ ,precedes:<
set nofoldenable                " disable folding
set modifiable                  " make a buffer modifiable
set incsearch                   " Lookahead as search pattern is specified
set ignorecase                  " Ignore case in all searches...
set smartcase                   " Unless uppercase letters used
set hlsearch                   " Highlight matches
set history=10000                " How many commands vim will save
set ttyfast                     " faster redrawing
set lazyredraw                  " Redraw only when we need to.
set magic                       " Set magic on, for regex
set path+=**                    " For clever completion with the :find command
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set nowritebackup               " Changes the default 'save' behavior of Vim, to write buffers direct to file
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set pastetoggle=<F2>            " This prevents Vim from auto-indenting the pasted code
set relativenumber              " Show relateive line numbers
set number                      " Show line numbers
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set shiftwidth=4                " Control how many columns text is indented with the reindent operations (<< and >>)
set diffopt+=vertical           "open diffs vertically by default

" small indicators for long lines cut off by screen / window size
"set listchars=extends:>,precedes:<

" Persistent undo
set undofile
set undodir=~/.vim/tmp/undo//
set noswapfile                  " Don't use swapfile

" "Prefer to use undo files atm 5/2017 ... might turn it back on
set backup
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set writebackup

" ----------------------------------------------------------------------------
"  Completion 
" ----------------------------------------------------------------------------
"let g:completor_gocode_binary = '~/go/bin/gocode'
"let g:go_gocode_unimported_packages = 1
"let g:ale_open_list = 1
"let g:ale_lint_on_text_changed = 'never'
"nnoremap <F7> :ALEToggle<cr>
set wildmode=list:longest,list:full
set wildmenu                    " Visual autocomplete for command menu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set wildignorecase              " Ignore case when completing file names and directories.

" ----------------------------------------------------------------------------
"  Colors 
" ----------------------------------------------------------------------------
set background=dark
"colorscheme badwolf    "golang cli
"colorscheme ir_dark_gray    "golang cli
"colorscheme ir_black    "golang cli
"colorscheme monokai_curs    "golang cli
colorscheme Tomorrow-Night-Bright

" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"make git diff / log coloring static
hi diffAdded   ctermfg=green
hi diffRemoved ctermfg=red
if &diff
        highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
        highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
        highlight DiffText term=reverse cterm=bold ctermbg=red ctermfg=black
        highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
endif

" Highlight trailing whitespace characters
:highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Show matching brackets.
set showmatch                   " Highlight matching [{()}]
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Highlights if your typing past column 80
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn','\%81v',100)

" ----------------------------------------------------------------------------
"  Custom Settings 
" ----------------------------------------------------------------------------
"move by lines on screen, instead of linenumber
nnoremap j gj
nnoremap k gk
nnoremap <up> gk
nnoremap <down> gj
"recenter screen on cursor when changing lines
"nnoremap j gjzz
"nnoremap k gkzz

" view buffer list
nnoremap <leader>b :buffers <cr>

" open file explorer
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>x :Sex<CR>

" Open directory of current file
nnoremap <leader>f :w!<cr>:e %:h<cr>

" Karabiner-Eleements, use Fkeys as standard function keys
" Insert timestamp
nnoremap <S-F5> :pu=strftime('%c')<cr>kddm`yypVr=``jo<cr>

" Insert timestamp
nnoremap <F5> :read!date<cr>kddA - 
"nnoremap <F5> :pu=strftime('%c')<cr>kddA - 

" Spell check
nnoremap <leader><F7> :set spell!<cr>

" Force quit
nnoremap <leader>q :q!<cr>

" Write file
nnoremap <leader>w :w<cr>

" Write + quit
nnoremap <leader>z :wq!<cr>

" Remap pop
nnoremap g[ :pop<cr>

"Equalize height and width of all windows
nnoremap <silent> <leader>= <C-W>=
"Ctrl+W +/-: increase/decrease height (ex. 20<C-w>+)
"Ctrl+W >/<: increase/decrease width (ex. 30<C-w><)
"Ctrl+W _: set height (ex. 50<C-w>_)
"Ctrl+W |: set width (ex. 50<C-w>|)
"Ctrl+W =: equalize width and height of all windows
" :help CTRL-W

" open help window vertically
autocmd FileType help wincmd L

" only for diff mode/vimdiff
if &diff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif

"http://vim.wikia.com/wiki/Avoid_the_escape_key
"exit insert using C-space
"nnoremap <C-@> a
"imap <C-@> <Esc>
"https://vim.fandom.com/wiki/Best_Vim_Tips
"Basic use
"<Esc> is the escape key or use <ctrl>[  sometimes written as  <C-[>

"Switch windows
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j

"Switch windows
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"resize windows
nnoremap <C-=> <C-w>+
nnoremap <C--> <C-w>-
nnoremap <D-LEFT> <C-W><
nnoremap <D-RIGHT> <C-W>>

"go specific stuffs
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0
nnoremap <C-G> :! go run %<CR>
nnoremap <C-F> gg ''

"Toggle line nums + relative nums on / off
nnoremap <silent><leader>n :set nu! rnu! nu? rnu? <cr><cr>
nnoremap <silent><leader>h :set hls! hls? <cr>

"Open / reload VIMRC
nnoremap <silent> <leader>eb :e ~/.bashrc<CR>
nnoremap <silent> <leader>es :e ~/.ssh/config<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

"Toggle rainbow parens on / off
nnoremap <silent><leader>R :RainbowParenthesesToggle<cr>
if exists("g:btm_rainbow_color") && g:btm_rainbow_color
    call rainbow_parenthsis#LoadSquare ()
    call rainbow_parenthsis#LoadRound ()
    call rainbow_parenthsis#Activate ()
endif

cnoreabbrev Ack Ack!
nnoremap <Leader>g :Ack!<Space>

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" searchs for word under cursor
nnoremap <Leader>8        :Ack! "\b<cword>\b" <CR>

" Loads the session from the current directory if, and only if, no file names
" were passed in via the command line.
function! LoadSession()
    if argc() == 0
        "source .session.vim
        "was getting -- E117: Unknown function: LoadFile
        exe LoadFile(".session.vim")
    endif
endfunction

"Found in samwho github
" Source a given file or fail out.
function! LoadFile(filename)
    let FILE=expand(a:filename)
    if filereadable(FILE)
        exe "source " FILE
    else
        " echo "Can't source " FILE
    endif
endfunction

" Auto session management commands
autocmd! VimLeave * mksession! .session.vim
autocmd! VimEnter * :call LoadSession()


"set cursorline  " have a line indicate cursor location
" Quick select whole file
map <leader>a ggVG

" Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gvdiff master<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
 "}

" Open go doc in vertical window or horizontal
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>


"yank until end of line
" Act like D and C
nnoremap Y y$

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"====[ I'm sick of typing :%s/.../.../g ]=======
nnoremap S :%s//gc<LEFT><LEFT><LEFT>

" Scratch {{{

command! ScratchToggle call ScratchToggle()

function! ScratchToggle()
    if exists("w:is_scratch_window")
        unlet w:is_scratch_window
        exec "q"
    else
        exec "normal! :Sscratch\<cr>\<C-W>L"
        let w:is_scratch_window = 1
    endif
endfunction

nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}


" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so screw it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
nnoremap <silent> # :let stay_star_view = winsaveview()<cr>#:call winrestview(stay_star_view)<cr>

" F@$% you, help key.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" File browser style configs
let g:netrw_liststyle=0         " Thin (change to 3 for tree)
let g:netrw_banner=0            " No banner
let g:netrw_altv=1              " Open files on right
let g:netrw_preview=1           " Open previews vertically

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" Custom statusline
" ----------------------------------------------------------------------------
if has('statusline')
    set laststatus=2                " Always display statusline

    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=%{fugitive#statusline()} "  Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=%=%-14.(%=\:b%n%y%m%r%w\ %l,%c%V%)\ %p%%  " Right aligned file nav info
    "vimmortal statusline - meh
    "set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][vimmortal!]
    "chris hunt

    set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
endif
" provide hjkl movements in Insert mode via the <Alt> modifier key
" MacOS alternate characters - https://stackoverflow.com/questions/5379837/is-it-possible-to-mapping-alt-hjkl-in-insert-mode
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
imap ˙ <Left>
imap ∆ <Down>
imap ˚ <Up>
imap ¬ <Right>

" Pandoc and Notes {{{2
command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt
"nnoremap <leader>[ :Ngrep
nnoremap <C-n> :cnext<cr>z.
nnoremap <C-p> :cprev<cr>z.
hi! link QuickFixLine Search
" Steve Losh
noremap H ^
noremap L g_

" ----------------------------------------------------------------------------
" Below configs are works in progress
" ----------------------------------------------------------------------------

" Inserting blank lines
" " I never use the default behavior of <cr> and this saves me a keystroke...
"
" Enabling this newline shortcut breaks ack search w/ jumping to file
"nnoremap <cr> o<esc>

" remap pop, conflicted with c-t
"nnoremap <C-[> :pop<CR>

" List contents of all registers (that typically contain pasteable text).
" https://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers
" usage "<register number> <action>
"nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>
"nnoremap <silent> "" :RegbufOpen <CR>
"nnoremap <silent> "" :registers <CR>
"nnoremap <silent><leader>L :LOTRToggle<cr>
"nnoremap <silent><leader>L :LOTRToggle<cr>

"autocmd TextYankPost :vsplit 
"autocmd TextYankPost * call RegbufOpen
