" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'raimondi/delimitmate'
"Plugin 'ervandew/supertab'
"Plugin 'sheerun/vim-polyglot'
"Plugin 'lervag/vimtex'
"Plugin 'neoclide/coc.nvim'
"Plugin 'KeitaNakamura/tex-conceal.vim'

"VIM-PLUG SETTINGS
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim'
Plug 'keitanakamura/tex-conceal.vim'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'
Plug 'davidhalter/jedi-vim'
Plug 'plasticboy/vim-markdown'
call plug#end()

"Delimitmate
let delimitMate_expand_cr=1 

"Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

"Vimtex
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal_frac=1
let g:tex_conceal='abdmg'
let g:vimtex_view_method='skim'
let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_skim_activate=1

"Ultisnips
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips']
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Mappings for compiling Latex file
autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pdf %<CR>
"autocmd FileType tex nmap <buffer> <C-T> :!rubber --pdf --force --short %<CR>
autocmd FileType tex nmap <buffer> T :!open -a Skim %<.pdf %<.pdf<CR><CR>

let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'


" for youcompleteme
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
  au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme


"SET BASH
set shell=/bin/bash

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile        " keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au! 

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END 

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"JAE's SETTINGS
" Buffer switching using Cmd-arrows in Mac and Alt-arrows in Linux
:nnoremap <D-Right> :bnext<CR>
:nnoremap <M-Right> :bnext<CR>
:nnoremap <D-Left> :bprevious<CR>
:nnoremap <M-Left> :bprevious<CR>
" and don't let MacVim remap them
if has("gui_macvim")
   let macvim_skip_cmd_opt_movement = 1 
endif

"Line numbers
set number
set shiftwidth=4

set expandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=76 spell spelllang=en_us

"Cleanup things
set backupdir^=~/.backup
set undodir^=~/.undodir

set dir^=~/.backup//

set ignorecase
nnoremap <c-n> @="m`o\eg``"<cr>
nnoremap <c-p> @="m`O\eg``"<cr>

filetype plugin indent on

syntax on
hi Conceal ctermbg=NONE
hi Conceal ctermfg=NONE
hi Conceal guifg=NONE
hi Conceal guibg=NONE

autocmd FileType latex,tex,md,markdown setlocal spell
set clipboard=unnamed

"switch cursor
:autocmd InsertEnter,InsertLeave * set cul!

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

