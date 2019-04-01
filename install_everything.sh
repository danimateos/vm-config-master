#!/bin/bash

# Install essential packages
sudo apt update
sudo apt install emacs zsh htop build-essential dkms linux-headers-$(uname -r) liquidprompt libxml2-dev libssl-dev libcurl4-openssl-dev libopenblas-dev r-base r-base-dev gdebi ubuntu-restricted-extras openjdk-8-jdk

# Install Anaconda for Python development
wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
bash Anaconda3-2018.12-Linux-x86_64.sh
rm Anaconda3-2018.12-Linux-x86_64.sh

# Install csvkit with conda
source .bashrc
conda install csvkit -y

# Install Spark 2.4.0
wget http://apache.rediris.es/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
tar -xvzf spark-2.4.0-bin-hadoop2.7.tgz
sudo mv spark-2.4.0-bin-hadoop2.7 /usr/local
sudo ln -s /usr/local/spark-2.4.0-bin-hadoop2.7 /usr/local/spark 
rm spark-2.4.0-bin-hadoop2.7.tgz

# Symlink config files from this repo in ~:
echo "\n#################\nCreating symlinks in ${HOME}..."
for CONFIG_FILE in $(ls -a . | grep '^\.[^$\.]');
do
    rm -rf "${HOME}/${CONFIG_FILE}" # Remove or linking will fail.
    ln -s "$(pwd)/$CONFIG_FILE" "${HOME}/${CONFIG_FILE}" 
done

# rm repo symlinks (careful with the slashes!!)
rm ~/.git
rm ~/.gitignore

# switch to zsh as default
chsh -s $(which zsh)

# RStudio
wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb
sudo gdebi rstudio-xenial-1.1.463-amd64.deb
printf '\nexport QT_STYLE_OVERRIDE=gtk\n' | sudo tee -a ~/.profile
rm rstudio-xenial-1.1.463-amd64.deb




