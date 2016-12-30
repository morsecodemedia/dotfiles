#!/bin/sh
set -e # exit on any nonzero command

# Command Line Tools

xcode-select --install
sleep 1
osascript <<EOD
  tell application "System Events"
    tell process "Install Command Line Developer Tools"
      keystroke return
      click button "Agree" of window "License Agreement"
    end tell
  end tell
EOD

# Clean up Default Files

if [ -f "$HOME/.profile" ]; then 
	rm "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]; then 
	rm "$HOME/.bashrc"
fi

if [ -f "$HOME/.bash_profile" ]; then 
	rm "$HOME/.bash_profile"
fi

if [ -f "$HOME/.localrc" ]; then 
	rm "$HOME/.localrc"
fi

if [ -f "$HOME/.bash_logout" ]; then 
	rm "$HOME/.bash_logout"
fi

if [ -f "$HOME/.viminfo" ]; then 
	rm "$HOME/.viminfo"
fi

### Homebrew

if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update && brew upgrade

### Taps 

brew tap homebrew/bundle
brew tap caskroom/cask
brew install Caskroom/cask/xquartz
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/dupes
brew tap homebrew/dupes/grep
brew tap homebrew/php
brew tap homebrew/completions

### System Utilities

brew install wget
brew install coreutils
brew install findutils
brew install gnu-getopt
brew install gnu-sed --default-names

# Bash 
brew install bash
brew install bash-completion

### Programing Languages

# Java
brew cask install java

# Python
brew install python --with-brewed-openssl
pip install --upgrade setuptools 
pip install --upgrade pip
pip install --user pyyaml
pip install --user colorama
pip install rtv
pip install qrcode

# Ruby
brew install rbenv
brew install ruby-build
rbenv install 2.3.0
rbenv rehash
rbenv global 2.3.0
rbenv rehash
gem install bundler

# Perl
\curl -L http://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc
perlbrew install perl-5.16.0
perlbrew switch perl-5.16.0

# Node
brew install node
npm install -g grunt-cli

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

### Git

brew install git git-flow-avh bash-completion gnu-getopt
curl https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/git-flow-completion.bash > git-flow-completion.bash
chmod 755 git-flow-completion.bash
mv git-flow-completion.bash ~/.git-flow-completion.sh
brew install tig

### Vim

brew install vim --with-python3 --with-tcl --with-perl --override-system-vi
brew install vimpager


### Utilities

brew install tmux
brew install reattach-to-user-namespace
brew install jq
brew install ssh-copy-id
brew install awscli
brew install calc
brew install libvpx
brew install ffmpeg --with-libvpx
brew install gpg
brew install hub
brew install htop
brew install imagemagick
brew install keybase
brew install lynx
brew install mas
brew install node
brew install p7zip
brew install stow
brew install tree
brew install youtube-dl

### Completions 

brew install bundler-completion
brew install gem-completion
brew install grunt-completion
brew install pip-completion
brew install vagrant-completion

### Quicklook

brew cask install betterzipql
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlstephen
brew cask install quicklook-csv
brew cask install quicklook-json

### Apps

brew cask install 1password
brew cask install bittorrent
brew cask install alfred
brew cask install coda
brew cask install dropbox
brew cask install evernote
brew cask install filezilla
brew cask install firefox
brew cask install google-chrome
brew cask install gdrive
brew cask install handbrakecli
brew cask install iterm2
brew cask install mou
brew cask install namechanger
brew cask install plex-media-server
brew cask install screaming-frog-seo-spirder
brew cask install sequel-pro
brew cask install screencloud
brew cask install skype
brew cask install slack
brew cask install sourcetree
brew cask install spotify
brew cask install tunnelblick
brew cask install vagrant
brew cask install vagrant-manager
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc

### Install Mac App Store apps

# FlyCut
mas install 442160987

# Integrity
mas install 513610341 

# Microsoft Remote Desktop
mas install 715768417


### Folder Structures

mkdir -p ~/Sites/system/
mkdir -p ~/Sites/work/
mkdir -p ~/Sites/personal/

