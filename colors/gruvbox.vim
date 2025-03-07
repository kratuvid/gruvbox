vim9script
# -----------------------------------------------------------------------------
# File: gruvbox.vim
# Description: Retro groove color scheme for Vim
# Author: morhetz <morhetz@gmail.com>
# Source: https://github.com/morhetz/gruvbox
# Last Modified: 12 Aug 2017
# -----------------------------------------------------------------------------

# Supporting code -------------------------------------------------------------
# Initialisation: {{{

hi clear
if exists("syntax_on")
  syntax reset
endif

g:colors_name = 'gruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

# }}}
# Global Settings: {{{

if !exists('g:gruvbox_bold')
  g:gruvbox_bold = 1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    g:gruvbox_italic = 1
  else
    g:gruvbox_italic = 0
  endif
endif
if !exists('g:gruvbox_undercurl')
  g:gruvbox_undercurl = 1
endif
if !exists('g:gruvbox_underline')
  g:gruvbox_underline = 1
endif
if !exists('g:gruvbox_inverse')
  g:gruvbox_inverse = 1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  g:gruvbox_guisp_fallback = 'NONE'
endif

if !exists('g:gruvbox_improved_strings')
  g:gruvbox_improved_strings = 0
endif

if !exists('g:gruvbox_improved_warnings')
  g:gruvbox_improved_warnings = 0
endif

if !exists('g:gruvbox_termcolors')
  g:gruvbox_termcolors = 256
endif

if !exists('g:gruvbox_invert_indent_guides')
  g:gruvbox_invert_indent_guides = 0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  g:gruvbox_contrast_dark = 'medium'
endif

if !exists('g:gruvbox_contrast_light')
  g:gruvbox_contrast_light = 'medium'
endif

const is_dark = &background == 'dark'

# }}}
# Palette: {{{

# setup palette dictionary
var gb = {}

# fill it with absolute colors
gb.dark0_hard  = ['#1d2021', 234]     # 29-32-33
gb.dark0       = ['#282828', 235]     # 40-40-40
gb.dark0_soft  = ['#32302f', 236]     # 50-48-47
gb.dark1       = ['#3c3836', 237]     # 60-56-54
gb.dark2       = ['#504945', 239]     # 80-73-69
gb.dark3       = ['#665c54', 241]     # 102-92-84
gb.dark4       = ['#7c6f64', 243]     # 124-111-100
gb.dark4_256   = ['#7c6f64', 243]     # 124-111-100

gb.gray_245    = ['#928374', 245]     # 146-131-116
gb.gray_244    = ['#928374', 244]     # 146-131-116

gb.light0_hard = ['#f9f5d7', 230]     # 249-245-215
gb.light0      = ['#fbf1c7', 229]     # 253-244-193
gb.light0_soft = ['#f2e5bc', 228]     # 242-229-188
gb.light1      = ['#ebdbb2', 223]     # 235-219-178
gb.light2      = ['#d5c4a1', 250]     # 213-196-161
gb.light3      = ['#bdae93', 248]     # 189-174-147
gb.light4      = ['#a89984', 246]     # 168-153-132
gb.light4_256  = ['#a89984', 246]     # 168-153-132

gb.bright_red     = ['#fb4934', 167]     # 251-73-52
gb.bright_green   = ['#b8bb26', 142]     # 184-187-38
gb.bright_yellow  = ['#fabd2f', 214]     # 250-189-47
gb.bright_blue    = ['#83a598', 109]     # 131-165-152
gb.bright_purple  = ['#d3869b', 175]     # 211-134-155
gb.bright_aqua    = ['#8ec07c', 108]     # 142-192-124
gb.bright_orange  = ['#fe8019', 208]     # 254-128-25

gb.neutral_red    = ['#cc241d', 124]     # 204-36-29
gb.neutral_green  = ['#98971a', 106]     # 152-151-26
gb.neutral_yellow = ['#d79921', 172]     # 215-153-33
gb.neutral_blue   = ['#458588', 66]      # 69-133-136
gb.neutral_purple = ['#b16286', 132]     # 177-98-134
gb.neutral_aqua   = ['#689d6a', 72]      # 104-157-106
gb.neutral_orange = ['#d65d0e', 166]     # 214-93-14

gb.faded_red      = ['#9d0006', 88]      # 157-0-6
gb.faded_green    = ['#79740e', 100]     # 121-116-14
gb.faded_yellow   = ['#b57614', 136]     # 181-118-20
gb.faded_blue     = ['#076678', 24]      # 7-102-120
gb.faded_purple   = ['#8f3f71', 96]      # 143-63-113
gb.faded_aqua     = ['#427b58', 66]      # 66-123-88
gb.faded_orange   = ['#af3a03', 130]     # 175-58-3

