#!/bin/bash

# Install essential packages
sudo apt update
sudo apt install build-essential \
                 dkms \
                 emacs \
                 gdebi \
                 htop \
                 linux-headers-$(uname-r) \
                 liquidprompt \
                 libxml2-dev \
                 libssl-dev \
                 libcurl4-openssl-dev \
                 libopenblas-dev \
                 openjdk-8-jdk \
                 r-base \
                 r-base-dev \
                 ubuntu-restricted-extras \
                 zsh 

# Install Anaconda for Python development
wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
bash Anaconda3-2020.11-Linux-x86_64.sh
rm Anaconda3-2020.11-Linux-x86_64.sh

# Install csvkit with conda
source .bashrc
conda install csvkit -y

# Install Spark 3.1.1
wget http://apache.rediris.es/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
tar -xvzf spark-3.1.1-bin-hadoop3.2.tgz
sudo mv spark-3.1.1-bin-hadoop3.2.tgz /usr/local
sudo ln -s /usr/local/spark-3.1.1-bin-hadoop3.2 /usr/local/spark 
rm spark-3.1.1-bin-hadoop3.2.tgz

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
wget https://download1.rstudio.org/desktop/xenial/amd64/rstudio-1.4.1106-amd64.deb
sudo gdebi rstudio-1.4.1106-amd64.deb
printf '\nexport QT_STYLE_OVERRIDE=gtk\n' | sudo tee -a ~/.profile
rm rstudio-1.4.1106-amd64.deb

# Some flair :)
wget https://www.itespresso.es/wp-content/uploads/2020/05/kschool-600x513.jpg
mv kschool-600x513.jpg vm-config-master
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s vm-config-master/kschool-600x513.jpg
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/image-style -s 1

# Farewell
echo "\n\n\n=======================================================\n"
echo "Your VM is set up! Rememeber to install guest additions https://www.tecmint.com/install-virtualbox-guest-additions-in-ubuntu/ and the virtualbox extension pack!"
