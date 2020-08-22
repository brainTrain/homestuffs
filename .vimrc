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
