
" If you are distributing this theme, please replace this comment
" with the appropriate license attributing the original VS Code
" theme author.


" Unknown Theme - A nice dark theme

" ==========> Reset
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'unknown-theme'

" ==========> Highlight function
function! s:h(face, guibg, guifg, ctermbg, ctermfg, gui)
  let l:cmd="highlight " . a:face
  
  if a:guibg != ""
    let l:cmd = l:cmd . " guibg=" . a:guibg
  endif

  if a:guifg != ""
    let l:cmd = l:cmd . " guifg=" . a:guifg
  endif

  if a:ctermbg != ""
    let l:cmd = l:cmd . " ctermbg=" . a:ctermbg
  endif

  if a:ctermfg != ""
    let l:cmd = l:cmd . " ctermfg=" . a:ctermfg
  endif

  if a:gui != ""
    let l:cmd = l:cmd . " gui=" . a:gui
  endif

  exec l:cmd
endfun


" ==========> Colors dictionary

" GUI colors dictionary (hex)
let s:hex = {}
" Terminal colors dictionary (256)
let s:bit = {}

let s:hex.color0="#272822"
let s:hex.color1="#f8f8f2"
let s:hex.color2="#f8f8f0"
let s:hex.color3="#54554f"
let s:hex.color4="#31322c"
let s:hex.color5="#595a54"
let s:hex.color6="#3b3c36"
let s:hex.color7="#6d6e68"
let s:hex.color8="#55574d"
let s:hex.color9="#6e7066"
let s:hex.color10="#72736d"
let s:hex.color11="#92ce1a"
let s:hex.color12="#454640"
let s:hex.color13="#ffffff"
let s:hex.color14="#fffffc"
let s:hex.color15="#4a4b45"
let s:hex.color16="#88846f"
let s:hex.color17="#AE81FF"
let s:hex.color18="#F8F8F2"
let s:hex.color19="#A6E22E"
let s:hex.color20="#F92672"
let s:hex.color21="#E6DB74"

let s:bit.color10="101"
let s:bit.color7="112"
let s:bit.color11="141"
let s:bit.color12="148"
let s:bit.color14="186"
let s:bit.color13="197"
let s:bit.color9="231"
let s:bit.color0="235"
let s:bit.color3="236"
let s:bit.color5="237"
let s:bit.color8="238"
let s:bit.color2="239"
let s:bit.color4="240"
let s:bit.color6="242"
let s:bit.color1="255"


" ==========> General highlights 
call s:h("Normal", s:hex.color0, s:hex.color1, s:bit.color0, s:bit.color1, "none")
call s:h("Cursor", s:hex.color2, "", s:bit.color1, "", "none")
call s:h("Visual", s:hex.color3, "", s:bit.color2, "", "none")
call s:h("ColorColumn", s:hex.color4, "", s:bit.color3, "", "none")
call s:h("LineNr", "", s:hex.color5, "", s:bit.color4, "none")
call s:h("CursorLine", s:hex.color6, "", s:bit.color5, "", "none")
call s:h("CursorLineNr", "", s:hex.color7, "", s:bit.color6, "none")
call s:h("CursorColumn", s:hex.color6, "", s:bit.color5, "", "none")
call s:h("StatusLineNC", s:hex.color8, "", s:bit.color4, "", "none")
call s:h("StatusLine", s:hex.color9, "", s:bit.color6, "", "none")
call s:h("VertSplit", "", s:hex.color10, "", s:bit.color6, "none")
call s:h("Folded", s:hex.color6, s:hex.color11, s:bit.color5, s:bit.color7, "none")
call s:h("Pmenu", s:hex.color12, s:hex.color13, s:bit.color8, s:bit.color9, "none")
call s:h("PmenuSel", s:hex.color4, s:hex.color14, s:bit.color3, s:bit.color9, "none")
call s:h("EndOfBuffer", s:hex.color0, s:hex.color15, s:bit.color0, s:bit.color8, "none")
call s:h("NonText", s:hex.color0, s:hex.color15, s:bit.color0, s:bit.color8, "none")


" ==========> Syntax highlights
call s:h("Comment", "", s:hex.color16, "", s:bit.color10, "none")
call s:h("Constant", "", s:hex.color17, "", s:bit.color11, "none")
call s:h("Special", "", s:hex.color17, "", s:bit.color11, "none")
call s:h("Identifier", "", s:hex.color18, "", s:bit.color1, "none")
call s:h("Function", "", s:hex.color19, "", s:bit.color12, "none")
call s:h("Statement", "", s:hex.color20, "", s:bit.color13, "none")
call s:h("PreProc", "", s:hex.color20, "", s:bit.color13, "none")
call s:h("Type", "", s:hex.color20, "", s:bit.color13, "none")
call s:h("String", "", s:hex.color21, "", s:bit.color14, "none")
call s:h("Number", "", s:hex.color17, "", s:bit.color11, "none")

highlight link cStatement Statement
highlight link cSpecial Special


" Generated using https://github.com/nice/themeforge
" Feel free to remove the above URL and this line.
