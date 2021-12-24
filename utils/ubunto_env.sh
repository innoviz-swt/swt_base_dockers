echo "ubunto env setup"
# sudo apt-get install dos2linux   
sudo apt-get update  
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  build-essential \
  p7zip-full 
# pyenv - python dependencies, https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev python-openssl 

# required by vscode 
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  openssh-client
sudo apt-get clean && rm -rf /var/lib/apt/lists/*

# pyenv  
sudo curl https://pyenv.run | bash
sudo echo "" >> ~/.bashrc && \
	echo "# pyenv" >> ~/.bashrc && \
	echo "export PYENV_ROOT=\"\$HOME/.pyenv\"" >> ~/.bashrc && \
	echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\"" >> ~/.bashrc && \
	echo "export PATH=\"\$PYENV_ROOT/shims:\$PATH\"" >> ~/.bashrc && \
	echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc && \
	echo "" >> ~/.bashrc
  
  
# docker
# https://medium.com/geekculture/run-docker-in-windows-10-11-wsl-without-docker-desktop-a2a7eb90556d
sudo apt install docker.io -y

# add to /etc/sudousers
#sudo visudo
# # Docker daemon specification
# sungkim ALL=(ALL) NOPASSWD: /usr/bin/dockerd

echo '# Start Docker daemon automatically when logging in if not running.' >> ~/.bashrc
echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
echo 'if [ -z "$RUNNING" ]; then' >> ~/.bashrc
echo '    sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
echo '    disown' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

sudo apt-get clean && rm -rf /var/lib/apt/lists/*  

sudo usermod -aG docker $USER