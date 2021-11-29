" Name:         github-dark.vim
" Description:  Github dark mode color scheme adaption for vim
" Author:       Lukas Moeller <lm@urlukas.com>
" Website:      https://github.com/lmllr/github-dark.vim/
" Last Updated: Mon Nov 29 19:38:53 CET 2021

" INFORMATION:
" --------------------------------------------------------------------------{{{

" :help highlight-groups
" :help hl-<highlight-group-name>

" `FIXME`: Highlight groups that still need work
" `TODO`: Needs adjusment/improvement
" `XXX`: General thoughts

" --------------------------------------------------------------------------}}}
" COLOR TABLE:
" --------------------------------------------------------------------------{{{

" +---------+----------------+---------+-------------+ - - - - - +
" |  NUMBER |      NAME      |   HEX   |     RGB     |           |
" +---------+----------------+---------+-------------+ - - - - - +
" |    0    |     Black      | #0D1117 |  13  17  23 |   0D1117  
" |    1    |     Red        | #FF7B72 | 255 123 114 |   FF7B72  |
" |    2    |     Green      | #7EE787 | 126 231 135 |   7EE787
" |    3    |     Yellow     | #FFA657 | 255 166  87 |   FFA657  |
" |    4    |     Blue       | #79C0FF | 121 192 255 |   79C0FF
" |    5    |     Magenta    | #D2A8FF | 210 168 255 |   D2A8FF  |
" |    6    |     Cyan       | #A5D6FF | 165 214 255 |   A5D6FF
" |    7    |     White      | #C9D1D9 | 201 209 217 |   C9D1D9  |
" |    8    | Bright Black   | #161B22 |  22  27  34 |   161B22
" |    9    | Bright Red     |    -    |      -      |           |
" |    10   | Bright Green   |    -    |      -      |
" |    11   | Bright Yellow  |    -    |      -      |           |
" |    12   | Bright Blue    |    -    |      -      |
" |    13   | Bright Magenta |    -    |      -      |           |
" |    14   | Bright Cyan    |    -    |      -      |
" |    15   | Bright White   | #8B949E | 139 148 158 |   8B949E  |
" +---------+----------------+---------+-------------+ - - - - - +

" --------------------------------------------------------------------------}}}
" INIT:
" --------------------------------------------------------------------------{{{

" Remove all existing highlighting and set the defaults
hi clear
" Load the syntax highlighting and set the defaults
if exists('syntax_on')
  syntax reset
endif

" If no colors OR np gui OR &t_Co not 256 do not run script!
if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

set background=dark

let g:colors_name = 'github-dark'

" --------------------------------------------------------------------------}}}
" INIT COLORS:
" --------------------------------------------------------------------------{{{

let s:n = 'NONE'

if has('gui_running')
  let s:bg1  = ['#0D1117', s:n]
  let s:bg2  = ['#161B22', s:n]
  let s:fg1  = ['#C9D1D9', s:n]
  let s:fg2  = ['#8B949E', s:n]
  let s:r    = ['#FF7B72', s:n]
  let s:g    = ['#7EE787', s:n]
  let s:y    = ['#FFA657', s:n]
  let s:b    = ['#79C0FF', s:n]
  let s:m    = ['#D2A8FF', s:n]
  let s:c    = ['#A5D6FF', s:n]
  let s:rev  = ['reverse', s:n]
  let s:u    = ['underline', s:n]
  let s:bold = ['bold', s:n]
  let s:uc   = ['undercurl', s:n]
else
  let s:bg1  = [s:n, 0]
  let s:bg2  = [s:n, 8]
  let s:fg1  = [s:n, 7]
  let s:fg2  = [s:n, 15]
  let s:r    = [s:n, 1]
  let s:g    = [s:n, 2]
  let s:y    = [s:n, 3]
  let s:b    = [s:n, 4]
  let s:m    = [s:n, 5]
  let s:c    = [s:n, 6]
  let s:rev  = [s:n, 'reverse']
  let s:u    = [s:n, 'underline']
  let s:bold = [s:n, 'bold']
  let s:uc   = [s:n, s:n]
