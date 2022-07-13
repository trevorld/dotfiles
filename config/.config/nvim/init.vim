" Useful Settings
" Note neovim sets a lot of stuff by default: https://neovim.io/doc/user/vim_diff.html#nvim-defaults
set nobackup		" do not keep a backup file
set diffopt+=iwhite     " ignore whitespace when diffing
set expandtab           " insert spaces instead of tabs
set ignorecase          " ignore cases while searching
set maxmempattern=2000000 " solves error message
set number              " show line numbers
set shell=/bin/bash
set shiftwidth=4        " tabs will insert 4 spaces
set spell
set scs                 " don't ignore case if enter uppercase letters
set vb                  " set visual beep

" Useful maps
" scroll down file with spacebar
map <space> <c-f>
" Don't use Ex mode, use Q for formatting
map Q gq

" Useful commands
com! Kwbd enew|bw #|bp
com! Undiff set nodiff | set noscrollbind | set foldcolumn=0

" Configure plugins
let R_assign = 0

let g:Tex_SmartQuoteOpen = '"'
let g:Tex_SmartQuoteClose = '"'
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "okular"

let g:riv_fold_auto_update = 0

let g:rainbow_active = 1

if filereadable(".lintr")
  let g:ale_r_lintr_options = join(readfile('.lintr'))
else
  let g:ale_r_lintr_options = "with_defaults(infix_spaces_linter=NULL, line_length_linter(120))"
endif

" Useful Autocommands
if has("autocmd")

  " Enable file type detection,  Use the default filetype settings
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  augroup myAUTOCMDs
    au!
    autocmd BufRead,BufNewFile,BufEnter *.{R,r} set filetype=r
    au BufWritePre *.{py,R,r} %s/\s\+$//e " Remove trailing whitespace
  augroup END

  augroup vimrcEx
    au!
    autocmd FileType text setlocal textwidth=79  " Set text file width to 79
    set formatoptions=1
    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
    autocmd BufEnter * cd %:p:h " automatically change directories to the file's directory
  augroup END

endif 
