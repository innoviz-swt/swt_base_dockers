# SWT Base Dockers Changelog
## 1.0.3
- added ubuntu 
- remove ubuntu-16.04 - xenial
- added ubuntu-20.04 - focal
- remove zsh support (KISS)

## 1.0.2
- zsh: char limit bug, added "[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'" to zsh


## 1.0.1
- pyenv: add shims folder (/root/.pyenv/shims) to PATH

## 1.0.0
- OS
    - ubuntu 16.04
    - ubuntu 18.04
- packages
    - build-essentials (GCC 5)
    - sudo
    - curl
    - [git](https://git-scm.com/)
    - 7zip
    - openssh-client (for vscode)
    - [pyenv](https://github.com/pyenv/pyenv) (+ [python essentials](https://github.com/pyenv/pyenv/wiki/Common-build-problems))
    - [conan](https://conan.io/)@1.22.2
    - [cmake](https://cmake.org/)@3.18.0
    - [zsh (+oh my zsh)](https://ohmyz.sh/)
    - [vim](https://www.vim.org/) 
