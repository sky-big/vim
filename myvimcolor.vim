" myvimcolor - Full Colour and 256 Colour
" email : 491321720@qq.com
" author : xxw
" Hex colour conversion functions borrowed from the theme "Desert256""

" ------------------------------        高亮语法组     ----------------------------------------
" Comment                       任何注释
" Constant                      任何常数
        " String                                        字符串常数
        " Character                                     一个字符常数
        " Number                                        一个数字常数
        " Boolean                                       一个布尔型常数
        " Float                                         一个浮点常数
" Identifier                    任何变量名
        " Function                                      函数名
" Statement                     任何语句
        " Conditional                                   if then else endif等
        " Repeat                                        for do while等
        " Label                                         case default等
        " Operator                                      sizeof + *等
        " Keyword                                       任何其它关键字
        " Exception                                     try catch throw
" Preproc                       通用预处理命令
        " Include                                       预处理命令#include
        " Define                                        预处理命令#define
        " Macro                                         等同于Define
        " PreCondit                                     预处理命令#if #else 等

" Default GUI Colours
let s:foreground            =           "C5C8C6"
let s:background            =           "16191C"
let s:selection             =           "6B6865"
let s:line                  =           "23282D"
let s:comment               =           "808F80"
let s:light_green           =           "82ECA5"
let s:orange                =           "F99157"
let s:yellow                =           "FFCC66"
let s:chartreuse            =           "B9CA4A"
let s:light_red             =           "F2777A"
let s:blue                  =           "99CCCC"
let s:cyan                  =           "2DE3FE"
let s:window                =           "4D5057"
let s:purple                =           "AE81FF"        " 紫色(主要是数字等特殊字)
let s:green                 =           "00FF00"        " 深绿
let s:red                   =           "FF0000"        " 深红
let s:specialred            =           "F92672"        " 语言保留字(浅红色)
let s:specialgreen          =           "A6E22E"        " 函数名
let s:gray                  =           "545454"        " 注释

" Console 256 Colours
if !has("gui_running")
	let s:background = "252525"
	let s:window = "5e5e5e"
	let s:line = "3a3a3a"
	let s:selection = "585858"
end

set background=dark
highlight clear
syntax reset