# }}}
# Setup Emphasis: {{{

var bold = 'bold,'
if g:gruvbox_bold == 0
  bold = ''
endif

var italic = 'italic,'
if g:gruvbox_italic == 0
  italic = ''
endif

var underline = 'underline,'
if g:gruvbox_underline == 0
  underline = ''
endif

var undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  undercurl = ''
endif

var inverse = 'inverse,'
if g:gruvbox_inverse == 0
  inverse = ''
endif

# }}}
# Setup Colors: {{{

var vim_bg = ['bg', 'bg']
var vim_fg = ['fg', 'fg']
var none = ['NONE', 'NONE']

# determine relative colors
var bg0 = []

var bg1 = []
var bg2 = []
var bg3 = []
var bg4 = []

var gray = []

var fg0 = []
var fg1 = []
var fg2 = []
var fg3 = []
var fg4 = []

var fg4_256 = []

var red    = []
var green  = []
var yellow = []
var blue   = []
var purple = []
var aqua   = []
var orange = []

if is_dark
  bg0 = gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    bg0 = gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    bg0 = gb.dark0_hard
  endif

  bg1 = gb.dark1
  bg2 = gb.dark2
  bg3 = gb.dark3
  bg4 = gb.dark4

  gray = gb.gray_245

  fg0 = gb.light0
  fg1 = gb.light1
  fg2 = gb.light2
  fg3 = gb.light3
  fg4 = gb.light4

  fg4_256 = gb.light4_256

  red    = gb.bright_red
  green  = gb.bright_green
  yellow = gb.bright_yellow
  blue   = gb.bright_blue
  purple = gb.bright_purple
  aqua   = gb.bright_aqua
  orange = gb.bright_orange
else
  bg0 = gb.light0
  if g:gruvbox_contrast_light == 'soft'
    bg0 = gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    bg0 = gb.light0_hard
  endif

  bg1 = gb.light1
  bg2 = gb.light2
  bg3 = gb.light3
  bg4 = gb.light4

  gray = gb.gray_244

  fg0 = gb.dark0
  fg1 = gb.dark1
  fg2 = gb.dark2
  fg3 = gb.dark3
  fg4 = gb.dark4

  fg4_256 = gb.dark4_256

  red    = gb.faded_red
  green  = gb.faded_green
  yellow = gb.faded_yellow
  blue   = gb.faded_blue
  purple = gb.faded_purple
  aqua   = gb.faded_aqua
  orange = gb.faded_orange
endif

# reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  bg0[1]    = 0
  fg4[1]    = 7
  gray[1]   = 8
  red[1]    = 9
  green[1]  = 10
  yellow[1] = 11
  blue[1]   = 12
  purple[1] = 13
  aqua[1]   = 14
  fg1[1]    = 15
endif

# save current relative colors back to palette dictionary
gb.bg0 = bg0
gb.bg1 = bg1
gb.bg2 = bg2
gb.bg3 = bg3
gb.bg4 = bg4

gb.gray = gray

gb.fg0 = fg0
gb.fg1 = fg1
gb.fg2 = fg2
gb.fg3 = fg3
gb.fg4 = fg4

gb.fg4_256 = fg4_256

gb.red    = red
gb.green  = green
gb.yellow = yellow
gb.blue   = blue
gb.purple = purple
gb.aqua   = aqua
gb.orange = orange

# }}}
# Setup Terminal Colors For Neovim: {{{

# Neovim has no plans to support Vim9script. So, commenting this out

# if has('nvim')
#   let g:terminal_color_0 = s:bg0[0]
#   let g:terminal_color_8 = s:gray[0]

#   let g:terminal_color_1 = s:gb.neutral_red[0]
#   let g:terminal_color_9 = s:red[0]

#   let g:terminal_color_2 = s:gb.neutral_green[0]
#   let g:terminal_color_10 = s:green[0]

#   let g:terminal_color_3 = s:gb.neutral_yellow[0]
#   let g:terminal_color_11 = s:yellow[0]

#   let g:terminal_color_4 = s:gb.neutral_blue[0]
#   let g:terminal_color_12 = s:blue[0]

#   let g:terminal_color_5 = s:gb.neutral_purple[0]
#   let g:terminal_color_13 = s:purple[0]

