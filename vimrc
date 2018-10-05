"Vimrc

":! go run % -d=debug
" Type :so % to refresh .vimrc after making changes
" :vsp | b1 - vertcal split buffer #
" :reg
" :find <regex>
" :Explore
" :Vexplore
" :b <regex>
" :args /<path to directory>/* open multiple files at once, after you're inside vim
" vim ** from command line will open all files recursively (-o[N] -O[N] limits the number of splits)
" vim ./* ./*/* - open recursively, 1 dir deep
" C-v , arrow down, shift+i , then type, then esc (to add text to multiple lines
" How many lines in vimrc (grep -v '^\s*"' ~/.vimrc | grep -v "^$"|wc -l)

"=======================vimplug=======================
" For Mac/Linux users
call plug#begin('~/.vim/bundle')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'mileszs/ack.vim'
Plug 'EinfachToll/DidYouMean'
Plug 'zhaocai/minibufexpl.vim'
Plug 'tyru/regbuf.vim'
Plug 'dahu/vim-lotr'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/scratch.vim'
call plug#end()


"=======================endplug=======================
"Execute pathogen plugins
"execute pathogen#infect()
syntax on                       " Syntax hi-lighting
set syntax=enable
filetype plugin indent on       " Turn on filetype detection, plugin and indent.vim's into runtimepath
set nocompatible                " Ignore's vi compatablity

"set term=screen-256color       " Defined in .screenrc
"set term=xterm-256color        " Defined in .bashrc
"set title
"=======================colors=======================
set background=dark
"colorscheme gruvbox
"colorscheme xoria256
"colorscheme vombatidae
"colorscheme slate
"colorscheme SlateDark
"colorscheme vividchalk
"colorscheme distinguished
"colorscheme monokai
"colorscheme znake
"colorscheme vibrantink
"colorscheme molokai
"colorscheme  256-grayvim
"colorscheme  ir_dark_gray  "same as ir_black

"colorscheme ir_black

"colorscheme woju
"colorscheme vimbrant
"colorscheme sorcerer
colorscheme monokai_curs    "golang cli
"colorscheme badwolf
"colorscheme dracula
"colorscheme Tomorrow-Night-Bright
"colorscheme smyck


"=======================me-from-random=======================
"move by lines on screen, instead of linenumber
nnoremap j gj
nnoremap k gk
nnoremap <up> gk
nnoremap <down> gj

"Equalize height and width of all windows
nnoremap <silent> <leader>= <C-W>=
"Ctrl+W +/-: increase/decrease height (ex. 20<C-w>+)
"Ctrl+W >/<: increase/decrease width (ex. 30<C-w><)
"Ctrl+W _: set height (ex. 50<C-w>_)
"Ctrl+W |: set width (ex. 50<C-w>|)
"Ctrl+W =: equalize width and height of all windows
" :help CTRL-W

"nnoremap <C-[> :pop<CR>
set nowrap
set nofoldenable

"autocmd BufRead * silent! :%foldopen!
"
" only for diff mode/vimdiff
if &diff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif

" List contents of all registers (that typically contain pasteable text).
" https://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers
" usage "<register number> <action>
"nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>
"nnoremap <silent> "" :RegbufOpen <CR>
nnoremap <silent> "" :registers <CR>
"nnoremap <silent><leader>L :LOTRToggle<cr>
"nnoremap <silent><leader>L :LOTRToggle<cr>

"autocmd TextYankPost :vsplit 
"autocmd TextYankPost * call RegbufOpen

"http://vim.wikia.com/wiki/Avoid_the_escape_key
"exit insert using C-space
nnoremap <C-@> a
imap <C-@> <Esc>

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

"set clipboard^=unnamed           " Attempt to use MacOS system clipboard ( not working )
set clipboard=unnamedplus
"set clipboard=unnamedplus,unnamed,autoselect
set pastetoggle=<F2>            " This prevents Vim from auto-indenting the pasted code

set wildignorecase              " Ignore case when completing file names and directories.

