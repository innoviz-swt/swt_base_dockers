# swt_xenial_docker

## Apps installed
- build-essentials (gcc 5)
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
docker build . -t innoviz-swt/swt_xenial_docker:0.0 --rm

## MISC
powershell -c docker rmi $(docker images --filter "dangling=true" -q --no-trunc)