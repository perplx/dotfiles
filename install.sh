#!/bin/sh

# TODO call diff if both files exist before copy
install()
{
	# get the function arguments
	src_file_path=$1
	dst_file_path=$2

	echo "installing $src_file_path to $dst_file_path"

	# ensure the source-file actually exists
	if [ ! -f $src_file_path ]; then
		echo "ERROR: trying to install non-existant dotfile $src_file_path"
		exit -1
	fi

	# link the dotfile to its destination path
	ln -s -i $src_file_path $dst_file_path
}

pushd $HOME
dotfiles_dir=dotfiles

# bash
install $dotfiles_dir/.bashrc .bashrc
install $dotfiles_dir/.bash_prompt .bash_prompt

## git
#install $dotfiles_dir/.gitconfig .gitconfig
#install $dotfiles_dir/.gitignore_global .gitignore_global

install $dotfiles_dir/.colordiffrc .colordiffrc
install $dotfiles_dir/.screenrc .screenrc
install $dotfiles_dir/.tmux.conf .tmux.conf
install $dotfiles_dir/.vimrc .vimrc
popd