let g:colors_name = "myvimcolor"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi! " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi! " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi! " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
    " 编辑区一般文本前景和背景色的颜色配置
	call <SID>X("Normal", s:foreground, s:background, "")
    " 行号颜色的配置
	call <SID>X("LineNr", s:selection, "", "")
    " 非文本区(控制字符和一些特殊字符和编辑器空白区等)颜色的配置
	call <SID>X("NonText", s:selection, "", "")
	call <SID>X("SpecialKey", s:selection, "", "")
    " 最近搜索模式匹配的单词的高亮颜色配置
	call <SID>X("Search", s:background, s:light_red, "")
	call <SID>X("TabLine", s:foreground, s:background, "reverse")
	call <SID>X("StatusLine", s:window, s:yellow, "reverse")
	call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
	call <SID>X("VertSplit", s:window, s:window, "none")
    " 圈选区的高亮颜色配置
	call <SID>X("Visual", "", s:selection, "")
    " 目录名的高亮颜色配置
	call <SID>X("Directory", s:blue, "", "")
	call <SID>X("ModeMsg", s:chartreuse, "", "")
	call <SID>X("MoreMsg", s:chartreuse, "", "")
	call <SID>X("Question", s:chartreuse, "", "")
	call <SID>X("WarningMsg", s:light_green, "", "")
	call <SID>X("MatchParen", "", s:selection, "")
    " 折叠行的颜色配置
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("FoldColumn", "", s:background, "")
	if version >= 700
        " 高亮当前光标的行
		call <SID>X("CursorLine", "", s:line, "none")
        " 高亮当前光标的列
		call <SID>X("CursorColumn", "", s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
	end
	if version >= 703
        " 高亮当前光标的列
		call <SID>X("ColorColumn", "", s:line, "none")
	end

	" Standard Highlighting
    " 注释的颜色配置
	call <SID>X("Comment", s:gray, "", "")
    " 程序要做的提醒的颜色配置
	call <SID>X("Todo", s:comment, s:background, "")
    " 标题的颜色配置
	call <SID>X("Title", s:comment, "", "")
    " 变量标示符的颜色配置
	call <SID>X("Identifier", s:yellow, "", "none")
    " 编程语言的声明，一般像if and while 这样的关键字
	call <SID>X("Statement", s:specialred, "", "")
	call <SID>X("Conditional", s:specialred, "", "")
	call <SID>X("Repeat", s:specialred, "", "")
	call <SID>X("Structure", s:cyan, "", "")
    " 函数名的颜色高亮配置
	call <SID>X("Function", s:purple, "", "")
    " 变量的颜色高亮配置(例如数字.引号内字符串.布尔值)
	call <SID>X("Constant", s:purple, "", "")
	call <SID>X("String", s:specialgreen, "", "")
    " 特殊符号的颜色高亮配置(通常是类似字符串中的"\n")
	call <SID>X("Special", s:foreground, "", "")
    " 预处理的颜色高亮配置(例如c语言中的#include)
	call <SID>X("PreProc", s:cyan, "", "")
	call <SID>X("Operator", s:light_red, "", "none")
    " 变量类型，例如int等的高亮颜色配置
	call <SID>X("Type", s:blue, "", "none")
	call <SID>X("Define", s:cyan, "", "none")
	call <SID>X("Include", s:blue, "", "")
	"call <SID>X("Ignore", "666666", "", "")

	" Vim Highlighting
    " Vim关键字的颜色高亮配置
	call <SID>X("vimCommand", s:light_green, "", "none")

	" C Highlighting
	call <SID>X("cType", s:yellow, "", "")
	call <SID>X("cStorageClass", s:cyan, "", "")
	call <SID>X("cConditional", s:cyan, "", "")
	call <SID>X("cRepeat", s:cyan, "", "")

	" PHP Highlighting
	call <SID>X("phpVarSelector", s:light_green, "", "")
	call <SID>X("phpKeyword", s:cyan, "", "")
	call <SID>X("phpRepeat", s:cyan, "", "")
	call <SID>X("phpConditional", s:cyan, "", "")
	call <SID>X("phpStatement", s:cyan, "", "")
	call <SID>X("phpMemberSelector", s:foreground, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:chartreuse, "", "")
	call <SID>X("rubyConstant", s:yellow, "", "")
	call <SID>X("rubyAttribute", s:blue, "", "")
	call <SID>X("rubyInclude", s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
	call <SID>X("rubyCurlyBlock", s:orange, "", "")
	call <SID>X("rubyStringDelimiter", s:chartreuse, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional", s:cyan, "", "")
	call <SID>X("rubyRepeat", s:cyan, "", "")

	" Python Highlighting
	call <SID>X("pythonInclude", s:cyan, "", "")
	call <SID>X("pythonStatement", s:cyan, "", "")
	call <SID>X("pythonConditional", s:cyan, "", "")
	call <SID>X("pythonFunction", s:blue, "", "")

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:foreground, "", "")
	call <SID>X("javaScriptFunction", s:cyan, "", "")
	call <SID>X("javaScriptConditional", s:cyan, "", "")
	call <SID>X("javaScriptRepeat", s:cyan, "", "")
	call <SID>X("javaScriptNumber", s:orange, "", "")
	call <SID>X("javaScriptMember", s:orange, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:light_green, "", "")
	call <SID>X("htmlTagName", s:light_green, "", "")
	call <SID>X("htmlArg", s:light_green, "", "")
	call <SID>X("htmlScriptTag", s:light_green, "", "")

	" Diff Highlighting
    " diff模式下的高亮
	call <SID>X("diffAdded", s:chartreuse, "", "")
	call <SID>X("diffRemoved", s:light_green, "", "")

endif

"======================================================== 
" Highlight All Class Name
"======================================================== 
syn match cppClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
hi cppClass guifg=#00FF00 cterm=bold ctermfg=yellow
call <SID>X("cppClass", s:specialgreen, "", "")

syn match NormalFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match NormalFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
highlight! NormalFunctions guifg=#FF0000 cterm=bold ctermfg=yellow
call <SID>X("NormalFunctions", s:specialred, "", "")

" 高亮特殊的关键字
syntax keyword SpecialKey return new when
call <SID>X("SpecialKey", s:blue, "", "")

" 高亮true和false
syntax keyword BoolKey true false
highlight BoolKey guifg=#F92672 cterm=bold ctermfg=yellow
call <SID>X("BoolKey", s:specialred, "", "")

" Delete Functions
delf <SID>X
delf <SID>rgb
delf <SID>colour
delf <SID>rgb_colour
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_colour
delf <SID>grey_level
delf <SID>grey_number
