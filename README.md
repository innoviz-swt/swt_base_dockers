# swt_xenial_docker

## Apps installed
- build-essentials (gcc 5)
- sudo
- curl
- pyenv
- python essentials
- conan@1.22.2
- cmake@3.18.0

## Distribution
docker build . -t innoviz-swt/swt_xenial_docker:0.0.0 --rm

## MISC
powershell -c docker rmi $(docker images --filter "dangling=true" -q --no-trunc)