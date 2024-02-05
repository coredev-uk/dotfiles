# My Dotfiles

A repository containing my dotfiles for Arch Linux, macOS and Asahi Linux.

## Required Packages

### Git
```
pacman -S git
```

### Stow
```
pacman -S stow
```

## Installation
First, clone the repository to the dotfiles directory.
```
$ git clone git@github.com/coredev-uk/dotfiles.git dotfiles
$ cd dotfiles
```

Then use GNU stow to create the symlinks from the config.
```
$ stow .
```
