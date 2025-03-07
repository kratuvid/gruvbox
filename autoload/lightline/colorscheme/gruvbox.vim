vim9script
# -----------------------------------------------------------------------------
# File: gruvbox.vim
# Description: Gruvbox colorscheme for Lightline (itchyny/lightline.vim)
# Author: gmoe <me@griffinmoe.com>
# Source: https://github.com/morhetz/gruvbox
# Last Modified: 08 Mar 2025
# Ported By: kratuvid <ray779@tuta.io>
# -----------------------------------------------------------------------------

def GetGruvColor(group: string): list<string>
  const guiColor = synIDattr(hlID(group), "fg", "gui") 
  const termColor = synIDattr(hlID(group), "fg", "cterm") 
  return [ guiColor, termColor ]
enddef

var bg0  = []
var bg1  = []
var bg2  = []
var bg4  = []
var fg1  = []
var fg4  = []

var yellow = []
var blue   = []
var aqua   = []
var orange = []
var green = []

var p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {}}
p.normal.left = []
p.normal.right = []
p.normal.middle = []
p.inactive.right = []
p.inactive.left = []
p.inactive.middle = []
p.insert.left = []
p.insert.right = []
p.insert.middle = []
p.terminal.left = []
p.terminal.right = []
p.terminal.middle = []
p.replace.left = []
p.replace.right = []
p.replace.middle = []
p.visual.left = []
p.visual.right = []
p.visual.middle = []
p.tabline.left = []
p.tabline.tabsel = []
p.tabline.middle = []
p.tabline.right = []
p.normal.error = []
p.normal.warning = []

if exists('g:lightline')
  bg0 = GetGruvColor('GruvboxBg0')
  bg1 = GetGruvColor('GruvboxBg1')
  bg2 = GetGruvColor('GruvboxBg2')
  bg4 = GetGruvColor('GruvboxBg4')
  fg1 = GetGruvColor('GruvboxFg1')
  fg4 = GetGruvColor('GruvboxFg4')

  yellow = GetGruvColor('GruvboxYellow')
  blue   = GetGruvColor('GruvboxBlue')
  aqua   = GetGruvColor('GruvboxAqua')
  orange = GetGruvColor('GruvboxOrange')
  green  = GetGruvColor('GruvboxGreen')

  p.normal.left = [ [ bg0, fg4, 'bold' ], [ fg4, bg2 ] ]
  p.normal.right = [ [ bg0, fg4 ], [ fg4, bg2 ] ]
  p.normal.middle = [ [ fg4, bg1 ] ]
  p.inactive.right = [ [ bg4, bg1 ], [ bg4, bg1 ] ]
  p.inactive.left =  [ [ bg4, bg1 ], [ bg4, bg1 ] ]
  p.inactive.middle = [ [ bg4, bg1 ] ]
  p.insert.left = [ [ bg0, blue, 'bold' ], [ fg1, bg2 ] ]
  p.insert.right = [ [ bg0, blue ], [ fg1, bg2 ] ]
  p.insert.middle = [ [ fg4, bg2 ] ]
  p.terminal.left = [ [ bg0, green, 'bold' ], [ fg1, bg2 ] ]
  p.terminal.right = [ [ bg0, green ], [ fg1, bg2 ] ]
  p.terminal.middle = [ [ fg4, bg2 ] ]
  p.replace.left = [ [ bg0, aqua, 'bold' ], [ fg1, bg2 ] ]
  p.replace.right = [ [ bg0, aqua ], [ fg1, bg2 ] ]
  p.replace.middle = [ [ fg4, bg2 ] ]
  p.visual.left = [ [ bg0, orange, 'bold' ], [ bg0, bg4 ] ]
  p.visual.right = [ [ bg0, orange ], [ bg0, bg4 ] ]
  p.visual.middle = [ [ fg4, bg1 ] ]
  p.tabline.left = [ [ fg4, bg2 ] ]
  p.tabline.tabsel = [ [ bg0, fg4 ] ]
  p.tabline.middle = [ [ bg0, bg0 ] ]
  p.tabline.right = [ [ bg0, orange ] ]
  p.normal.error = [ [ bg0, orange ] ]
  p.normal.warning = [ [ bg2, yellow ] ]

  g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(p)
endif

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
