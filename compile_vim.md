# 源码编译VIM

## 依赖软件
centos: yum install libXt-devel gtk2-devel

## 下载源码
git clone https://github.com/vim/vim

## 修改configure文件
将下面的内完全替换configure内容

该内容让VIM支持python3，lua，ruby
```

#! /bin/sh

# This is just a stub for the Unix configure script, to provide support for
# doing "./configure" in the top Vim directory.

cd "${SRCDIR:-src}" && exec ./configure \
                            --enable-multibyte \
                            --enable-perlinterp=dynamic \
                            --enable-rubyinterp=dynamic \
                            --with-ruby-command=/usr/bin/ruby \
                            --enable-pythoninterp=yes \
                            --with-python-config-dir=/usr/lib/python2.7/config \
                            --enable-luainterp \
                            --with-lua-prefix=/usr/local \
                            --with-luajit=yes \
                            --enable-cscope \
                            --enable-gui=auto \
                            --with-features=huge \
                            --enable-fontset \
                            --enable-largefile \
                            --disable-netbeans \
                            --with-compiledby="sky-big" \
                            --enable-fail-if-missing

```

## 执行命令

./configure && make && make install
