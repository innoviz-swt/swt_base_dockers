# SWT BASE DOCKERS

# OS supported
- ubuntu 16.04, xenial
- ubuntu 18.04, bionic
- ubunto 20.04, focal

## packages\apps installed
- build-essentials (GCC)
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

## Distribution
```
python ./manage.py {ver} -p
```
{ver} should be in major.minor.build format, ex: 1.0.0
