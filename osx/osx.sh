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
brew tap homebrew/php
brew tap homebrew/completions

### System Utilities

brew install wget
brew install coreutils
brew install findutils
brew install binutils
brew install diffutils
brew install gnutls
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install grep --with-default-names
brew install bash
brew install make
brew install less

# Bash
brew install spellcheck
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
rbenv install 2.4.1
rbenv rehash
rbenv global 2.4.1
rbenv rehash
gem install bundler

# Perl
curl -L http://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc
perlbrew install perl-5.16.0
perlbrew switch perl-5.16.0

# Node
brew install node
npm install -g grunt-cli
npm install -g jshint
npm install -g standard
npm install -g jsonlint
npm install -g gulp

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

### Git

brew install git git-flow-avh gnu-getopt
curl https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/git-flow-completion.bash > git-flow-completion.bash
chmod 755 git-flow-completion.bash
mv git-flow-completion.bash ~/.git-flow-completion.sh
brew install tig

### Vim

brew install vim --with-python3 --with-tcl --with-perl --with-override-system-vi
brew install vimpager

### Utilities

brew install tmux
brew install reattach-to-user-namespace
brew install jq
brew install ssh-copy-id
brew install awscli
brew install unrar
brew install calc
brew install libvpx
brew install ffmpeg --with-libvpx --with-theora --with-libvorbis --with-fdk-aac --with-tools --with-freetype --with-libass --with-libvpx --with-x265
brew install gpg
brew install gpgtools
brew install hub
brew install htop
brew install imagemagick
brew install keybase
brew install lynx
brew install mas
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

### Device Agnostic Apps
brew cask install 1password
brew cask install alfred
brew cask install dropbox
brew cask install evernote
brew cask install filezilla
brew cask install firefox
brew cask install google-chrome
brew cask install gdrive
brew cask install gpgtools
brew cask install iterm2
brew cask install mou
brew cask install screaming-frog-seo-spider
brew cask install sequel-pro
brew cask install skype
brew cask install slack
brew cask install slate
brew cask install sourcetree
brew cask install vagrant
brew cask install vagrant-manager
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc

### Personal Device Apps
echo "There are additional applications I would like to install if this is a personal device. Would you like these applications?(yes/no)"
read input
if [ "$input" = "yes" ]; then
	brew cask install bittorrent
	brew cask install handbrakecli
	brew cask install namechanger
	brew cask install plex-media-server
	brew cask install tunnelblick
fi

### Install Mac App Store apps
brew install mas

# FlyCut
mas install 442160987

# Integrity
mas install 513610341

# Microsoft Remote Desktop
mas install 715768417

# Wire
mas install 931134707

### Folder Structures

mkdir -p ~/Sites/system/
mkdir -p ~/Sites/work/
mkdir -p ~/Sites/personal/
mkdir -p ~/Sites/sync/Dropbox
mkdir -p ~/.dropbox
ln -s ~/Sites/sync/Dropbox ~/.dropbox/Dropbox
mkdir -p ~/Documents/receipts/

### Dotfiles

cd ~/Sites/system && git clone https://github.com/morsecodemedia/dotfiles.git
cd ~/Sites/system/dotfiles && ./make

### Install Plugins

vim -c ":PlugInstall|q|q" # auto install plugins
$HOME/.tmux/plugins/tpm/bin/install_plugins

brew install gpg

### OSX setup

# Ask for admin password upfront
sudo -v

# Keepalive for sudo until done
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set volume to 0 at boot
sudo nvram SystemAudioVolume=" "

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Store screenshots in subfolder on desktop
if [ ! -d "$HOME/Desktop/Screenshots" ]; then mkdir -p "$HOME/Desktop/Screenshots"; fi
defaults write com.apple.screencapture location "$HOME/Desktop/Screenshots"

# Disable the 'Are you sure you want to open this application?' dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Show percentage in battery status
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "NO"

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# Disable rubberband scrolling
defaults write -g NSScrollViewRubberbanding -bool false

# Disable dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Move dock to left side of screen
defaults write com.apple.dock orientation -string left

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: icnv, Nlmv, Flwv
defaults write com.apple.finder FXPreferredViewStyle -string "Nlmv"

# Remove default text from basic screen saver
defaults write ~/Library/Preferences/com.apple.ScreenSaver.Basic MESSAGE " "

# Disable sound effect when changing volume
defaults write -g com.apple.sound.beep.feedback -integer 0

# Disable user interface sound effects
defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0

# Set system sounds volume to 0
defaults write com.apple.systemsound com.apple.sound.beep.volume -float 0

# Autohide Dock
defaults write com.apple.dock autohide -bool true

# Show/Hide Dock instantly
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Disable Smart Quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable Smart Dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Set default desktop background
curl "https://free4kwallpapers.com/no-watermarks/originals/2016/01/08/star-wars-the-force-awakens-poe-rey-bb8-wallpaper.jpg" > "background.jpg"
sudo mv "background.jpg" "/Library/Desktop Pictures/swtfa01.jpg"
rm -rf "$HOME/Library/Application\ Support/Dock/desktoppicture.db"
sudo rm -rf "/System/Library/CoreServices/DefaultDesktop.jpg"
sudo ln -s "/Library/Desktop Pictures/swtfa01.jpg" "/System/Library/CoreServices/DefaultDesktop.jpg"

# Kill affected applications, so the changes apply
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done