YELLOW = $$(tput setaf 226)
GREEN = $$(tput setaf 46)
RED = $$(tput setaf 196)
RESET = $$(tput sgr0)

ifeq ($(OS),Windows_NT)
	UNAME = Windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		UNAME = Linux
	endif
	ifeq ($(UNAME_S),Darwin)
		UNAME = OSX
	endif
	UNAME ?= Other
endif

install:
	@make $(UNAME)

OSX: bash git R utils zsh bin vim tmux weechat
Linux: bash git R utils zsh bin vim tmux gnupg weechat
Windows: bash git utils zsh bin vim tmux
Other: bash git utils zsh vim

clean:
	@printf "$(RED)--- clean -----------------------------------------------\n$(RESET)"
	stow -t "$$HOME" -D bash
	stow -t "$$HOME" -D git
	stow -t "$$HOME" -D R
	stow -t "$$HOME" -D utils
	stow -t "$$HOME" -D zsh
	stow -t "$$HOME/bin" -D bin
	stow -t "$$HOME" -D vim
	stow -t "$$HOME" -D tmux
	stow -t "$$HOME" -D gnupg
	stow -t "$$HOME/.weechat" -D weechat

bash:
	@printf "$(YELLOW)--- bash ------------------------------------------------\n$(RESET)"
	stow -t "$$HOME" bash

git:
	@printf "$(YELLOW)--- git -------------------------------------------------\n$(RESET)"
	stow -t "$$HOME" git

weechat:
	@printf "$(YELLOW)--- weechat ---------------------------------------------\n$(RESET)"
	mkdir -p "$$HOME/.weechat"
	stow -t "$$HOME/.weechat" weechat

R:
	@printf "$(YELLOW)--- R ---------------------------------------------------\n$(RESET)"

utils:
	@printf "$(YELLOW)--- utils -----------------------------------------------\n$(RESET)"
	stow -t "$$HOME" utils

zsh:
	@printf "$(YELLOW)--- zsh -------------------------------------------------\n$(RESET)"
	stow -t "$$HOME" zsh

bin:
	@printf "$(YELLOW)--- bin -------------------------------------------------\n$(RESET)"
	mkdir -p "$$HOME/bin"
	stow -t "$$HOME/bin/" bin

vim:
	@printf "$(YELLOW)--- vim -------------------------------------------------\n$(RESET)"
	stow -t "$$HOME" vim
	if [ ! -f "$$HOME/.vim/autoload/plug.vim" ]; then \
		curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi
	@printf "    $(GREEN)Launch vim and run :PlugInstall\n"

gnupg:
	@printf "$(YELLOW)--- gnupg -----------------------------------------------\n$(RESET)"
	stow -t "$$HOME" gnupg

tmux:
	@printf "$(YELLOW)--- tmux ------------------------------------------------\n$(RESET)"
	stow -t "$$HOME" tmux
	if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm "$$HOME/.tmux/plugins/tpm" --quiet; \
		if ! { [ "$$TERM" = "screen" ] && [ -n "$$TMUX" ]; } then \
			tmux source-file "$$HOME/.tmux.conf"; \
		fi \
	fi
	@printf "    $(GREEN)Launch tmux and run \`I to install plugins\n$(RESET)"

.PHONY: bash git R utils zsh bin vim tmux clean install OSX Windows Linux Other gnupg weechat
