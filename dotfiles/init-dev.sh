curl -fLo ~/.vimrc https://raw.githubusercontent.com/cyb70289/tricks/master/dotfiles/vimrc
curl -fLo ~/.gitconfig https://raw.githubusercontent.com/cyb70289/tricks/master/dotfiles/gitconfig
curl -fLo ~/.tmux.conf https://raw.githubusercontent.com/cyb70289/tricks/master/dotfiles/tmux.conf
curl -fLo ~/.vim/colors/zenburn.vim --create-dirs https://raw.githubusercontent.com/cyb70289/Zenburn/master/colors/zenburn.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa
rm -rf ~/.vim/colors/
