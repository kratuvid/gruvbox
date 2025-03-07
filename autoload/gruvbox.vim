vim9script
# -----------------------------------------------------------------------------
# File: gruvbox.vim
# Description: Retro groove color scheme for Vim
# Author: morhetz <morhetz@gmail.com>
# Source: https://github.com/morhetz/gruvbox
# Last Modified: 08 Mar 2025
# Ported By: kratuvid <ray779@tuta.io>
# -----------------------------------------------------------------------------

import '../colors/gruvbox.vim' as gruvbox_colors

export def InvertSignsToggle()
  if exists('g:gruvbox_invert_signs')
    if g:gruvbox_invert_signs == 0
      g:gruvbox_invert_signs = 1
    else
      g:gruvbox_invert_signs = 0
    endif
  else
    g:gruvbox_invert_signs = 0
  endif

  colorscheme gruvbox
enddef

# Search Highlighting {{{

export def HlsShow()
  set hlsearch
  gruvbox_colors.GruvboxHlsShowCursor()
enddef

export def HlsHide()
  set nohlsearch
  gruvbox_colors.GruvboxHlsHideCursor()
enddef

export def HlsToggle()
  if &hlsearch
    HlsHide()
  else
    HlsShow()
  endif
enddef

# }}}

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