set relativenumber              " Show relateive line numbers
set number                      " Show line numbers

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

set shiftwidth=4                " Control how many columns text is indented with the reindent operations (<< and >>)
"=======================statico=======================
nnoremap <Leader>8        :Ack! "\b<cword>\b" <CR>
"=======================samwho=======================
" Loads the session from the current directory if, and only if, no file names
" were passed in via the command line.
function! LoadSession()
    if argc() == 0
        "source .session.vim
        "was getting -- E117: Unknown function: LoadFile
        exe LoadFile(".session.vim")
    endif
endfunction

"Found in his github
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
"=======================cjhveal=======================
"set cursorline  " have a line indicate cursor location
" Quick select whole file
map <leader>a ggVG
"=======================Junegunn=======================
nnoremap g[ :pop<cr>
" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

"=======================George Ornbo=======================
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
      "autocmd!
      "autocmd VimEnter * :Vexplore
"augroup ENh
"=======================tpope=======================
"vim-vinegar ignore hidden files
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
set diffopt+=vertical           "open diffs vertically by default
"=======================snow-dev=======================

let g:ctrlp_map = '<C-p>' 
let g:ctrlp_cmd = 'CtrlP'

nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>x :Sex<CR>

"=======================devinrm/thottbot=======================
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
"function! InsertTabWrapper()
    "let col = col('.') - 1
    "if !col || getline('.')[col - 1] !~ '\k'
        "return "\<tab>"
    "else
        "return "\<c-p>"
    "endif
"endfunction
"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <S-Tab> <c-n>

" . scan the current buffer, b scan other loaded buffers that are in the buffer list, u scan the unloaded buffers that 
" are in the buffer list, w scan buffers from other windows, t tag completion
"set complete=.,b,u,w,t,]

" Keyword list
"set complete+=k
"set complete+=k~/.vim/keywords.txt
"=======================trishume=======================
" set autowrite                  " automatically write a file when leaving a modified buffer
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload
"set ruler
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
" %< Where to truncate
" " %n buffer number
" " %F Full path
" " %m Modified flag: [+], [-]
" " %r Readonly flag: [RO]
" " %y Type:          [vim]
" " fugitive#statusline()
" " %= Separator
" " %-14.(...)
" " %l Line
" " %c Column
" " %V Virtual column
" " %P Percentage
" " %#HighlightGroup#
 "set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
 
if has('statusline')
    set laststatus=2

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

" Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gvdiff master<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
 "}
"=======================skwp=======================
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom

"=======================stephpy=======================
"au BufNewFile,BufRead *.yaml,*.yml
"=======================Syntastic======================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*%F\ %l\:%c       " Ruler replacement

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
"=======================connermcd======================
"set spelllang=eng
" Open directory of current file
nnoremap <leader>f :w!<cr>:e %:h<cr>
" Spell check
nnoremap <leader><F7> :set spell!<cr>
" Force quit
nnoremap <leader>q :q!<cr>
" Write file
nnoremap <leader>w :w<cr>
" Write + quit
nnoremap <leader>z :wq!<cr>
"=======================Coolaj86======================
" Open go doc in vertical window or horizontal
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
"=======================Doug black======================
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces

" move to beginning/end of line
"nnoremap B ^
"nnoremap E $

"jk is escape
"inoremap jk <esc>
"=======================Victor Engmark======================
" Show (partial) command in status line
"set showcmd

" Show matching brackets.
set showmatch                   " Highlight matching [{()}]
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Highlight trailing whitespace characters
:highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"=======================amix vim=======================
set lazyredraw                  " Redraw only when we need to.
set magic                       " Set magic on, for regex

"=======================mcantor=======================
set path+=**                    " For clever completion with the :find command
"set wildmenu                    " Visual autocomplete for command menu
"set ls=2
"set statusline=%F
"set statusline=%F\ %l\:%c       " Ruler replacement
set laststatus=2                " Always display statusline
let g:netrw_liststyle=0         " Thin (change to 3 for tree)
let g:netrw_banner=0            " No banner
let g:netrw_altv=1              " Open files on right
let g:netrw_preview=1           " Open previews vertically

"=======================jfrazelle=======================
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
"set nobackup                    " Don't create annoying backup files
set nowritebackup               " Changes the default 'save' behavior of Vim, to write buffers direct to file

"yank until end of line
" Act like D and C
nnoremap Y y$

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"=======================nicknisi=======================
set history=10000                " How many commands vim will save
set ttyfast                     " faster redrawing

"=======================damian-conway=======================
"nnoremap : ;
"nnoremap ; :

" Highlights if your typing past column 80
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn','\%81v',100)
"set colorcolumn=72

"" Make naughty characters visible...
" " (uBB is right double angle, uB7 is middle dot)
"set listchars=nbsp:~,trail:.
set listchars=extends:>,precedes:<
"set list

"====[ I'm sick of typing :%s/.../.../g ]=======
"
nnoremap S :%s//gc<LEFT><LEFT><LEFT>

"====[ Set up smarter search behaviour ]=======================
"
set incsearch                   " Lookahead as search pattern is specified
set ignorecase                  " Ignore case in all searches...
set smartcase                   " Unless uppercase letters used

set hlsearch                   " Highlight matches

"=======================benjamin g=========================

"bigger cursor movements
"nnoremap <C-j> 10j
"nnoremap <C-k> 10k

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
nnoremap <C-G> :! go run %<CR>
nnoremap <C-F> gg ''

"=================stevelosh================
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
"nnoremap <leader>A :Ack! '\b<c-r><c-w>\b'<cr>
" Ack {{{

"nnoremap <leader>a :Ack!<space>
"let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'

" }}}
"Switch windows
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j

" Copies current line and puts a line of '=' below it of equal length
nnoremap <leader>1 yypVr=

 " Persistent undo
set undofile
set undodir=~/.vim/tmp/undo//
set noswapfile                  " Don't use swapfile
"Prefer to use undo files atm 5/2017 ... might turn it back on
set backup
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set writebackup

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

" Make Vim able to edit crontab files again.
"set backupskip=/tmp/*,/private/tmp/*"

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
nnoremap <silent> # :let stay_star_view = winsaveview()<cr>#:call winrestview(stay_star_view)<cr>

" Set jj to escape
"inoremap jj <ESC>

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

" F@$% you, help key.
autocmd FileType help wincmd L
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" Inserting blank lines
" " I never use the default behavior of <cr> and this saves me a keystroke...
"
" Enabling this newline shortcut breaks ack search w/ jumping to file
"nnoremap <cr> o<esc>
set modifiable

"=================witzel3================
nnoremap <leader>b :buffers <cr>
":Files was for fzf integration
"=================Sam Rowe================
" ===================================================================
" ASCII tables - you may need them some day.  Save them to a file!
" ===================================================================
"
" ASCII Table - | octal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |010 bs |011 ht |012 nl |013 vt |014 np |015 cr |016 so |017 si |
" |020 dle|021 dc1|022 dc2|023 dc3|024 dc4|025 nak|026 syn|027 etb|
" |030 can|031 em |032 sub|033 esc|034 fs |035 gs |036 rs |037 us |
" |040 sp |041  ! |042  " |043  # |044  $ |045  % |046  & |047  ' |
" |050  ( |051  ) |052  * |053  + |054  , |055  - |056  . |057  / |
" |060  0 |061  1 |062  2 |063  3 |064  4 |065  5 |066  6 |067  7 |
" |070  8 |071  9 |072  : |073  ; |074  < |075  = |076  > |077  ? |
" |100  @ |101  A |102  B |103  C |104  D |105  E |106  F |107  G |
" |110  H |111  I |112  J |113  K |114  L |115  M |116  N |117  O |
" |120  P |121  Q |122  R |123  S |124  T |125  U |126  V |127  W |
" |130  X |131  Y |132  Z |133  [ |134  \ |135  ] |136  ^ |137  _ |
" |140  ` |141  a |142  b |143  c |144  d |145  e |146  f |147  g |
" |150  h |151  i |152  j |153  k |154  l |155  m |156  n |157  o |
" |160  p |161  q |162  r |163  s |164  t |165  u |166  v |167  w |
" |170  x |171  y |172  z |173  { |174  | |175  } |176  ~ |177 del|
"
" ===================================================================
" ASCII Table - | decimal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |008 bs |009 ht |010 nl |011 vt |012 np |013 cr |014 so |015 si |
" |016 dle|017 dc1|018 dc2|019 dc3|020 dc4|021 nak|022 syn|023 etb|
" |024 can|025 em |026 sub|027 esc|028 fs |029 gs |030 rs |031 us |
" |032 sp |033  ! |034  " |035  # |036  $ |037  % |038  & |039  ' |
" |040  ( |041  ) |042  * |043  + |044  , |045  - |046  . |047  / |
" |048  0 |049  1 |050  2 |051  3 |052  4 |053  5 |054  6 |055  7 |
" |056  8 |057  9 |058  : |059  ; |060  < |061  = |062  > |063  ? |
" |064  @ |065  A |066  B |067  C |068  D |069  E |070  F |071  G |
" |072  H |073  I |074  J |075  K |076  L |077  M |078  N |079  O |
" |080  P |081  Q |082  R |083  S |084  T |085  U |086  V |087  W |
" |088  X |089  Y |090  Z |091  [ |092  \ |093  ] |094  ^ |095  _ |
" |096  ` |097  a |098  b |099  c |100  d |101  e |102  f |103  g |
" |104  h |105  i |106  j |107  k |108  l |109  m |110  n |111  o |
" |112  p |113  q |114  r |115  s |116  t |117  u |118  v |119  w |
" |120  x |121  y |122  z |123  { |124  | |125  } |126  ~ |127 del|
"
" ===================================================================
" ASCII Table - | hex value - name/char |
"
" | 00 nul| 01 soh| 02 stx| 03 etx| 04 eot| 05 enq| 06 ack| 07 bel|
" | 08 bs | 09 ht | 0a nl | 0b vt | 0c np | 0d cr | 0e so | 0f si |
" | 10 dle| 11 dc1| 12 dc2| 13 dc3| 14 dc4| 15 nak| 16 syn| 17 etb|
" | 18 can| 19 em | 1a sub| 1b esc| 1c fs | 1d gs | 1e rs | 1f us |
" | 20 sp | 21  ! | 22  " | 23  # | 24  $ | 25  % | 26  & | 27  ' |
" | 28  ( | 29  ) | 2a  * | 2b  + | 2c  , | 2d  - | 2e  . | 2f  / |
" | 30  0 | 31  1 | 32  2 | 33  3 | 34  4 | 35  5 | 36  6 | 37  7 |
" | 38  8 | 39  9 | 3a  : | 3b  ; | 3c  < | 3d  = | 3e  > | 3f  ? |
" | 40  @ | 41  A | 42  B | 43  C | 44  D | 45  E | 46  F | 47  G |
" | 48  H | 49  I | 4a  J | 4b  K | 4c  L | 4d  M | 4e  N | 4f  O |
" | 50  P | 51  Q | 52  R | 53  S | 54  T | 55  U | 56  V | 57  W |
" | 58  X | 59  Y | 5a  Z | 5b  [ | 5c  \ | 5d  ] | 5e  ^ | 5f  _ |
" | 60  ` | 61  a | 62  b | 63  c | 64  d | 65  e | 66  f | 67  g |
" | 68  h | 69  i | 6a  j | 6b  k | 6c  l | 6d  m | 6e  n | 6f  o |
" | 70  p | 71  q | 72  r | 73  s | 74  t | 75  u | 76  v | 77  w |
" | 78  x | 79  y | 7a  z | 7b  { | 7c  | | 7d  } | 7e  ~ | 7f del|
" ===================================================================
"noh
" =======================kring ag====================================
"set runtimepath^=~/.vim/bundle/ag
set runtimepath^=~/.vim/bundle/ctrlp.vim
