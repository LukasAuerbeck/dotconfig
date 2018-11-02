# Development setup
This is the conifg I use on my Laptop and PC.


# Prerequisites
For this setup to work you need to have a working oh-my-zsh installation.

# Installation guide
The configuration was only tested by cloning the repo directly into the home directory `~`. After that it is recommended to rename the cloned folder with `mv ~/zsh-profile ~/.zshd`. Then you need to link two files that are expected to be in your home folder:

```bash
ln -s ~/.zshd/zshrc ~/.zshrc
ln ~/.zshd/vimrc ~/.vimrc
```
