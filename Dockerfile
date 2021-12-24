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
RUN apt-get update 
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
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
  # clean apt-get cache
  && apt-get clean && rm -rf /var/lib/apt/lists/*
 
# pyenv, https://github.com/pyenv/pyenv
RUN curl https://pyenv.run | bash
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
ENV PATH $PYENV_ROOT/shims:$PATH

RUN echo "" >> ~/.bashrc && \
    echo "# pyenv" >> ~/.bashrc && \
    echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

# Set default CMD
CMD ["/bin/bash"]