#   let g:terminal_color_6 = s:gb.neutral_aqua[0]
#   let g:terminal_color_14 = s:aqua[0]

#   let g:terminal_color_7 = s:fg4[0]
#   let g:terminal_color_15 = s:fg1[0]
# endif

# }}}
# Overload Setting: {{{

var hls_cursor = orange
if exists('g:gruvbox_hls_cursor')
  hls_cursor = get(gb, g:gruvbox_hls_cursor)
endif

var number_column = none
if exists('g:gruvbox_number_column')
  number_column = get(gb, g:gruvbox_number_column)
endif

var sign_column = bg1

if exists('g:gitgutter_override_sign_column_highlight')
    && g:gitgutter_override_sign_column_highlight == 1
  sign_column = number_column
else
  g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    sign_column = get(gb, g:gruvbox_sign_column)
  endif
endif

var color_column = bg1
if exists('g:gruvbox_color_column')
  color_column = get(gb, g:gruvbox_color_column)
endif

var vert_split = bg0
if exists('g:gruvbox_vert_split')
  vert_split = get(gb, g:gruvbox_vert_split)
endif

var invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    invert_signs = inverse
  endif
endif

var invert_selection = inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    invert_selection = ''
  endif
endif

var invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    invert_tabline = inverse
  endif
endif

var italicize_comments = italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    italicize_comments = ''
  endif
endif

var italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    italicize_strings = italic
  endif
endif

# }}}
# Highlighting Function: {{{

# vim9script
# def F(a: string, b: string, ...rest: list<string>)
#   echo 'a: ' .. a
#   echo 'b: ' .. b
#   echo printf('rest(%d): %s', rest->len(), rest)
# enddef
# F('zoom', 'yoyo')
# F('roomba', 'zulu', 'close', 'call')

def HL(group: string, _fg: list<any>, ...rest: list<any>)
  # Arguments: group, guifg, guibg, gui, guisp

  # echom printf("> group: %s", group)
  # echom printf("> _fg: %s", _fg)
  # echom printf("> rest: %s", rest)
  # echom " "

  # foreground
  var fg = _fg

  # background
  var bg = []
  if rest->len() >= 1
    bg = rest[0]
  else
    bg = none
  endif

  # emphasis
  var emstr = 'NONE,'
  if rest->len() >= 2 && strlen(rest[1]) > 0
    emstr = rest[1]
  endif

  # special fallback
  if rest->len() >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      fg = rest[2]
    endif

    # bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      emstr ..= 'inverse,'
    endif
  endif

  var histring = ['hi', group,
    'guifg=' .. fg[0], 'ctermfg=' .. fg[1],
    'guibg=' .. bg[0], 'ctermbg=' .. bg[1],
    'gui=' .. emstr[ : -2], 'cterm=' .. emstr[ : -2]
  ]

  # special
  if rest->len() >= 3
    add(histring, 'guisp=' .. rest[2][0])
  endif

  execute join(histring, ' ')
enddef

# }}}
# Gruvbox Hi Groups: {{{

# memoize common hi groups
HL('GruvboxFg0', fg0)
HL('GruvboxFg1', fg1)
HL('GruvboxFg2', fg2)
HL('GruvboxFg3', fg3)
HL('GruvboxFg4', fg4)
HL('GruvboxGray', gray)
HL('GruvboxBg0', bg0)
HL('GruvboxBg1', bg1)
HL('GruvboxBg2', bg2)
HL('GruvboxBg3', bg3)
HL('GruvboxBg4', bg4)

HL('GruvboxRed', red)
HL('GruvboxRedBold', red, none, bold)
HL('GruvboxGreen', green)
HL('GruvboxGreenBold', green, none, bold)
HL('GruvboxYellow', yellow)
HL('GruvboxYellowBold', yellow, none, bold)
HL('GruvboxBlue', blue)
HL('GruvboxBlueBold', blue, none, bold)
HL('GruvboxPurple', purple)
HL('GruvboxPurpleBold', purple, none, bold)
HL('GruvboxAqua', aqua)
HL('GruvboxAquaBold', aqua, none, bold)
HL('GruvboxOrange', orange)
HL('GruvboxOrangeBold', orange, none, bold)

HL('GruvboxRedSign', red, sign_column, invert_signs)
HL('GruvboxGreenSign', green, sign_column, invert_signs)
HL('GruvboxYellowSign', yellow, sign_column, invert_signs)
HL('GruvboxBlueSign', blue, sign_column, invert_signs)
HL('GruvboxPurpleSign', purple, sign_column, invert_signs)
HL('GruvboxAquaSign', aqua, sign_column, invert_signs)
HL('GruvboxOrangeSign', orange, sign_column, invert_signs)

