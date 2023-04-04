# DotFiles

## Overview

This repo is intended to be consumed by [chezmoi](https://www.chezmoi.io/) to configure machines.

## Installation

The following installation guides can be followed to configure a new machine.

### Linux

TBC.

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
- [OpenSSH](https://github.com/PowerShell/Win32-OpenSSH)
- [Git](https://git-scm.com/download/win)
- [7zip](https://www.7-zip.org/)
- [Windows Terminal](https://github.com/microsoft/terminal)
- [VS Code](https://code.visualstudio.com/download)
- [Scoop](https://scoop-docs.vercel.app/)

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
chezmoi apply
```
