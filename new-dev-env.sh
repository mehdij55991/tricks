#!/bin/bash
set -e

if [ ! -d ~/dockerfiles ]; then
    git clone git@github.com:cyb70289/dockerfiles ~/dockerfiles
fi
cd ~/dockerfiles/dev/base

cp files/tmux.conf ~/.tmux.conf
cp files/vimrc ~/.vimrc
cp files/gitconfig ~/.gitconfig
mkdir -p ~/.vim/colors/
cp files/zenburn.vim ~/.vim/colors/

sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc

sudo update-alternatives --set editor /usr/bin/vim.basic

echo
echo === To install docker ====================================================
echo ~/dockerfiles/dev/base/helper/install-docker.sh "all|client"
echo
echo === To install golang ====================================================
echo ~/dockerfiles/dev/base/helper/install-golang.sh [version]
echo
echo === To develope k8s ======================================================
echo ~/dockerfiles/dev/base/helper/init-k8s-dev.sh
echo
echo === To build dev docker ==================================================
echo mkdir -p ~/share
echo chmod 777 ~/share
echo docker build -t cyb-dev-base ~/dockerfiles/dev/base
echo docker run -id --name cyb-dev --hostname cyb-dev --network host --cap-add SYS_ADMIN --cap-add=SYS_PTRACE --security-opt apparmor=unconfined --security-opt seccomp=unconfined --shm-size=256m -v /var/run/docker.sock:/var/run/docker.sock -v ~/share:/home/cyb/share cyb-dev-base
