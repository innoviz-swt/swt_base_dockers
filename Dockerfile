# Start from base image of ubuntu 16.04 - see https://hub.docker.com/_/ubuntu 
FROM ubuntu:xenial-20200706

# Copy local files
COPY requirements.txt /tmp/requirements.txt

# Set docker labels
LABEL maintainer="markk@innoviz-tech.com"
LABEL version="0.0.0"
LABEL description="This is custom Docker Image for Innoviz SWT ubunto 16.04 development."

# Run enviroment setup flow
RUN apt-get update
RUN apt-get install -y build-essential sudo curl git 

# pyenv, https://github.com/pyenv/pyenv
## python dependencies, https://github.com/pyenv/pyenv/wiki/Common-build-problems
RUN apt-get install -y libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl

RUN curl https://pyenv.run | bash
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN echo "" >> ~/.bashrc && \
    echo "# pyenv" >> ~/.bashrc && \
    echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

# # install python 3.9.1 and set as global
RUN pyenv install 3.9.1
RUN pyenv global 3.9.1

# # # install conan & cmake
RUN $PYENV_ROOT/versions/3.9.1/bin/pip install -r /tmp/requirements.txt

# vscode devcontainer support
RUN useradd -m -s /bin/bash vscode && \
    echo 'vscode ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# # Set default CMD
CMD ["/bin/bash"]


# ## homebrew
# # source https://stackoverflow.com/questions/58292862/how-to-install-homebrew-on-ubuntu-inside-docker-container
# RUN useradd -m -s /bin/bash linuxbrew && \
#     echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# USER linuxbrew
# RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# USER root
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
