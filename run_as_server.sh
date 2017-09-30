#!/bin/sh

if test -e ~/.zshrc
then
    echo '\n#************added by ra1nyhouse emacs>>>>>>>>>>>' >> ~/.zshrc
    cat used_by_run_as_server.txt >> ~/.zshrc
    echo '#************added by ra1nyhouse emacs>>>>>>>>>>>' >> ~/.zshrc
    echo 'success'
else
    echo 'fail'
fi
