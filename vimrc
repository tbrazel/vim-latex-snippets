" Much of this was borrowed from https://github.com/dicai/dotfiles/blob/master/vimrc

set nocompatible
set encoding=utf-8
colorscheme mod8

if has('python3')
  silent! python3 1
endif

""""""""""""""""""""
" Visual appearance
""""""""""""""""""""

syntax on 					" Enable syntax highlighting
set number					" Show numbers on the left

set fillchars+=vert:\ 		                " Invisible vertical split line.
set lazyredraw				        " Make things faster.

" Status line.
set laststatus=2                                " Always show status line.
set statusline=%F                               " Full path to file.
set statusline+=%(\ [%M%R]%)                    " Modified and readonly flags.
set statusline+=%=                              " Switch to right aligned.
set statusline+=%l/%L                           " Current line / total lines.

" Tabs
set expandtab       		                "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4    		                "Indent by 4 spaces when using >>, <<, == etc.
set cindent         		                "Like smartindent, but stricter and more customisable
set smarttab
set backspace=indent,eol,start

" Wordwrap
set wrap
set linebreak
set breakat=" "

set textwidth=0
set wrapmargin=0

" Search.

" Show matches while searching
set incsearch
set ignorecase
set smartcase

" Don't highlight underscores and other stuff
let g:tex_no_error=1

" Switch buffers without saving.
set hidden

" Tab in command mode displays all completions.
set wildmenu

" Ignore filetypes in tab completion.
set wildignore+=*.aux,*.log,*.out,*.pdf

" Start scrolling 3 lines from border.
set scrolloff=3

" Left and right arrows go between lines
set whichwrap+=<,>,h,l,[,]

" Matching brace (e.g. begin.. end..)
set showmatch

" Keep working dir clean
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Sudo
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Saving shortcut
nnoremap <C-W> :w <CR>

" Mapleader shortcuts
let mapleader="'"

" Create new split and switch to it.
nnoremap <Leader>w <C-w>v<C-w>l
nnoremap <Leader>s <C-w>s<C-w>j
" Close split
nnoremap <Leader>c <C-w>c

" Easier movement in split windows.
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Calls (saves first) make
nnoremap <Leader>m :w\|silent make\|redraw!\|cc<CR>

" Quick toggle of diff mode.
nnoremap <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        diffoff
    else
        diffthis
    endif
:endfunction


" Synctex
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

	Plugin 'gmarik/Vundle.vim'

	Plugin 'sjl/gundo.vim'
		nnoremap <Leader>u :GundoToggle<CR>

	Plugin 'derekwyatt/vim-scala'
	Plugin 'flazz/vim-colorschemes'
	Plugin 'JuliaLang/julia-vim'

	Plugin 'scrooloose/syntastic'
	Plugin 'SirVer/ultisnips'
	Plugin 'honza/vim-snippets'
	Plugin 'severin-lemaignan/vim-minimap'

		let g:UltiSnipsUsePythonVersion = 3

		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<tab>"
		let g:UltiSnipsJumpBackwardTrigger="<c-z>"
		let g:UltiSnipsEditSplit="vertical"

	Plugin 'lervag/vimtex'
		let g:tex_flavor='latex'
		let g:vimtex_view_method='skim'
		let g:vimtex_quickfix_mode=0

set rtp+=~/.vim/bundle/vim-snippets/snippets/

call vundle#end()            " required
filetype plugin on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on

" Recognize .tex files as latex (instead of plaintex) for syntax highlighting.
let g:tex_flavor="latex"

" Set the make program (rubber)
autocmd FileType tex set makeprg=rubber\ --inplace\ --maxerr\ 1\ \ --pdf\ --short\ --quiet\ --force\ %
" Mappings for compiling Latex file

" Compile silently
autocmd FileType tex nmap <buffer> <C-T> :silent !latexmk -synctex=1 -pdf %<CR>

" Compile with info
autocmd FileType tex nmap <buffer> <C-I> :!latexmk -synctex=1 -pdf %<CR>

" Clear aux files
autocmd FileType tex nmap <buffer> <C-C> :!latexmk -c %<CR>

" Open PDF
autocmd FileType tex nmap <buffer> T :!open -a Skim %<.pdf %<.pdf<CR><CR>
autocmd FileType tex nmap <buffer> C :!rubber --clean<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off colorcolumn in diff mode.
autocmd FilterWritePre * if &diff | set cc= | endif

" Skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Fix wrapping issue
autocmd FileType tex    set textwidth=0


""""""""""""""""
" Other custom commands
""""""""""""""""
" Enable synctex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>


" Remember folds on save
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Fix local typos by spellcheck with control-L
" From https://castel.dev/post/lecture-notes-1/
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


""""""""""
" Typo correction
""""""""""

iab hte the
iab teh the
iab taht that
iab htat that
iab THe The
iab THen Then
iab THey They
iab THis This
iab THat That
iab THese These
iab THere There
iab THose Those
iab WHen When
iab SInce Since
iab jsut just
iab FOr For
iab codt cdot
