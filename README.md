# DotFiles

## Overview

This repo is intended to be consumed by [chezmoi](https://www.chezmoi.io/) to configure machines.

## Installation

The following installation guides can be followed to configure a new machine.

### Debian

#### WSL2

TBC.

#### Prerequisites

Run the following script to configure `apt` packages.

```shell
sudo apt update && sudo apt upgrade -y
apt install build-essential procps curl file git
```

Install the following components.

- [Homebrew](https://docs.brew.sh/Homebrew-on-Linux)

Run the following script to add additional packages.

```shell
brew install starship
```

Create a SSH key with the following command and add it to GitHub.

```shell
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519
```

#### Install Chezmoi

Run the following commands to install and initialise _chezmoi_.

```shell
brew install chezmoi
chezmoi init --apply git@github.com:stevehipwell/dotfiles.git
```

### Windows

#### Prerequisites

Configure Windows with the following changes.

- Enable developer mode
- Turn Windows features on
  - Telnet Client
  - Virtual Machine Platform
  - Windows Subsystem for Linux
- Turn optional features off
  - OpenSSH

Install the following components.

- [PowerShell Core](https://github.com/PowerShell/PowerShell)
- [7zip](https://www.7-zip.org/)
- [OpenSSH](https://github.com/PowerShell/Win32-OpenSSH)
- [Git](https://git-scm.com/download/win)
- [Windows Terminal](https://github.com/microsoft/terminal)
- [VS Code](https://code.visualstudio.com/download)
- [Notepad++](https://notepad-plus-plus.org/downloads/)
- [Scoop](https://scoop-docs.vercel.app/)
- [Starship](https://starship.rs/)

Create a SSH key with the following command and add it to GitHub.

```shell
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519
```

#### Install Chezmoi

Run the following commands to install and initialise _chezmoi_.

```shell
scoop install chezmoi
chezmoi init --apply git@github.com:stevehipwell/dotfiles.git
```

### WSL 2

TBC.

## Daily Operations

You can use the following command to keep a machine updated.

```shell
chezmoi update
```

Or you can use the following commands to view the changes before applying them.

```shell
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

```shell
chezmoi apply
```

To open the config in VS Code you can run the following command.

```shell
code ~/.local/share/chezmoi
```
