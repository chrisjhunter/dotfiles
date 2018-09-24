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
" ]n [n or [c ]c for merge conflicts vim-unimpaired or vimdiff, respectively
" :r! echo %
" :echo expand("#2:p")          https://unix.stackexchange.com/questions/320121/how-to-get-the-file-path-of-a-buffer
" :r! echo %:p                  https://unix.stackexchange.com/questions/57555/how-do-i-insert-the-current-filename-into-the-contents-in-vim

"Execute pathogen plugins
execute pathogen#infect()
syntax on                       " Syntax hi-lighting
filetype plugin indent on       " Turn on filetype detection, plugin and indent.vim's into runtimepath

" ----------------------------------------------------------------------------
" Colors
" ----------------------------------------------------------------------------
set background=dark
set term=screen-256color
colorscheme monokai_curs    "golang cli

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

" Highlights if your typing past column 80
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn','\%81v',100)
"set colorcolumn=72

" Highlight trailing whitespace characters
:highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set showmatch                   " Highlight matching [{()}]
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
" ----------------------------------------------------------------------------
" Settings
" ----------------------------------------------------------------------------
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
set syntax=enable
set nocompatible                " Ignore's vi compatablity
set nowrap
set nofoldenable
set pastetoggle=<F2>            " This prevents Vim from auto-indenting the pasted code
set relativenumber              " Show relateive line numbers
set number                      " Show line numbers
set shiftwidth=4                " Control how many columns text is indented with the reindent operations (<< and >>)
set runtimepath^=~/.vim/bundle/ctrlp.vim
set modifiable
set diffopt+=vertical           "open diffs vertically by default
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set lazyredraw                  " Redraw only when we need to.
set magic                       " Set magic on, for regex
set path+=**                    " For clever completion with the :find command
set laststatus=2                " Always display statusline
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set nowritebackup               " Changes the default 'save' behavior of Vim, to write buffers direct to file
set history=10000                " How many commands vim will save
set ttyfast                     " faster redrawing
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload


"" Make naughty characters visible...
" " (uBB is right double angle, uB7 is middle dot)
set listchars=extends:>,precedes:<

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
let g:netrw_liststyle=0         " Thin (change to 3 for tree)
let g:netrw_banner=0            " No banner
let g:netrw_altv=1              " Open files on right
let g:netrw_preview=1           " Open previews vertically

"====[ Set up smarter search behaviour ]=======================
"
set incsearch                   " Lookahead as search pattern is specified
set ignorecase                  " Ignore case in all searches...
set smartcase                   " Unless uppercase letters used
set hlsearch                   " Highlight matches

"Prefer to use undo files atm 5/2017 ... might turn it back on
" Persistent undo
set undofile
set undodir=~/.vim/tmp/undo//

set backup
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set writebackup
set wildmenu                    " Visual autocomplete for command menu
set wildignorecase              " Ignore case when completing file names and directories.
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

" ----------------------------------------------------------------------------
" Remappings
" ----------------------------------------------------------------------------

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
nnoremap <silent> # :let stay_star_view = winsaveview()<cr>#:call winrestview(stay_star_view)<cr>

" Open directory of current file
"nnoremap <leader>f :w!<cr>:e %:h<cr>
" Spell check
nnoremap <leader><F7> :set spell!<cr>
" Force quit
nnoremap <leader>q :q!<cr>
" Write file
nnoremap <leader>w :w<cr>
" Write + quit
nnoremap <leader>z :wq!<cr>

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Open go doc in vertical window or horizontal
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>

"yank until end of line
" Act like D and C
nnoremap Y y$

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"==============ctrl-p ==================
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

"==============file explorer ==================
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>x :Sex<CR>

"==============Fugitive==================
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gvdiff master<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

"====[ I'm sick of typing :%s/.../.../g ]=======
nnoremap S :%s//gc<LEFT><LEFT><LEFT>

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
nnoremap <C-G> :! go run %<CR>
nnoremap <C-T> :! go test<CR>
nnoremap <C-F> gg ''

"go specific stuffs
let g:go_fmt_command = "goimports"

"show buffers
nnoremap <leader>b :buffers <cr>

"move by lines on screen, instead of linenumber
nnoremap j gj
nnoremap k gk
nnoremap <up> gk
nnoremap <down> gj

"Toggle line nums + relative nums on / off
nnoremap <silent><leader>n :set nu! rnu! nu? rnu? <cr><cr>
nnoremap <silent><leader>h :set hls! hls? <cr>

"Open / reload VIMRC
nnoremap <silent> <leader>eb :e ~/.bashrc<CR>
nnoremap <silent> <leader>es :e ~/.ssh/config<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

"Ack settings / shortcuts
cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>
nnoremap <Leader>8        :Ack! "\b<cword>\b" <CR>

" F@$% you, help key.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

"Pop through tags
"nnoremap <C-[> :pop<CR>
nnoremap g[ :pop<cr>

" Copies current line and puts a line of '=' below it of equal length
nnoremap <leader>1 yypVr=

" Markdown headings
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" Quick select whole file
map <leader>a ggVG

" ----------------------------------------------------------------------------
" Functions / 
" ----------------------------------------------------------------------------

" only for diff mode/vimdiff
if &diff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif

" List contents of all registers (that typically contain pasteable text).
" https://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers
" usage "<register number> <action>
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

"http://vim.wikia.com/wiki/Avoid_the_escape_key
"exit insert using C-space
nnoremap <C-@> a
imap <C-@> <Esc>

"Equalize height and width of all windows
"Ctrl+W +/-: increase/decrease height (ex. 20<C-w>+)
"Ctrl+W >/<: increase/decrease width (ex. 30<C-w><)
"Ctrl+W _: set height (ex. 50<C-w>_)
"Ctrl+W |: set width (ex. 50<C-w>|)
"Ctrl+W =: equalize width and height of all windows
" :help CTRL-W
nnoremap <silent> <leader>= <C-W>=

"Toggle rainbow parens on / off
nnoremap <silent><leader>R :RainbowParenthesesToggle<cr>
if exists("g:btm_rainbow_color") && g:btm_rainbow_color
    call rainbow_parenthsis#LoadSquare ()
    call rainbow_parenthsis#LoadRound ()
    call rainbow_parenthsis#Activate ()
endif

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


"vimmortal statusline - meh
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][vimmortal!]
"chris hunt
if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=%{fugitive#statusline()} "  Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=%=%-14.(%=\:b%n%y%m%r%w\ %l,%c%V%)\ %p%%  " Right aligned file nav info

    set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
endif


" Scratch toggle
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
