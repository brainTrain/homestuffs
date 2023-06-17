nmap H ^
nmap L $

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

endif

set hlsearch

function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<CR>

set et
set sw=4
set ts=4
set nu

syntax on
set ruler

nmap <SPACE> <SPACE>:noh<CR>

set autoindent
set backspace=indent,eol,start

" new stuffs from this nerd
" https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**
set wildignore+=**/node_modules/**
set wildignore+=**/env/**
set wildmenu
set nocompatible

" setting for vim-prettier, assumes you have it installed
" if using vim8 or later you can add https://github.com/prettier/vim-prettier to
" ~/.vim/pack/prettier/start/ using git clone and run npm or yarn install after
let g:prettier#autoformat = 0 
autocmd BufWritePre *.ts,*.tsx,*.jsx,*.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync

" sonic pi commands for viiiiimmmmmm \\\\o////
" need sonic pi and sonic-pi-cli installed
let mapleader = ";" 

noremap <leader>r :silent w !sonic_pi<CR>
noremap <leader>s :call system("sonic_pi stop")<CR>

" custom statusline pared down from:
" https://shapeshed.com/vim-statuslines/ 

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
" runs Black (python auto formatter) on save
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end 
" using preview mode for Black 23.3.0 so we can get
" some string length too long formatting for free
let g:black_preview = 1 