# }}}

# Vanilla colorscheme ---------------------------------------------------------
# General UI: {{{

# Normal text
HL('Normal', fg1, bg0)

# Correct background (see issue #7):
# --- Problem with changing between dark and light on 256 color terminal
# --- https://github.com/morhetz/gruvbox/issues/7
if is_dark
  set background=dark
else
  set background=light
endif

# Screen line that the cursor is
HL('CursorLine', none, bg1)
# Screen column that the cursor is
hi! link CursorColumn CursorLine

# Tab pages line filler
HL('TabLineFill', bg4, bg1, invert_tabline)
# Active tab page label
HL('TabLineSel', green, bg1, invert_tabline)
# Not active tab page label
hi! link TabLine TabLineFill

# Match paired bracket under the cursor
HL('MatchParen', none, bg3, bold)

# Highlighted screen columns
HL('ColorColumn',  none, color_column)

# Concealed element: \lambda → λ
HL('Conceal', blue, none)

# Line number of CursorLine
HL('CursorLineNr', yellow, bg1)

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

HL('Visual',    none,  bg3, invert_selection)
hi! link VisualNOS Visual

HL('Search',    yellow, bg0, inverse)
HL('IncSearch', hls_cursor, bg0, inverse)

HL('Underlined', blue, none, underline)

HL('StatusLine',   bg2, fg1, inverse)
HL('StatusLineNC', bg1, fg4, inverse)

# The column separating vertically split windows
HL('VertSplit', bg3, vert_split)

# Current match in wildmenu completion
HL('WildMenu', blue, bg2, bold)

# Directory names, special names in listing
hi! link Directory GruvboxGreenBold

# Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

# Error messages on the command line
HL('ErrorMsg',   bg0, red, bold)
# More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
# Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
# 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
# Warning messages
hi! link WarningMsg GruvboxRedBold

# }}}
# Gutter: {{{

# Line number for :number and :# commands
HL('LineNr', bg4, number_column)

# Column where signs are displayed
HL('SignColumn', none, sign_column)

# Line used for closed folds
HL('Folded', gray, bg1, italic)
# Column where folds are displayed
HL('FoldColumn', gray, bg1)

# }}}
# Cursor: {{{

# Character under cursor
HL('Cursor', none, none, inverse)
# Visual mode cursor, selection
hi! link vCursor Cursor
# Input moder cursor
hi! link iCursor Cursor
# Language mapping cursor
hi! link lCursor Cursor

# }}}
# Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
  HL('Special', orange, bg1, italicize_strings)
endif

HL('Comment', gray, none, italicize_comments)
HL('Todo', vim_fg, vim_bg, bold .. italic)
HL('Error', red, vim_bg, bold .. inverse)

# Generic statement
hi! link Statement GruvboxRed
# if, then, else, endif, swicth, etc.
hi! link Conditional GruvboxRed
# for, do, while, etc.
hi! link Repeat GruvboxRed
# case, default, etc.
hi! link Label GruvboxRed
# try, catch, throw
hi! link Exception GruvboxRed
# sizeof, "+", "*", etc.
hi! link Operator Normal
# Any other keyword
hi! link Keyword GruvboxRed

# Variable name
hi! link Identifier GruvboxBlue
# Function name
hi! link Function GruvboxGreenBold

# Generic preprocessor
hi! link PreProc GruvboxAqua
# Preprocessor #include
hi! link Include GruvboxAqua
# Preprocessor #define
hi! link Define GruvboxAqua
# Same as Define
hi! link Macro GruvboxAqua
# Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

# Generic constant
hi! link Constant GruvboxPurple
# Character constant: 'c', '/n'
hi! link Character GruvboxPurple
# String constant: "this is a string"
if g:gruvbox_improved_strings == 0
  HL('String',  green, none, italicize_strings)
else
  HL('String',  fg1, bg1, italicize_strings)
endif
# Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
# Number constant: 234, 0xff
hi! link Number GruvboxPurple
# Floating point constant: 2.3e10
hi! link Float GruvboxPurple

# Generic type
hi! link Type GruvboxYellow
# static, register, volatile, etc
hi! link StorageClass GruvboxOrange
# struct, union, enum, etc.
hi! link Structure GruvboxAqua
# typedef
hi! link Typedef GruvboxYellow

# }}}
# Completion Menu: {{{

