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
  
  
sudo apt-get clean && rm -rf /var/lib/apt/lists/*  