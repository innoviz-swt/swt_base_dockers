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

# run as bash, 
SHELL ["bash", "-c"]

# Run enviroment setup flow
RUN apt-get update 
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  build-essential \
  sudo \
  curl \
  git \
  vim

RUN apt update
RUN apt install wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install minconda
RUN cd tmp && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh && \
    bash Miniconda3-py39_4.10.3-Linux-x86_64.sh -b -p $HOME/miniconda && \
    rm Miniconda3-py39_4.10.3-Linux-x86_64.sh
# add conda to path
ENV PATH /root/miniconda/bin:$PATH

# add conda to bashrc
RUN conda init bash

# install & config jupyter lab
RUN conda install jupyterlab -y
RUN echo "# jupyter lab" >> ~/.bashrc && echo alias jlab="jupyter lab" >> ~/.basrc
RUN mkdir ~/.jupyter
RUN echo "c.ServerApp.token = ''" > ~/.jupyter/jupyter_lab_config.py 

# install requirements
ADD requirements.txt /tmp/requirements.txt
RUN python -m pip install -r /tmp/requirements.txt

# install innopy and copy example recording
ADD https://github.com/InnovizTechnologies/InnovizAPI/archive/refs/tags/V4.9.4.tar.gz /tmp
RUN cd tmp && tar -xf ./innovizapi
RUN python -m pip install /tmp/InnovizAPI*/python
RUN mv /tmp/InnovizAPI*/examples/ /home/work/innopy_examples
RUN rm /tmp/innovizapi && rm -rf InnovizAPI*

# clone jlab swt jupyter lab scripts project
# ARG GITPWD
# ARG GITUSR
# git cd /home/work && git clone https://{GITUSR}:${GITPWD}@bitbucket.org/innovizrnd/swt-jlab-scripts.git

RUN mkdir /home/work
EXPOSE 8888

CMD ["jupyter", "lab", "/home/work", "--allow-root", "--no-browser", "--ip" ,"0.0.0.0"]

# conda install nodejs@16.13.1 -y
# jupyter nbextension enable --py widgetsnbextension
# jupyter labextension install @jupyter-widgets/jupyterlab-manager