endif

" --------------------------------------------------------------------------}}}
" HIGHLIGHT FUNC:
" --------------------------------------------------------------------------{{{

" USAGE:
"     call s:H(HighlightGroup,
"              ForegroundColor(mandatory),
"              BackgroundColor(mandatory),
"              attribute(optional),
"              guiSpecial(optional))
function! s:H(g, fg, bg, ...)
  let fg = a:fg
  let bg = a:bg
  
  if a:0 == 0
    let attr = [s:n, s:n]
  endif
  if a:0 >= 1
    if type(a:1) == 1
      let attr = [s:n, s:n]
    else
      let attr = a:1
    endif
  endif

  if type(fg) == 1
    let fg = [s:n, s:n]
  endif
  if type(bg) == 1
    let bg = [s:n, s:n]
  endif

  let hi = [
    \ 'highlight ' . a:g,
    \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
    \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
    \ 'gui=' . attr[0], 'cterm=' . attr[1],
    \ 'term=NONE'
    \ ]
  
  if a:0 > 1
    let sp = a:2
    let hi = add(hi, 'guisp=' . sp)
  endif

  execute join(hi, ' ')
endfunction

" --------------------------------------------------------------------------}}}
" BASIC:
" --------------------------------------------------------------------------{{{

" normal text
" background
" -->     group   ctermfg ctermbg cterm  guifg  guibg   gui
call s:H('Normal', s:fg1, s:bg1)

" *Comment any comment
" /* */, //, # ...
call s:H('Comment', s:fg2, '')

" *Constant any constant
" String a string constant: "this is a string"
" Character a character constant: 'c', '\n'
call s:H('Constant', s:c, '')

" Number a number constant: 234, 0xff
" Boolean a boolean constant: TRUE, false
" Float a floating point constant: 2.3e10
call s:H('Number', s:b, '')

" *Identifier any variable name
" Function function name (also: methods for classes)
call s:H('Identifier', s:b, '')

"*Statement any statement
" Conditional if, then, else, endif, switch, etc.
" Repeat for, do, while, etc.
" Label case, default, etc.
call s:H('Statement', s:r, '')

" Operator "sizeof", "+", "*", etc.
" Keyword any other keyword
" Exception try, catch, throw
call s:H('Operator', s:b, '')

"*PreProc generic Preprocessor
" Include preprocessor #include
" Define preprocessor #define
" Macro same as Define
" PreCondit preprocessor #if, #else, #endif, etc.
call s:H('PreProc', s:y, '')

" *Type int, long, char, etc.
" StorageClass static, register, volatile, etc.
" Structure struct, union, enum, etc.
" Typedef A typedef
call s:H('Type', s:b, '')

" *Special any special symbol
" SpecialChar special character in a constant
" Tag you can use CTRL-] on this
" Delimiter character that needs attention
" SpecialCommentspecial things inside a comment
" Debug debugging statements
call s:H('Special', s:g, '')

" *Underlined text that stands out, HTML links
" (XXX: ATTENTION! :XXX: set to NO underline at all)
call s:H('Underlined', s:m, '')


" *Ignore left blank, hidden  |hl-Ignore|
call s:H('Ignore', s:fg2, '')

" *Error any erroneous construct
call s:H('Error', s:r, '', s:rev)

" *Todo anything that needs extra attention; mostly the
" keywords TODO FIXME and XXX
call s:H('Todo', s:g, '')

" --------------------------------------------------------------------------}}}
" GENERAL UI:
" --------------------------------------------------------------------------{{{

" The character under the cursor or just before it,
" if it is a paired bracket, and its match.
call s:H('MatchParen', s:y, '', s:rev)

" '~' and '@' at the end of the window,
" characters from 'showbreak' and other character
" that do not really exist in the text
" (e.g., ">" displayed when a double-wide character
" doesn't fit at the end of the line)
call s:H('NonText', s:fg2, '')

