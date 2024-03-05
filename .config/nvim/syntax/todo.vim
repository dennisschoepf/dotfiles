syntax match Heading    /^===.*/
" syntax match Subheading /^>.*/
syntax match CustomTodo /^\s*\-\s(\s).*/
syntax match CustomTodoFi /^\s*\-\s(x).*/
syntax match CustomKind /+\S*/
syntax match CustomTag /#\S*/

highlight CustomKind   ctermfg=Gray        guifg=#ee99a0
highlight CustomTag    ctermfg=Cyan        guifg=#f5bde6
highlight Heading      ctermfg=LightYellow guifg=#f5a97f
" highlight Subheading   ctermfg=LightRed    guifg=#f4dbd6
highlight CustomTodo   ctermfg=Green       guifg=#b7bdf8
highlight CustomTodoFi ctermfg=LightGray   guifg=#a5adcb