# Popup menu: normal item
HL('Pmenu', fg1, bg2)
# Popup menu: selected item
HL('PmenuSel', bg2, blue, bold)
# Popup menu: scrollbar
HL('PmenuSbar', none, bg2)
# Popup menu: scrollbar thumb
HL('PmenuThumb', none, bg4)

# }}}
# Diffs: {{{

HL('DiffDelete', red, bg0, inverse)
HL('DiffAdd',    green, bg0, inverse)
# HL('DiffChange', bg0, blue)
# HL('DiffText',   bg0, yellow)

# Alternative setting
HL('DiffChange', aqua, bg0, inverse)
HL('DiffText',   yellow, bg0, inverse)

# }}}
# Spelling: {{{

if has("spell")
  # Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    HL('SpellCap',   none, none, undercurl, red)
  else
    HL('SpellCap',   green, none, bold .. italic)
  endif
  # Not recognized word
  HL('SpellBad',   none, none, undercurl, blue)
  # Wrong spelling for selected region
  HL('SpellLocal', none, none, undercurl, aqua)
  # Rare word
  HL('SpellRare',  none, none, undercurl, purple)
endif

# }}}

# Plugin specific -------------------------------------------------------------
# EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

# }}}
# Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

# }}}
# Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    HL('IndentGuidesOdd', vim_bg, bg2)
    HL('IndentGuidesEven', vim_bg, bg1)
  else
    HL('IndentGuidesOdd', vim_bg, bg2, inverse)
    HL('IndentGuidesEven', vim_bg, bg3, inverse)
  endif
endif

# }}}
# IndentLine: {{{

if !exists('g:indentLine_color_term')
  g:indentLine_color_term = bg2[1]
endif
if !exists('g:indentLine_color_gui')
  g:indentLine_color_gui = bg2[0]
endif

# }}}
# Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  g:rbpt_colorpairs = [
    ['blue', '#458588'], ['magenta', '#b16286'],
    ['red',  '#cc241d'], ['166',     '#d65d0e']
  ]
endif

g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

g:niji_dark_colours = g:rbpt_colorpairs
g:niji_light_colours = g:rbpt_colorpairs

# }}}
# GitGutter: {{{

hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDelete GruvboxRedSign
hi! link GitGutterChangeDelete GruvboxAquaSign

# }}}
# GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

# }}}
# Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDelete GruvboxRedSign

# }}}
# Syntastic: {{{

HL('SyntasticError', none, none, undercurl, red)
HL('SyntasticWarning', none, none, undercurl, yellow)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

# }}}
# Signature: {{{
hi! link SignatureMarkText   GruvboxBlueSign
hi! link SignatureMarkerText GruvboxPurpleSign

# }}}
# ShowMarks: {{{

hi! link ShowMarksHLl GruvboxBlueSign
hi! link ShowMarksHLu GruvboxBlueSign
hi! link ShowMarksHLo GruvboxBlueSign
hi! link ShowMarksHLm GruvboxBlueSign

# }}}
# CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2

HL('CtrlPMode1', blue, bg2, bold)
HL('CtrlPMode2', bg0, blue, bold)
HL('CtrlPStats', fg4, bg2, bold)

# }}}
# Startify: {{{

hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxBlue
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2

# }}}
# Vimshell: {{{

g:vimshell_escape_colors = [
  bg4[0], red[0], green[0], yellow[0],
  blue[0], purple[0], aqua[0], fg4[0],
  bg0[0], red[0], green[0], orange[0],
  blue[0], purple[0], aqua[0], fg0[0]
]

# }}}
# BufTabLine: {{{

HL('BufTabLineCurrent', bg0, fg4)
HL('BufTabLineActive', fg4, bg2)
HL('BufTabLineHidden', bg4, bg1)
HL('BufTabLineFill', bg0, bg0)

# }}}
# Asynchronous Lint Engine: {{{

HL('ALEError', none, none, undercurl, red)
HL('ALEWarning', none, none, undercurl, yellow)
HL('ALEInfo', none, none, undercurl, blue)

hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxBlueSign

# }}}
# Dirvish: {{{

hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow

# }}}
# Netrw: {{{

hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxBlue
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen

# }}}
# NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

# }}}
# Vim Multiple Cursors: {{{

HL('multiple_cursors_cursor', none, none, inverse)
HL('multiple_cursors_visual', none, bg2)

# }}}
# coc.nvim: {{{

