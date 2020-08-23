# Start from base image of ubuntu 16.04 - see https://hub.docker.com/_/ubuntu 
FROM ubuntu:xenial-20200706

# Copy local files
Copy requirements.txt /tmp/requirements.txt

# Set docker labels
LABEL maintainer="markk@innoviz-tech.com"
LABEL version="0.0"
LABEL description="This is custom Docker Image for Innoviz SWT ubunto 16.04 development."

# Run enviroment setup flow
RUN echo "update apt-get"
RUN apt-get update
RUN apt-get install curl -y 

RUN echo "install python 3 default(3.5.2), pip and required global packages (see requirements.txt)"
RUN apt-get install python3 -y
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py" 
RUN python3 /tmp/get-pip.py   
RUN pip install -r /tmp/requirements.txt
RUN echo 'alias python=python3' >> ~/.bashrc

# Set default CMD
CMD ["/bin/bash"]