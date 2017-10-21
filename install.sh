#!/bin/zsh
rm ~/.zshrc && ln -s "$(pwd)/zshrc" ~/.zshrc
rm ~/.zshenv && ln -s "$(pwd)/zshenv" ~/.zshenv
rm ~/.gitignore_global && ln -s "$(pwd)/gitignore_global" ~/.gitignore_global