hi! link CocErrorSign GruvboxRedSign
hi! link CocWarningSign GruvboxOrangeSign
hi! link CocInfoSign GruvboxYellowSign
hi! link CocHintSign GruvboxBlueSign
hi! link CocErrorFloat GruvboxRed
hi! link CocWarningFloat GruvboxOrange
hi! link CocInfoFloat GruvboxYellow
hi! link CocHintFloat GruvboxBlue
hi! link CocDiagnosticsError GruvboxRed
hi! link CocDiagnosticsWarning GruvboxOrange
hi! link CocDiagnosticsInfo GruvboxYellow
hi! link CocDiagnosticsHint GruvboxBlue

hi! link CocSelectedText GruvboxRed
hi! link CocCodeLens GruvboxGray

HL('CocErrorHighlight', none, none, undercurl, red)
HL('CocWarningHighlight', none, none, undercurl, orange)
HL('CocInfoHighlight', none, none, undercurl, yellow)
HL('CocHintHighlight', none, none, undercurl, blue)

# }}}

# Filetype specific -----------------------------------------------------------
# Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

# }}}
# Html: {{{

hi! link htmlTag GruvboxBlue
hi! link htmlEndTag GruvboxBlue

hi! link htmlTagName GruvboxAquaBold
hi! link htmlArg GruvboxAqua

hi! link htmlScriptTag GruvboxPurple
hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxAquaBold

HL('htmlLink', fg4, none, underline)

hi! link htmlSpecialChar GruvboxOrange

HL('htmlBold', vim_fg, vim_bg, bold)
HL('htmlBoldUnderline', vim_fg, vim_bg, bold .. underline)
HL('htmlBoldItalic', vim_fg, vim_bg, bold .. italic)
HL('htmlBoldUnderlineItalic', vim_fg, vim_bg, bold .. underline .. italic)

HL('htmlUnderline', vim_fg, vim_bg, underline)
HL('htmlUnderlineItalic', vim_fg, vim_bg, underline .. italic)
HL('htmlItalic', vim_fg, vim_bg, italic)

# }}}
# Xml: {{{

hi! link xmlTag GruvboxBlue
hi! link xmlEndTag GruvboxBlue
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword GruvboxAquaBold

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxPurple
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple

hi! link xmlAttrib GruvboxAqua
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxOrange
hi! link xmlEntityPunct GruvboxOrange
# }}}
# Vim: {{{

HL('vimCommentTitle', fg4_256, none, bold .. italicize_comments)

hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3

# }}}
# Clojure: {{{

hi! link clojureKeyword GruvboxBlue
hi! link clojureCond GruvboxOrange
hi! link clojureSpecial GruvboxOrange
hi! link clojureDefine GruvboxOrange

hi! link clojureFunc GruvboxYellow
hi! link clojureRepeat GruvboxYellow
hi! link clojureCharacter GruvboxAqua
hi! link clojureStringEscape GruvboxAqua
hi! link clojureException GruvboxRed

