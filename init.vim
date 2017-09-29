" -*- mode: vimrc -*-
" vim: ft=vim

"" Plugins {{{

  call plug#begin('~/.vim/plugged')

  " Usability
  Plug 'Yggdroot/indentLine'
  Plug 'hecal3/vim-leader-guide'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-startify'
  Plug 'scrooloose/nerdtree'
  Plug 'shime/vim-livedown'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'

  " Bling
  Plug 'chriskempson/base16-vim'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Highlighting & Completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'reasonml-editor/vim-reason'
  Plug 'w0rp/ale'

  call plug#end()

""" }}}

""" Settings {{{

  set background=dark
  set clipboard=unnamed
  let base16colorspace=256
  colorscheme base16-tomorrow-night
  " Shorten the time before the vim-leader-guide buffer appears
  set timeoutlen=3000

  if !&scrolloff
    set scrolloff=3       " Show next 3 lines while scrolling.
  endif
  if !&sidescrolloff
    set sidescrolloff=5   " Show next 5 columns while side-scrolling.
  endif
  set nostartofline       " Do not jump to first character with page commands.

  " better searching
  set ignorecase          " Make searching case insensitive
  set smartcase           " ... unless the query has capital letters.
  set gdefault            " Use 'g' flag by default with :s/foo/bar/.
  set magic               " Use 'magic' patterns (extended regular expressions).
  set hlsearch!           " highlight search results (<C-l> to clear)

  " Italic comments
  highlight Comment gui=italic
  highlight Comment cterm=italic
  set list!

  " Line number highlighting
  hi LineNr cterm=italic
  hi CursorLineNr cterm=bold,italic,standout

  " This augroup might be needed if LineNr / CursorLineNr settings don't work:
  " augroup CLNRSet
  "     autocmd! ColorScheme * hi CursorLineNr cterm=bold
  " augroup END

  " Shift-l / -h to change tabs
  noremap <S-l> gt
  noremap <S-h> gT

  " Map the leader key to <Space>
  let g:mapleader = ' '

  " Use ; for commands.
  nnoremap ; :

  " UI general configs
  set relativenumber                  " relative line numbers
  set number                          " show absolute line number on current line
  set numberwidth=5
  set showcmd                         " Show (partial) command in status line
  set showmatch                       " Show matching brackets
  set showmode                        " Show current mode
  set formatoptions+=o                " Continue comment marker in new lines
  set textwidth=0                     " Hard-wrap long lines as you type them
  set expandtab                       " Insert spaces when TAB is pressed
  set tabstop=2                       " Render TABs using this many spaces
  set shiftwidth=2                    " Indentation amount for < and > commands
  set listchars=tab:▸\ ,trail:◌       " Invisible characters

  " Rainbow parens
  augroup rainbow_filetypes
    autocmd!
    autocmd FileType javascript,reason,python,json,yml RainbowParentheses
  augroup END
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

  " Deoplete
  let g:deoplete#enable_at_startup = 1

  " Airline
  let g:airline_theme='minimalist'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = '|'
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#branch#empty_message = ''

  " ALE
  let g:airline#extensions#ale#enabled = 1
  let airline#extensions#ale#error_symbol = '✘ '
  let airline#extensions#ale#warning_symbol = '☞ '
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '☞'
  let g:ale_set_quickfix = 0
  let g:ale_linters = {
  \   'javascript': ['eslint', 'flow'],
  \   'reason': ['merlin'],
  \}
  " Language-related settings
  let g:jsx_ext_required = 0

""" }}}

""" Leader Guide {{{

  function! s:formatLeaderGuide()
      let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
      let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
      let g:leaderGuide#displayname =
      \ substitute(g:leaderGuide#displayname, '^:', '', '')
  endfunction

  let g:leaderGuide_displayfunc = [function("s:formatLeaderGuide")]
  call leaderGuide#register_prefix_descriptions(" ", "g:lmap")
  nnoremap <silent> <leader> :<C-U>LeaderGuide ' '<CR>
  vnoremap <silent> <leader> :<C-U>LeaderGuideVisual ' '<CR>
  let g:lmap = {}

  "" Add more Leader Groups here:

  " Files
  let g:lmap.f = { 'name': 'files' }
    nnoremap <silent>! <leader>f<CR>

    let g:lmap.f.d = ['e $HOME/.config/nvim/init.vim', 'edit $HOME/.config/nvim/init.vim']
    nnoremap <silent>! <leader>fd<CR>

    let g:lmap.f.R = ['source $HOME/.config/nvim/init.vim', 'refresh init.vim']
    nnoremap <silent>! <leader>fR<CR>

    let g:lmap.f.f = ['FZF', 'fzf']
    nnoremap <silent>! <leader>ff<CR>

    let g:lmap.f.b = ['Buffers', 'buffers']
    nnoremap <silent>! <leader>fb<CR>

    let g:lmap.f.t = ['NERDTreeToggle', 'NERDtree']
    nnoremap <silent>! <leader>ft<CR>
  "

  " UI
  let g:lmap.u = { 'name': 'UI' }
  nnoremap <silent>! <leader>u<CR>

    let g:lmap.u.h = { 'name': 'highlighting' }
    nnoremap <silent>! <leader>uh<CR>

      let g:lmap.u.h.l = ['setlocal invcursorline', 'highlight current line']
      nnoremap <silent>! <leader>uhl<CR>

      let g:lmap.u.h.c = ['setlocal invcursorcolumn', 'highlight current column']
      nnoremap <silent>! <leader>uhc<CR>

      let g:lmap.u.h.s = ['set hlsearch!', 'highlight search results']
      nnoremap <silent>! <leader>uhs<CR>

    let g:lmap.u.t = { 'name': 'toggles' }
    nnoremap <silent>! <leader>ut<CR>

      let g:lmap.u.t.l = ['setlocal invnumber', 'line numbers']
      nnoremap <silent>! <leader>utl<CR>

      let g:lmap.u.t.r = ['setlocal invrelativenumber', 'relative line numbers']
      nnoremap <silent>! <leader>utr<CR>

      let g:lmap.u.t.h = ['set list!', 'hidden symbols']
      nnoremap <silent>! <leader>uth<CR>

      let g:lmap.u.t.i = ['IndentLinesToggle', 'indent guide']
      nnoremap <silent>! <leader>uti<CR>

      let g:lmap.u.t.p = ['RainbowParentheses!!', 'rainbow parens']
      nnoremap <silent>! <leader>uti<CR>
  "

  " Linting
  let g:lmap.e = { 'name': 'errors' }
  nnoremap <silent>! <leader>e<CR>

    let g:lmap.e.r = ['ALELint', 'lint']
    nnoremap <silent>! <leader>er<CR>

    let g:lmap.e.t = ['ALEToggle', 'toggle Ale']
    nnoremap <silent>! <leader>et<CR>

    let g:lmap.e.l = ['lopen', 'show errors']
    nnoremap <silent>! <leader>el<CR>

    let g:lmap.e.c = ['lclose', 'close errors']
    nnoremap <silent>! <leader>ec<CR>

    let g:lmap.e.n = ['lnext', 'next']
    nnoremap <silent>! <leader>en<CR>

    let g:lmap.e.p = ['lprevious', 'previous']
    nnoremap <silent>! <leader>ep<CR>
  "

  " Plugins
  let g:lmap.p = { 'name': 'vim plug' }
  nnoremap <silent>! <leader>p<CR>

    let g:lmap.p.i = [ 'PlugInstall', 'install plugins' ]
    nnoremap <silent>! <leader>pi<CR>

    let g:lmap.p.u = [ 'PlugUpdate', 'update plugins' ]
    nnoremap <silent>! <leader>pu<CR>

    let g:lmap.p.c = [ 'PlugClean', 'clean $HOME/.config/nvim/plugged' ]
    nnoremap <silent>! <leader>pc<CR>
  "

  " Vim Fugitive
  let g:lmap.g = { 'name': 'fugitive' }
  nnoremap <silent>! <leader>g<CR>

    " Diff
    let g:lmap.g.d = { 'name': 'Diffing' }
    nnoremap <silent>! <leader>gd<CR>

      " Diff master against current
      let g:lmap.g.d.m = [ 'Gdiff master:%', 'Diff master : current' ]
      nnoremap <silent>! <leader>gdm<CR>

  "

""" }}}

