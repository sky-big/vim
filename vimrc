set hlsearch        "高亮搜索
set incsearch       "在输入要搜索的文字时，实时匹配

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
    syntax on
endif

" set mouse=a                    " 在任何模式下启用鼠标
set t_Co=256                   " 在终端启用256色
set backspace=2                " 设置退格键可用

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" PluginList             -列举列表(也就是.vimrc)中配置的所有插件  
" PluginInstall          -安装列表中的全部插件  
" PluginInstall!         -更新列表中的全部插件  
" PluginSearch foo       -查找foo插件  
" PluginSearch! foo      -刷新foo插件缓存  
" PluginClean            -清除列表中没有的插件  
" PluginClean!           -清除列表中没有的插件  

set nocompatible                                      "禁用 Vi 兼容模式
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" 使用Vundle来管理Vundle，这个必须要有。
Plugin 'gmarik/vundle'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
" （Github网站上非vim-scripts仓库的插件，按下面格式填写）
Plugin 'jiangmiao/auto-pairs'
Plugin 'Yggdroot/indentLine'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/deol.nvim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'msanders/snipmate.vim'
Plugin 'wesleyche/SrcExpl'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'jimenezrick/vimerl'
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " go language plugin
Plugin 'ianva/vim-youdao-translater'

"（vim-scripts仓库里的，按下面格式填写）
Plugin 'a.vim'
Plugin 'Align'
Plugin 'ccvext.vim'
Plugin 'cSyntaxAfter'
Plugin 'Mark--Karkat'
Plugin 'OmniCppComplete'
Plugin 'repeat.vim'
Plugin 'std_c.zip'
Plugin 'taglist.vim'
Plugin 'TxtBrowser'
Plugin 'ZoomWin'
Plugin 'L9'
Plugin 'matrix.vim'

call vundle#end()

filetype plugin indent on

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
" set foldmethod=marker                                "marker 折叠方式
set t_Co=256                                          "指定配色方案为256色

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nnoremap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nnoremap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 800 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
" set guifont=YaHei_Consolas_Hybrid:h10                 "设置字体:字号（字体名称空格用下划线代替）
set wrap                                              "设置自动换行
set shortmess=atI                                     "去掉欢迎界面

syntax enable                                         "打开语法高亮功能,只为没有设置过高亮的组定义颜色
syntax on                                             "启动vim默认语法高亮
" syntax off                                            "关闭vim开启默认高亮

colorscheme myvimcolor                              "终端配色方案

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                              "设置无临时文件
" set vb t_vb=                                "关闭提示音

" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < Align 插件配置 >
" -----------------------------------------------------------------------------
" 一个对齐的插件，用来——排版与对齐代码，功能强大，不过用到的机会不多

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
" 所以我就没有加入echofunc插件

" -----------------------------------------------------------------------------
"  < ccvext.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于对指定文件自动生成tags与cscope文件并连接
" 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
" 如果是Linux系统, 则生成的文件在~/.symbs/目录下
" 具体用法可参考www.vim.org中此插件的说明
" <Leader>sy 自动生成tags与cscope文件并连接
" <Leader>sc 连接已存在的tags与cscope文件

" -----------------------------------------------------------------------------
"  < cSyntaxAfter 插件配置 >
" -----------------------------------------------------------------------------
" 高亮括号与运算符等
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()

" -----------------------------------------------------------------------------
"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 在终端上会有屏幕刷新的问题，这个问题能解决有更好了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>

" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_gui = '#A4E57E'

" -----------------------------------------------------------------------------
"  < Mark--Karkat（也就是 Mark） 插件配置 >
" -----------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt


" 用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>" 
" let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
" 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 F2 调用插件
nnoremap <F2> :NERDTreeToggle<CR>

" 高亮NERDTree窗口的当前行
let NERDTreeHighlightCursorline=1
" 显示目录的行号
let NERDTreeShowLineNumbers=1
" 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenter=1
" 是否默认显示书签列表
let NERDTreeShowBookmarks=1
" 是否默认显示文件
let NERDTreeShowFiles=1

" -----------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -----------------------------------------------------------------------------
" 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
" 说明可以参考帮助或网络教程等
" 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
" 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
set completeopt=menu                        "关闭预览窗口

" -----------------------------------------------------------------------------
"  < powerline 插件配置 >
" -----------------------------------------------------------------------------
" 状态栏插件，更好的状态栏效果
" vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令

" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀

" -----------------------------------------------------------------------------
"  < SrcExpl 插件配置 >
" -----------------------------------------------------------------------------
" 增强源代码浏览，其功能就像Windows中的"Source Insight"
nnoremap <F3> :SrcExplToggle<CR>                "打开/闭浏览窗口

" -----------------------------------------------------------------------------
"  < supertab 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于配合 omnicppcomplete 插件，在按 Tab 键时自动补全效果更好更快
let g:supertabdefaultcompletiontype = "<c-x><c-u>"
let g:supertabdefaultcompletiontype = "<c-n>"

" -----------------------------------------------------------------------------
"  < std_c 插件配置 >
" -----------------------------------------------------------------------------
" 用于增强C语法高亮

