#!/bin/zsh

# configuration
DEFAULT_NAME="Nicolas Bevacqua"
DEFAULT_EMAIL="nicolasbevacqua@gmail.com"

read -p "Name ($DEFAULT_NAME): " NAME
NAME=${NAME:-$DEFAULT_NAME}
echo $NAME

read -p "Mail ($DEFAULT_EMAIL): " EMAIL
EMAIL=${EMAIL:-$DEFAULT_EMAIL}
echo $EMAIL


# get process working directory
pushd `dirname $0` > /dev/null
PWD=`pwd -P`
popd > /dev/null

# essentials
sudo apt-get install -y build-essential libssl-dev curl

# ruby
sudo apt-get install -y rubygems --force-yes

# pip
sudo apt-get install -y python-pip --force-yes

# gm
sudo apt-get install -yqq graphicsmagick

# gnome-do
sudo apt-get install -y gnome-do --force-yes

# mercurial
sudo apt-get install -y mercurial

# git
sudo apt-get install -y git-core
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global credential.helper store
git config --global push.default simple
git config --global branch.autosetuprebase always
git config --global color.ui auto

# git-flow
sudo apt-get install git-flow
ln -sfn $PWD/zsh/git-flow-completion.zsh ~/.git-flow-completion.zsh

# hub utility
sudo gem install hub
mkdir -p ~/bin
hub hub standalone > ~/bin/hub && chmod +x ~/bin/hub
git config --global hub.protocol https

# ssh
ln -sfn $PWD/ssh/config ~/.ssh/config

# sublime text 3
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

ln -sfn $PWD/st3/preferences ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

# zsh, fancy zsh
ln -sfn $PWD/zsh/agnork.zsh-theme ~/.oh-my-zsh/themes/agnork.zsh-theme
ln -sfn $PWD/zsh/config ~/.zshrc

# powerline
pip install --user git+git://github.com/Lokaltog/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# google web fonts
curl -L https://github.com/w0ng/googlefontdirectory/tarball/master > ~/.fonts/gwf.tar.gz
mkdir ~/.fonts/gwf
tar -zxvf ~/.fonts/gwf.tar.gz --directory ~/.fonts/gwf
fc-cache -vf ~/.fonts

# nvm
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# refresh configuration
source ~/.zshrc

# node
nvm install 0.10.22
nvm alias default 0.10.22

# npm
npm install -g bower grunt-cli nodemon jshint

# refresh configuration
source ~/.zshrc

# install development languages, clis, db engines, and so on
sh ./ubuntu/install_dev.sh

# install utility packages
sh ./ubuntu/install_utils.sh

## recommend post-install commands
echo "Use \`npm adduser\` to authenticate on npm"
echo "Use \`dpkg-reconfigure tzdata\` to pick your time zone"
echo "Use \`dpkg-reconfigure keyboard-configuration\` to pick your keyboard layout"
