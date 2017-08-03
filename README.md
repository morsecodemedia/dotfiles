## Dotfiles

----
### What is this?

Dotfiles are configuration files in Unix systems that start with a dot (think of *.gitignore*). The preceeding "dot" is an indication for normal users that these files are not regular documents, and by default are hidden in directory listings.

### Why is it useful?

You can set up a new system using dotfiles and an installation script in minutes. It's not hard to get started with your own repository, but I would recommend checking out some [existing projects](https://dotfiles.github.io/). Read through the setups, the reasonings for each configuration and some of that project's inspirations. There is a lot to learn along this road. For me, this truly was more about the journey than the destination.

### How do I use it?

#### Dependancies
This install is required to have GNU Stow installed. Stow is a symlink farm manager, you can read more about it [here](https://www.gnu.org/software/stow/).

		brew install stow
	-- or --
		sudo apt-get install stow

Once you have Stow installed and you've cloned the repo...

		$ make
Thanks to [James Tomasino](https://github.com/jamestomasino/dotfiles), the Makefile will attempt to determine your platform and install the correct files. You do have the option to specify the platform specifically `make OSX`.

#### OSX Setup
Currently, I've only implemented a setup script of OSX. For fresh machines, you should be able to run the setup directly, in which it will run the system setup, install a variety of applications, pull these dotfiles and run the setup.
**Turning Off Rootless System Integrity Protection in Mac OS X:** We can't automate this, but you can read more about the commands you will need to run here: http://osxdaily.com/2015/10/05/disable-rootless-system-integrity-protection-mac-os-x/
After you disable the integrity protection, install Xcode. Once you get Xcode installed, you can run the following command.

		curl https://raw.githubusercontent.com/morsecodemedia/dotfiles/master/osx/osx.sh | bash

----
### Credits ###

- [James Tomasino](https://github.com/jamestomasino/dotfiles): James is my original inspiration for creating my own set of dotfiles, but also to become more efficient in the command line over the years.
- [Zach Holman](https://github.com/holman/dotfiles): For a great breakdown of why to have your dotfiles topic centric.
- [Dries Vints](https://github.com/driesvints/dotfiles): Dries's Brewfile was the original draw/inspiration for mine, and then I expanded based on his influences and others that I've come across over time. *Although I've since removed the Brewfile from my setup, a lot of the learnings I gained from Dries was transferred to what I've currently ended up with.*
- [Maxime Fabre](https://github.com/Anahkiasen/dotfiles): A verbose setup of OSX configurations.

----
### TODO: ###
- [ ] Install script for Linux
- [ ] Install script for Windows
- [ ] Get smarter, become better.