" filler lines "~" after the last line in the buffer.
" By default, this is highlighted like |hl-NonText|.
call s:H('EndOfBuffer', s:fg2, '')

" meta and special keys listen with ":map", also for text used
" to show unprintable characters in the text, 'listchars'.
" Generally :  text that is displayed differently from what it
" really is
call s:H('SpecialKey', s:b, '')

" FIXME: make colors more appealing
" the column separating vertically split windows
call s:H('VertSplit', s:fg2, '', s:rev)

" FIXME: select different color when not using a `StatusLine`
" status line of current window
call s:H('StatusLine', s:fg1, s:bg2)

" status lines of not-current windows
call s:H('StatusLineNC', s:bg1, '', s:rev)

" XXX: change ctermbg for different lineNr bg
" line number for ":number" and ":#" commands, and when 'number'
" or 'relativenumber' option is set
call s:H('LineNr', s:fg2, '')

call s:H('Cursor', '', '', s:rev)

" XXX: cursorline set to same color as bg to show only `CursorLineNr`
" the screen line that the cursor is in when
" 'cursorline' is set
call s:H('CursorLine', '', s:bg1)

" XXX: Set to reverse!)
" the screen column that the cursor is in when
" 'cursorcolumn' is set
call s:H('CursorColumn', '', s:bg1, s:rev)

" 'colorcolumn' is a comma separated list of screen columns that are
" highlighted with ColorColumn |hl-ColorColumn|.  Useful to align text.
call s:H('ColorColumn', s:r, '')

" TODO: Normal text color better? displays line number where cursor is ...
" Like LineNr when 'cursorline' or 'relativenumber' is set for
" the cursor line (colors the number of the line the cursor is in)
call s:H('CursorLineNr', s:r, '')

" |more-prompt|
call s:H('MoreMsg', s:g, '')

" XXX: Set to background color to completely hide
"hi ModeMsg ctermfg=2 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE term=NONE
" 'showmode' message (e.g., "--INSERT--")
call s:H('ModeMsg', s:bg1, '')

" |hit-enter| propmt and yes/no questions
call s:H('Question', s:g, '')

" error messages on the command line
call s:H('ErrorMsg', s:r, '', s:rev)

" last search pattern highlighting (see 'hlsearch).
" also used for highlighting the current lin in the quickfix
" window and similar items that need to stand out
call s:H('Search', s:y, '', s:rev)

" 'incsearch' highlighting; also used for the text replaced with
" ":s///c"
call s:H('IncSearch', s:y, '', s:rev)

" TODO: better color!?
" titles for output from ":set all", ":autocmd" etc.
call s:H('Title', s:fg1, '')

" directory names (and other special names in listings)
call s:H('Directory', s:b, '')

" warning messages
call s:H('WarningMsg', s:y, '', s:rev)

" XXX: simply reverse color in visual
" selected piece of text for an operator in "visual mode"
call s:H('Visual', '', '', s:rev)

" (XXX: DISABLED! :XXX)
" Visual mode selection when vim is "Not Owning the Selection".
" Only X11 Gui's |gui-x11| and |xterm-clipboard| supports this.
hi clear VisualNOS 

" current match in 'wildmenu' completion
call s:H('WildMenu', s:y, '', s:rev)

" (XXX: SET TO NORMAL TEXT COLOR! :XXX)
" placeholder characters substituted for concealed
" text (see 'conceallevel')
call s:H('Conceal', s:fg1, '')

" --------------------------------------------------------------------------}}}
" VIMDIFF:
" --------------------------------------------------------------------------{{{
" FIXME: better way to color 'vimdiff'

" diff mode: added line |diff.txt|
call s:H('DiffAdd', s:g, '', s:rev)

" diff mode: changed line
call s:H('DiffChange', s:m, '', s:rev)