hi! link clojureRegexp GruvboxAqua
hi! link clojureRegexpEscape GruvboxAqua
HL('clojureRegexpCharClass', fg3, none, bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen GruvboxFg3
hi! link clojureAnonArg GruvboxYellow
hi! link clojureVariable GruvboxBlue
hi! link clojureMacro GruvboxOrange

hi! link clojureMeta GruvboxYellow
hi! link clojureDeref GruvboxYellow
hi! link clojureQuote GruvboxYellow
hi! link clojureUnquote GruvboxYellow

# }}}
# C: {{{

hi! link cOperator GruvboxPurple
hi! link cStructure GruvboxOrange

# }}}
# Python: {{{

hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxAqua
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxBlue
hi! link pythonImport GruvboxBlue
hi! link pythonRun GruvboxBlue
hi! link pythonCoding GruvboxBlue
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxPurple
hi! link pythonBoolean GruvboxPurple
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxGreenBold

# }}}
# CSS: {{{

hi! link cssBraces GruvboxBlue
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxBlue
hi! link cssSelectorOp GruvboxBlue
hi! link cssSelectorOp2 GruvboxBlue
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1

hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua

# }}}
# JavaScript: {{{

hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxAqua
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptParens GruvboxFg3

# }}}
# YAJS: {{{

hi! link javascriptImport GruvboxAqua
hi! link javascriptExport GruvboxAqua
hi! link javascriptClassKeyword GruvboxAqua
hi! link javascriptClassExtends GruvboxAqua
hi! link javascriptDefault GruvboxAqua

hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptGlobal GruvboxYellow

hi! link javascriptEndColons GruvboxFg1
hi! link javascriptFuncArg GruvboxFg1
hi! link javascriptGlobalMethod GruvboxFg1
hi! link javascriptNodeGlobal GruvboxFg1
hi! link javascriptBOMWindowProp GruvboxFg1
hi! link javascriptArrayMethod GruvboxFg1
hi! link javascriptArrayStaticMethod GruvboxFg1
hi! link javascriptCacheMethod GruvboxFg1
hi! link javascriptDateMethod GruvboxFg1
hi! link javascriptMathStaticMethod GruvboxFg1

# hi! link javascriptProp GruvboxFg1
hi! link javascriptURLUtilsProp GruvboxFg1
hi! link javascriptBOMNavigatorProp GruvboxFg1
hi! link javascriptDOMDocMethod GruvboxFg1
hi! link javascriptDOMDocProp GruvboxFg1
hi! link javascriptBOMLocationMethod GruvboxFg1
hi! link javascriptBOMWindowMethod GruvboxFg1
hi! link javascriptStringMethod GruvboxFg1

hi! link javascriptVariable GruvboxOrange
# hi! link javascriptVariable GruvboxRed
# hi! link javascriptIdentifier GruvboxOrange
# hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptIdentifier GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange

# hi! link javascriptFuncKeyword GruvboxOrange
# hi! link javascriptAsyncFunc GruvboxOrange
hi! link javascriptFuncKeyword GruvboxAqua
hi! link javascriptAsyncFunc GruvboxAqua
hi! link javascriptClassStatic GruvboxOrange

hi! link javascriptOperator GruvboxRed
hi! link javascriptForOperator GruvboxRed
hi! link javascriptYield GruvboxRed
hi! link javascriptExceptions GruvboxRed
hi! link javascriptMessage GruvboxRed

hi! link javascriptTemplateSB GruvboxAqua
hi! link javascriptTemplateSubstitution GruvboxFg1

# hi! link javascriptLabel GruvboxBlue
# hi! link javascriptObjectLabel GruvboxBlue
# hi! link javascriptPropertyName GruvboxBlue
hi! link javascriptLabel GruvboxFg1
hi! link javascriptObjectLabel GruvboxFg1
hi! link javascriptPropertyName GruvboxFg1

hi! link javascriptLogicSymbols GruvboxFg1
hi! link javascriptArrowFunc GruvboxYellow

hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamType GruvboxFg4
hi! link javascriptDocNamedParamType GruvboxFg4

hi! link javascriptBrackets GruvboxFg1
hi! link javascriptDOMElemAttrs GruvboxFg1
hi! link javascriptDOMEventMethod GruvboxFg1
hi! link javascriptDOMNodeMethod GruvboxFg1
hi! link javascriptDOMStorageMethod GruvboxFg1
hi! link javascriptHeadersMethod GruvboxFg1

hi! link javascriptAsyncFuncKeyword GruvboxRed
hi! link javascriptAwaitFuncKeyword GruvboxRed

# }}}
# PanglossJS: {{{

hi! link jsClassKeyword GruvboxAqua
hi! link jsExtendsKeyword GruvboxAqua
hi! link jsExportDefault GruvboxAqua
hi! link jsTemplateBraces GruvboxAqua
hi! link jsGlobalNodeObjects GruvboxFg1
hi! link jsGlobalObjects GruvboxFg1
hi! link jsFunction GruvboxAqua
hi! link jsFuncParens GruvboxFg3
hi! link jsParens GruvboxFg3
hi! link jsNull GruvboxPurple
hi! link jsUndefined GruvboxPurple
hi! link jsClassDefinition GruvboxYellow

# }}}
# TypeScript: {{{

hi! link typeScriptReserved GruvboxAqua
hi! link typeScriptLabel GruvboxAqua
hi! link typeScriptFuncKeyword GruvboxAqua
hi! link typeScriptIdentifier GruvboxOrange
hi! link typeScriptBraces GruvboxFg1
hi! link typeScriptEndColons GruvboxFg1
hi! link typeScriptDOMObjects GruvboxFg1
hi! link typeScriptAjaxMethods GruvboxFg1
hi! link typeScriptLogicSymbols GruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects GruvboxFg1
hi! link typeScriptParens GruvboxFg3
hi! link typeScriptOpSymbols GruvboxFg3
hi! link typeScriptHtmlElemProperties GruvboxFg1
hi! link typeScriptNull GruvboxPurple
hi! link typeScriptInterpolationDelimiter GruvboxAqua

# }}}
# PureScript: {{{

hi! link purescriptModuleKeyword GruvboxAqua
hi! link purescriptModuleName GruvboxFg1
hi! link purescriptWhere GruvboxAqua
hi! link purescriptDelimiter GruvboxFg4
hi! link purescriptType GruvboxFg1
hi! link purescriptImportKeyword GruvboxAqua
hi! link purescriptHidingKeyword GruvboxAqua
hi! link purescriptAsKeyword GruvboxAqua
hi! link purescriptStructure GruvboxAqua
hi! link purescriptOperator GruvboxBlue

hi! link purescriptTypeVar GruvboxFg1
hi! link purescriptConstructor GruvboxFg1
hi! link purescriptFunction GruvboxFg1
hi! link purescriptConditional GruvboxOrange
hi! link purescriptBacktick GruvboxOrange

# }}}
# CoffeeScript: {{{

hi! link coffeeExtendedOp GruvboxFg3
hi! link coffeeSpecialOp GruvboxFg3
hi! link coffeeCurly GruvboxOrange
hi! link coffeeParen GruvboxFg3
hi! link coffeeBracket GruvboxOrange

# }}}
# Ruby: {{{

hi! link rubyStringDelimiter GruvboxGreen
hi! link rubyInterpolationDelimiter GruvboxAqua

# }}}
# ObjectiveC: {{{

hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxBlue

# }}}
# Go: {{{

hi! link goDirective GruvboxAqua
hi! link goConstants GruvboxPurple
hi! link goDeclaration GruvboxRed
hi! link goDeclType GruvboxBlue
hi! link goBuiltins GruvboxOrange

# }}}
# Lua: {{{

hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange

# }}}
# MoonScript: {{{

hi! link moonSpecialOp GruvboxFg3
hi! link moonExtendedOp GruvboxFg3
hi! link moonFunction GruvboxFg3
hi! link moonObject GruvboxYellow

# }}}
# Java: {{{

hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange

hi! link javaVarArg GruvboxGreen

# }}}
# Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter GruvboxGreen
hi! link elixirInterpolationDelimiter GruvboxAqua

hi! link elixirModuleDeclaration GruvboxYellow

# }}}
# Scala: {{{

# NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition GruvboxFg1
hi! link scalaCaseFollowing GruvboxFg1
hi! link scalaCapitalWord GruvboxFg1
hi! link scalaTypeExtension GruvboxFg1

hi! link scalaKeyword GruvboxRed
hi! link scalaKeywordModifier GruvboxRed

hi! link scalaSpecial GruvboxAqua
hi! link scalaOperator GruvboxFg1

hi! link scalaTypeDeclaration GruvboxYellow
hi! link scalaTypeTypePostDeclaration GruvboxYellow

hi! link scalaInstanceDeclaration GruvboxFg1
hi! link scalaInterpolation GruvboxAqua

# }}}
# Markdown: {{{

HL('markdownItalic', fg3, none, italic)

hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxGreen

HL('markdownLinkText', gray, none, underline)
hi! link markdownIdDeclaration markdownLinkText

# }}}
# Haskell: {{{

# hi! link haskellType GruvboxYellow
# hi! link haskellOperators GruvboxOrange
# hi! link haskellConditional GruvboxAqua
# hi! link haskellLet GruvboxOrange

hi! link haskellType GruvboxFg1
hi! link haskellIdentifier GruvboxFg1
hi! link haskellSeparator GruvboxFg1
hi! link haskellDelimiter GruvboxFg4
hi! link haskellOperators GruvboxBlue

hi! link haskellBacktick GruvboxOrange
hi! link haskellStatement GruvboxOrange
hi! link haskellConditional GruvboxOrange

hi! link haskellLet GruvboxAqua
hi! link haskellDefault GruvboxAqua
hi! link haskellWhere GruvboxAqua
hi! link haskellBottom GruvboxAqua
hi! link haskellBlockKeywords GruvboxAqua
hi! link haskellImportKeywords GruvboxAqua
hi! link haskellDeclKeyword GruvboxAqua
hi! link haskellDeriving GruvboxAqua
hi! link haskellAssocType GruvboxAqua

hi! link haskellNumber GruvboxPurple
hi! link haskellPragma GruvboxPurple

hi! link haskellString GruvboxGreen
hi! link haskellChar GruvboxGreen

# }}}
# Json: {{{

hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1

# }}}


# Functions -------------------------------------------------------------------
# Search Highlighting Cursor {{{

export def GruvboxHlsShowCursor()
  HL('Cursor', bg0, hls_cursor)
enddef

export def GruvboxHlsHideCursor()
  HL('Cursor', none, none, inverse)
enddef

# }}}

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
