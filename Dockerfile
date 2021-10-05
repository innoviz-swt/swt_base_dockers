# syntax based on https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
ARG BASE="focal"

# Start from base image of ubuntu 16.04 - see https://hub.docker.com/_/ubuntu 
FROM ubuntu:${BASE}

# define ARGS after from to take effect at current stage
ARG VARIANT="ubuntu-20.04"
ARG VER="0.0.0"
ARG BUILD="xxxxx"
ARG BASE="focal"

# Set docker labels
LABEL maintainer="markk@innoviz-tech.com" \
      version=${VER} \
      build=${BUILD} \
      variant=${VARIANT} \
      base=${BASE} \
      # full version format: "{major}.{minor}.{patch}-{build} {variant}"
      full_version="${VER}-${BUILD} ${VARIANT}" \
      description="This is base Docker Image for Innoviz SWT ${VARIANT}($BASE) development." \
      source-code="https://github.com/innoviz-swt/swt_base_dockers"

# Run enviroment setup flow
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  build-essential \
  sudo \
  curl \
  git \
  p7zip-full \
  vim \
  ## pyenv - python dependencies, https://github.com/pyenv/pyenv/wiki/Common-build-problems
  libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
  # required by vscode 
  openssh-client \
  # required by oh-my-zsh
  zsh locales fonts-powerline\ 
  # clean apt-get cache
  && apt-get clean && rm -rf /var/lib/apt/lists/*


# ohmyzsh in docker https://github.com/deluan/zsh-in-docker
RUN echo Y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# update locale https://unix.stackexchange.com/questions/90772/first-characters-of-the-command-repeated-in-the-display-when-completing
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    echo "# zsh locale" >> ~/.zshrc && \    
    echo 'export LANG=en_US.utf8' >> ~/.zshrc && \
    echo "" >> ~/.zshrc

# set zsh as default terminal
# todo remove this
RUN usermod -s $(which zsh) root 

# pyenv, https://github.com/pyenv/pyenv
RUN curl https://pyenv.run | bash
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
ENV PATH $PYENV_ROOT/shims:$PATH


RUN echo "" >> ~/.bashrc && \
    echo "# pyenv" >> ~/.bashrc && \
    echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

RUN echo "" >> ~/.zshrc && \
    echo "# pyenv" >> ~/.zshrc && \
    echo "eval \"\$(pyenv init -)\"" >> ~/.zshrc && \
    echo "" >> ~/.zshrc

# install python 3.9.1 and set as global
RUN pyenv install 3.9.1
RUN pyenv global 3.9.1

# # install conan & cmake
RUN $PYENV_ROOT/versions/3.9.1/bin/pip install cmake==3.18.0 conan==1.22.2

# Set default CMD
CMD ["/bin/bash"]


# ## homebrew
# # source https://stackoverflow.com/questions/58292862/how-to-install-homebrew-on-ubuntu-inside-docker-container
# RUN useradd -m -s /bin/bash linuxbrew && \
#     echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# USER linuxbrew
# RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# USER root
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