" diff mode: deleted line
call s:H('DiffDelete', s:r, '', s:rev)

" diff mode: changed text within a changed line
call s:H('DiffText', s:y, '', s:rev)

" --------------------------------------------------------------------------}}}
" TABS:
" --------------------------------------------------------------------------{{{

" tab pages line, not active tab page label
call s:H('Tabline', s:fg2, s:bg1)

" tab pages line, where there are no labels
call s:H('TablineFill', '', s:bg1)

" tab pages line, active tab page label
call s:H('TablineSel', s:r, s:bg2)

" --------------------------------------------------------------------------}}}
" FOLD:
" --------------------------------------------------------------------------{{{

" column where |signs| are displayed
call s:H('SignColumn', s:m, s:bg1)

" line used for closed folds
call s:H('Folded', s:fg2, '')

" 'foldcolumn'
" "+" where LineNr is...
call s:H('FoldColumn', s:r, '')

" --------------------------------------------------------------------------}}}
" PMENU:
" --------------------------------------------------------------------------{{{

" popup menu: normal item
call s:H('Pmenu', s:fg1, s:bg2)

" popup menu: thumb of the scrollbar
call s:H('PmenuSbar', '', s:fg2)

" (XXX SET TO BOLD! :XXX)
" popup menu: selected item
call s:H('PmenuSel', s:r, '', s:bold)

" popup menu: thumb of the scrollbar
call s:H('PmenuThumb', '', s:fg1)

" --------------------------------------------------------------------------}}}
" SPELLCHECK:
" --------------------------------------------------------------------------{{{

" FIXME: Come up with good spellcheck colors!! Undercurl in gui?
" word that is not recognised by the spellchecker. |spell|
" gvim has undercurl attributes
" but normal vim just colors and NO underline
call s:H('SpellBad', s:r, '', s:uc, 'red')

" word that should start with a capital.
call s:H('SpellCap', s:b, '')

" word that is recognised by the spellchecker as one that is
" hardly ever used.
call s:H('SpellRare', s:m, '')

" word that is recognised by the spellchecker as one that is
" used in another region.
call s:H('SpellLocal', s:y, '')

" --------------------------------------------------------------------------}}}
" Vimscript:
" --------------------------------------------------------------------------{{{

hi link vimOperParen Identifier
hi link vimSet vimOperParen
hi link vimSynType vimOperParen
hi link vimCommand Statement
hi link vimCommentTitle vimOperParen
hi link vimFuncName Underlined
hi link vimOper vimCommand
hi link vimIsCommand vimOperParen
hi link vimSep Title
hi link vimParenSep vimSep
hi link vimNotFunc vimCommand
hi link vimFunction vimFuncName
hi link vimUserFunc vimFuncName
hi link vimUsrCmd Constant
hi link vimLet vimCommand
hi link vimVar vimSep
hi link vimEnvvar vimOperParen
hi link vimSetEqual vimCommand
hi link vimOption vimOperParen
hi link vimHiCtermFgBg Title
hi link vimHiGuiFgBg Title
hi link vimHiAttrib vimCommand
hi link vimHiKeyList vimCommand
hi link vimContinue Title
hi link vimHighlight vimOperParen
hi link vimHiBang vimCommand

" -----------------------------------------------------------------------------}}}
" Help Section:
" --------------------------------------------------------------------------{{{

hi link helpHeader Statemnt
hi link helpSectionDelim helpHeader
hi link helpHyperTextJump Constant
hi link helpVim VimFuncName

" -----------------------------------------------------------------------------}}}
" Coc.nvim:
" --------------------------------------------------------------------------{{{

hi link CocErrorSign Statement
hi link CocWarningSign PreProc
hi link CocInfoSign CocWarningSign
hi link CocHintSign Identifier
hi link CocWarningVirtualText CocWarningSign

if has("gui_vimr")
  call s:H('CocUnderline', s:fg1, '', s:uc, 'red')
endif

" -----------------------------------------------------------------------------}}}
