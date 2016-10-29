#!/bin/sh

# setup directory needed

# emacs 
mkdir -p $HOME/.emacs.d > /dev/null 2>&1
cp -r ./site-lisp $HOME/.emacs.d/
cp ./dotfiles/emacs-conf-mac $HOME/.emacs

# vim
mkdir -p $HOME/.vim > /dev/null 2>&1
cp -r ./dotfiles/vimrc/* $HOME/.vim
cp ./dotfiles/vimrc/vimrc $HOME/.vim
cp -r ./dotfiles/git-completion.bash $HOME/.git-completion.bash