" 启用 // 注视风格
let c_cpp_comments = 0

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
"  < Syntastic 插件配置 >
" -----------------------------------------------------------------------------
" 用于保存文件时查检语法

" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
nnoremap tb :TlistClose<CR>:TagbarToggle<CR>

let g:tagbar_width=30                       "设置窗口宽度
" let g:tagbar_left=1                         "在左侧窗口中显示

" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

" 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
nnoremap tl :TagbarClose<CR>:Tlist<CR>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < txtbrowser 插件配置 >
" -----------------------------------------------------------------------------
" 用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
au BufRead,BufNewFile *.txt setlocal ft=txt

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 常规模式下按快捷键 <c-w>o 在最大化与还原间切换

" -----------------------------------------------------------------------------
"  < CtrlP 插件配置 >
" -----------------------------------------------------------------------------
"设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>f'
let g:ctrl_cmd = 'CtrlP'
" 使用该选项来设置自定义的根目录标记作为对默认标记
let g:ctrlp_root_markers = ['.settings','otp_versions.table']
map <leader>fp :CtrlPMRU<CR>
" 搜索窗口出现在窗口底部
let g:ctrlp_match_window_bottom=1
" 设置搜索窗口的高度
let g:ctrlp_max_height=20
let g:ctrlp_match_window_reversed=0
" 指定你希望CtrlP记录的最近打开的文件历史的数目
let g:ctrlp_mruf_max=500
" 当启动时，CtrlP依据这个变量来设置它的工作目录
let g:ctrlp_working_path_mode = 'ra'

" -----------------------------------------------------------------------------
"  < vim-go 插件配置 >
" -----------------------------------------------------------------------------
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:godef_split=2
" 设置使用不用的插件进行不全
let g:go_def_mode = 'godef'

" go跳转命令重定向
nnoremap <silent> gl :GoDef<cr>
nnoremap <silent> gh :<C-U>call go#def#StackPop(v:count1)<cr>

" -----------------------------------------------------------------------------
"  < vim-youdao-translater 插件配置 >
" -----------------------------------------------------------------------------
vnoremap <silent> tt :<C-u>Ydv<CR>
nnoremap <silent> tt :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
if has("cscope")
    "设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
    "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "快捷键设置
    nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

" -----------------------------------------------------------------------------
"  < vimerl 工具配置 > 用于编写Erlang代码的插件
" -----------------------------------------------------------------------------
" ErlangApplication 生成一个行为模式为OTP应用程序行的框架。
" ErlangSupervisor 生成一个行为模式为OTP监督树的框架。
" ErlangGen[Server|Fsm|Event] 生成gen_server，fsm，event框架。
let g:erlangManPath="/usr/local/lib/erlang/man" 
let g:erlangHighlightBif = 1

" -----------------------------------------------------------------------------
"  < neocomplete配置 >
" -----------------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" -----------------------------------------------------------------------------
"  < deol配置 >
" -----------------------------------------------------------------------------
nnoremap <silent> sh :Deol<cr>

" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

" 全局搜索当前光标下的字符串
" <Bar> 相当于 |
nnoremap <C-G> :execute "let g:word=expand(\"<cword>\")"<Bar>execute "vimgrep /\\<" . g:word . "\\>/g 
            " \ **/.*[ch] **/*.cpp"
            \<Bar>execute "cc 1"<Bar>execute "cw"<CR>

" =============================================================================
"                          << 其它 >>
" =============================================================================

" 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键
"

" ===================================  vimscript脚本的学习练习  =============
" 映射<leader> 快捷键
let mapleader = ","

" 快速的编辑自己的vim配置文件
nnoremap <leader>ev :split $MYVIMRC<cr>

" 快速的加载自己的vim配置文件
nnoremap <leader>sv :source $MYVIMRC<cr>

" 空格选中对应的单词
nnoremap <space> viw

" p movements 的映射
onoremap p i(

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" grep测试
" nnoremap <leader>g :execute "grep -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" 切换选项
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

function! s:FoldColumnToggle()

    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif

endfunction

" quickfix 窗口的切换
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

" 在插入模式下删除一行文本,如同Eclipse中的删除一行文本的功能
inoremap <c-d> <Esc>ddi

" 在常规模式下让字母大小写切换
nnoremap <c-u> vU

" 在插入模式下面将当前光标下面的单词转化为大写字母
inoremap <c-u> <Esc>hviwUA

" 在可视模式下面使用引号包裹高亮选中的文本
vnoremap <leader>" <Esc>'<i"<Esc>ea"<Esc>

" H在normal模式下移动到当前行的行首
nnoremap <leader>H 0

" L在normal模式下移动到当前行的行末
nnoremap <leader>L $

" 取消一个映射<nop> == no operation
" inoremap <Esc> <nop>

" 快捷键条用该语法开启或者关闭函数
nnoremap <silent> <leader>s :call ToggleSyntax()<CR>

" 设置历史命令的存储上限数量
set history=1000

" 命令行中的上下移动快捷键的映射
" cnnoremap <C-p> <Up>
" cnnoremap <C-n> <Down>

" 取消光标键的作用(在Vim编辑中)
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
