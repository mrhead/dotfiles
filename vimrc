" Leader
let mapleader = " "

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Color scheme
colorscheme github
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5
set relativenumber

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

imap <S-Tab> <Plug>snipMateNextOrTrigger
smap <S-Tab> <Plug>snipMateNextOrTrigger

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <Leader>t :TestFile<CR>
nnoremap <Leader>s :TestNearest<CR>
nnoremap <Leader>l :TestLast<CR>
nnoremap <Leader>a :TestSuite<CR>
nnoremap <Leader>L :TestVisit<CR>

" Treat <li> and <p> tags like the block tags they are
" TODO fix this, it is not working correctly
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

set hls
set ignorecase
set smartcase

" use ack instead of grep
set grepprg=ack

if filereadable($HOME . "/.vim/vividchalk.vim")
  source ~/.vim/vividchalk.vim
endif

" dependency for textobject ruby block
runtime macros/matchit.vim

" pathogen is needed to automatically execute non vundle plugins (i18n for
" example)
execute pathogen#infect()

" make backspace to work as in other apps
set backspace=indent,eol,start

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" run actual ruby file
noremap <Leader>r :!ruby %<CR>

" uppercase current word in insert mode
inoremap <c-u> <esc>ebviwUi

" uppercase the current word in normal mode
nnoremap <c-u> viwU

" easily edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>R :source $MYVIMRC<cr>

" easily move to the beginning/end of the line
nnoremap H ^
nnoremap L $

" turn spelling on/off
nnoremap <C-S> :set spell! spelllang=en_us<cr>

" easily paste from OS clipboard
nnoremap <leader>p o<esc>"*p

" easily copy to OS clipboard
vnoremap <leader>c "*y

" turn of search highlight
nnoremap <leader>nh :nohlsearch<cr>

" grep current WORD
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" easily highlight some keyword
nnoremap <leader>m :match Keyword 

" open tag in new tab
nnoremap <leader><C-]> <C-w><C-]><C-w>T

" create new directory and save file
nnoremap <leader>w :!mkdir -p %:h<cr>:w<cr>

" format json
nnoremap <leader>j va{:!json<cr>

" bind <ctrl-p> to FZF
nnoremap <C-p> :FZF<cr>

" speedup ruby.vim loading
let g:ruby_path = system('echo $HOME/.rbenv/shims')
