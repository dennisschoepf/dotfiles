syntax match Heading    /^===.*/
syntax match Subheading /^>\s.*/
syntax match CustomTodo /^\s*\-\s(\s).*/
syntax match CustomTodoFi /^\s*\-\s(x).*/

highlight Heading      ctermfg=LightYellow guifg=#f5a97f
highlight Subheading   ctermfg=LightRed    guifg=#f4dbd6
highlight CustomTodo   ctermfg=Green       guifg=#b7bdf8
highlight CustomTodoFi ctermfg=LightGray   guifg=#a5adcb
