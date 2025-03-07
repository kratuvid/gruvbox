vim9script
# -----------------------------------------------------------------------------
# File: gruvbox.vim
# Description: Retro groove color scheme for Airline
# Author: morhetz <morhetz@gmail.com>
# Source: https://github.com/morhetz/gruvbox
# Last Modified: 08 Mar 2025
# Ported By: kratuvid <ray779@tuta.io>
# -----------------------------------------------------------------------------

g:airline#themes#gruvbox#palette = {}

export def Refresh()
  const M0 = airline#themes#get_highlight('Identifier')
  const accents_group = airline#themes#get_highlight('Special')
  const modified_group = [M0[0], '', M0[2], '', '']
  const warning_group = airline#themes#get_highlight2(['Normal', 'bg'], ['Question', 'fg'])
  const error_group = airline#themes#get_highlight2(['Normal', 'bg'], ['WarningMsg', 'fg'])

  const N1 = airline#themes#get_highlight2(['Normal', 'bg'], ['StatusLineNC', 'bg'])
  const N2 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['Pmenu', 'bg'])
  const N3 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['CursorLine', 'bg'])
  g:airline#themes#gruvbox#palette.normal = airline#themes#generate_color_map(N1, N2, N3)
  g:airline#themes#gruvbox#palette.normal_modified = { 'airline_c': modified_group }
  g:airline#themes#gruvbox#palette.normal.airline_warning = warning_group
  g:airline#themes#gruvbox#palette.normal_modified.airline_warning = warning_group
  g:airline#themes#gruvbox#palette.normal.airline_error = error_group
  g:airline#themes#gruvbox#palette.normal_modified.airline_error = error_group

  const I1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Identifier', 'fg'])
  const I2 = N2
  const I3 = airline#themes#get_highlight2(['Normal', 'fg'], ['Pmenu', 'bg'])
  g:airline#themes#gruvbox#palette.insert = airline#themes#generate_color_map(I1, I2, I3)
  g:airline#themes#gruvbox#palette.insert_modified = g:airline#themes#gruvbox#palette.normal_modified
  g:airline#themes#gruvbox#palette.insert.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.insert_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.insert.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.insert_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  const R1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Structure', 'fg'])
  const R2 = I2
  const R3 = I3
  g:airline#themes#gruvbox#palette.replace = airline#themes#generate_color_map(R1, R2, R3)
  g:airline#themes#gruvbox#palette.replace_modified = g:airline#themes#gruvbox#palette.normal_modified
  g:airline#themes#gruvbox#palette.replace.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.replace_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.replace.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.replace_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  const V1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Question', 'fg'])
  const V2 = N2
  const V3 = airline#themes#get_highlight2(['Normal', 'bg'], ['TabLine', 'fg'])
  g:airline#themes#gruvbox#palette.visual = airline#themes#generate_color_map(V1, V2, V3)
  g:airline#themes#gruvbox#palette.visual_modified = { 'airline_c': [ V3[0], '', V3[2], '', '' ] }
  g:airline#themes#gruvbox#palette.visual.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.visual_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.visual.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.visual_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  const IA = airline#themes#get_highlight2(['TabLine', 'fg'], ['CursorLine', 'bg'])
  g:airline#themes#gruvbox#palette.inactive = airline#themes#generate_color_map(IA, IA, IA)
  g:airline#themes#gruvbox#palette.inactive_modified = { 'airline_c': modified_group }

  g:airline#themes#gruvbox#palette.accents = { 'red': accents_group }

  const TF = airline#themes#get_highlight2(['Normal', 'bg'], ['Normal', 'bg'])
  g:airline#themes#gruvbox#palette.tabline = {
    'airline_tab': N2,
    'airline_tabsel': N1,
    'airline_tabtype': V1,
    'airline_tabfill': TF,
    'airline_tabhid': IA,
    'airline_tabmod': I1
  }
enddef
g:airline#themes#gruvbox#refresh = Refresh

Refresh()

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
