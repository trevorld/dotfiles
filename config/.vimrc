" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Useful Settings
set nocompatible " Use Vim settings instead of Vi, must be first
" set autoread            " Refresh buffer if file modified externally
set backspace=indent,eol,start " allows backspacing in insert mode
set nobackup
set diffopt+=iwhite     " ignore whitespace when diffing
set expandtab           " insert spaces instead of tabs
set history=50		" keep 50 lines of command line history
set ignorecase          " ignore cases while searching
set incsearch		" do incremental searching
set maxmempattern=2000000 " solves error message
set number              " show line numbers
set ruler		" show the cursor position all the time
set shell=/bin/bash
set shiftwidth=4        " tabs will insert 4 spaces
set showcmd		" display incomplete commands
set spell
set scs                 " don't ignore case if enter uppercase letters
set smarttab            " insert spaces instead of tabs
set vb                  " set visual beep

if &t_Co > 2 || has("gui_running")
  syntax on             " syntax highlighting when terminal has colors
  set hlsearch          " switch highlighting on last used search partern
endif
" assume if vim is called that background is dark
if &t_Co > 2 && !has("gui_running")
  set background=dark
  set hlsearch          " switch highlighting on last used search partern
endif

" greater XDG compliance
if !has("nvim")
    set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
endif

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


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Useful maps
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" scroll down file with spacebar
map <space> <c-f>
" Turn english spell check
map <Leader>en :setlocal spell spelllang=en_us
" Turn esperanto spell check
map <Leader>eo :setlocal spell spelllang=eo_XX

map <Leader>k <C-W>k:bd<Enter>
map <Leader>j <C-W>j:bd<Enter>

" useful maps for Rnoweb files to switch between Latex-suite and vim-r-plugin
map <Leader>r :set filetype=r<CR>:set syntax=rnoweb<CR>
map <Leader>t :set filetype=tex<CR>:set syntax=rnoweb<CR>

" useful to spread spaces
map <Leader>s i<space><Esc>la<space><Esc>h

" useful maps for writing Re-Structured Text
if has("python")
    map <Leader>- :call Section_Header('-', "below")<Enter>
    map <Leader>_ :call Section_Header('-', "above_below")<Enter>
    map <Leader>` :call Section_Header('~', "below")<Enter>
    map <Leader>~ :call Section_Header('~', "above_below")<Enter>
    map <Leader>= :call Section_Header('=', "below")<Enter>
    map <Leader>+ :call Section_Header('=', "above_below")<Enter>
elseif has("autocmd")
    au Bufenter *.{Rst,rst,RST} map <Leader>- yyp:s/./-/g<Enter>:highlight clear Search<Enter>
    au Bufenter *.{Rst,rst,RST} map <Leader>~ yyp:s/./\~/g<Enter>:highlight clear Search<Enter>
    au Bufenter *.{Rst,rst,RST} map <Leader>= yyp:s/./=/g<Enter>:highlight clear Search<Enter>
    au BufEnter *.{R,pl,py,sh} map <Leader>= yyp:s/./=/g<Enter>:highlight clear Search<Enter>0xxi##<Esc>
    au BufEnter *.{R,pl,py,sh} map <Leader>- yyp:s/./-/g<Enter>:highlight clear Search<Enter>0xxi##<Esc>
    au BufEnter *.{R,pl,py,sh} map <Leader>~ yyp:s/./\~/g<Enter>:highlight clear Search<Enter>0xxi##<Esc>
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Useful commands
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
com! Kwbd enew|bw #|bp
com! Undiff set nodiff | set noscrollbind | set foldcolumn=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Useful Autocommands
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Only do this part when compiled with support for autocommands.
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

else

  set autoindent		" always set autoindenting on

endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" custom Latex-Suite style mappings and settings for my Rnoweb and Latex files
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if exists("*IMAP") && has("autocmd") 
  augroup MyIMAPs
    au!
    au VimEnter * call IMAP('<<', "<<<++>>>=\<CR><++>\<CR>@\<CR><++>", "rnoweb")
    au VimEnter * call IMAP('<<', "<<<++>>>=\<CR><++>\<CR>@\<CR><++>", "tex")
    au VimEnter * call IMAP('@@', "@\<CR><++>\<CR><<<++>>>=", "tex")
    au VimEnter * call IMAP('@@', "@\<CR><++>\<CR><<<++>>>=", "rnoweb")
    au VimEnter * call IMAP('--', " <- ", "r")
    au VimEnter * call IMAP('--', " <- ", "rhelp")
    au VimEnter * call IMAP('--', " <- ", "rnoweb")
    au VimEnter * call IMAP('`V', "\text{Var}", "tex")
    "let us use the Math BF plugin instead of opening the Buffer menu
    autocmd BufWinEnter *.tex imap <C-B> <Plug>Tex_MathBF
    autocmd BufWinEnter *.Rnw imap <C-B> <Plug>Tex_MathBF
  augroup END

  "IMPORTANT: grep will sometimes skip displaying the file name if you
  "search in a single file. This will confuse latex-suite.  Set your grep
  "program to always generate a file-name.
  set grepprg=grep\ -nH\ $*

  " convert \times to \cdot easily
  map <Leader>. :% s/\\times/\\cdot/g<CR>
  map <Leader>b :% s/mathbf/mathbb/g<CR>
  map <Leader>B :% s/mathbb/mathbf/g<CR>

endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Custom functions
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has("python")

function! Section_Header(section_char, type)
python << EOF
import re
import vim
section_char = vim.eval('a:section_char') # non-alphanumeric character: i.e. '-'
type         = vim.eval('a:type')         # either "below" or "above_below"
line = vim.current.line
row = vim.current.window.cursor[0] - 1 # python index starts at zero
length_line = len(line)
if not length_line:
    raise ValueError("Line must have a length greater than zero")
#### check section_char
if re.match('\w', section_char):
    raise ValueError("The first argument, section_char," + \
                     "must be a non-alphanumeric character")
starting_whitespace = re.split('\S', line)[0]
length_whitespace = len(starting_whitespace)
if length_whitespace:
    first_non_whitespace_characters = re.split('\s*', line)[1]
else:
    first_non_whitespace_characters = re.split('\s*', line)[0]
first_char = first_non_whitespace_characters[0]
try: 
    second_char = first_non_whitespace_characters[1]
except:
    second_char = ' '              # assume the second character was a space

if re.match('\w', first_char):     # starts with alphanumeric character
    length_section = length_line - length_whitespace
    header_line = starting_whitespace + (section_char * length_section)
else:                              # does not start with alphanumeric character
    length_section = length_line - length_whitespace - 2
    header_line = starting_whitespace + first_char + second_char + \
                 (section_char * length_section)
print(header_line)
## detect if line above and below start with ``comment``
del vim.current.buffer[row]
if type=="below":
    vim.current.buffer[row:row] = [line, header_line]
elif type=="above_below":
    vim.current.buffer[row:row] = [header_line, line, header_line]
else:
    raise ValueError('The 2nd argument, type, \
                     must either be "below" or "above_below"')
EOF
endfunction

function! VerticalLetters(...)
python << endpython
import re, string, vim
nArgs = int(vim.eval("a:0"))
if nArgs > 0:
    nLines = int(vim.eval("a:1"))
else:
    nLines = 1
if nArgs > 1:
    use_upper_case = int(vim.eval("a:2"))
else:
    use_upper_case = 0
if nArgs > 2:
    if use_upper_case:
        start = re.search(vim.eval("a:3"), string.ascii_uppercase).start()
    else:
        start = re.search(vim.eval("a:3"), string.ascii_lowercase).start()
else:
    start = 0

nColumns = 1
current_line = vim.current.window.cursor[0] - 1
current_column = vim.current.window.cursor[1]
for ii in range(nLines):
    row = current_line + ii
    number = ii + start
    line = vim.current.buffer[row]
    if use_upper_case:
        myline = line[:current_column] + string.ascii_uppercase[number] + line[current_column+nColumns:]
    else:
        myline = line[:current_column] + string.ascii_lowercase[number] + line[current_column+nColumns:]
    vim.current.buffer[row] = myline

endpython
endfunction

function! VerticalNumbers(...)
python << endpython
import vim
nArgs = int(vim.eval("a:0"))
if nArgs > 0:
    nLines = int(vim.eval("a:1"))
else:
    nLines = 1

if nArgs > 1:
    nColumns = int(vim.eval("a:2"))
else:
    nColumns = 1

if nArgs > 2:
    start = int(vim.eval("a:3"))
else:
    start = 1

current_line = vim.current.window.cursor[0] - 1
current_column = vim.current.window.cursor[1]
for ii in range(nLines):
    row = current_line + ii
    number = (("%." + "%d" % nColumns) + "d") % (start + ii)
    line = vim.current.buffer[row]
    myline = line[:current_column] + number + line[current_column+nColumns:]
    vim.current.buffer[row] = myline

endpython
endfunction
endif
