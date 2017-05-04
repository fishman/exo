#!/bin/bash

# Set up my ubuntu



apps=/tmp/apps

if [ ! -d "$apps" ]; then
	mkdir "$apps"
fi

log="$apps/install.log"
err="$apps/install-err.log"

progress=1
total=30


#cd $(dirname "$0")

echo "[*] Updating repository"
apt update 1>>$log 2>>$err
echo "[*] Installing missing dependencies"
apt install -f -y 1>>$log 2>>$err


# Macbuntu for 16.10 install
# echo "[*] [ $progress/$total ] Installing cerebro"
# cerebro=cerebro.deb
# if [ ! -f $apps/mac-fonts.zip ]; then
#     wget -q -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/0.2.6/cerebro_0.2.6_amd64.deb
#     dpkg -i $apps/$cerebro 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
#     #rm $apps/$cerebro
# else
#     dpkg -i $apps/$cerebro 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
# fi


echo "[*] [ $progress/$total ] Installing Macbuntu"
apt install -y software-properties-common 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
add-apt-repository -y ppa:noobslab/macbuntu 1>>$log 2>>$err 
apt update 1>>$log 2>>$err 

apt install -y gnome-tweak-tool 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -y ubuntu-gnome-desktop 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
#apt install -y ubuntu-desktop 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."

apt install -y plank 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -y macbuntu-os-plank-theme-lts-v8 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -y macbuntu-os-icons-lts-v8 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -y macbuntu-os-ithemes-lts-v8 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
#apt install -y slingscold 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
#apt install -y albert 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."

if [ ! -d ~/.theme ]; then
	mkdir ~/.theme
fi
wget -q -O - "https://dl.opendesktop.org/api/files/download/id/1489658553/Gnome-OSX-II-NT-2-5-1.tar.xz" | tar -xf - -C ~/.theme
gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"		# Put buttons on left side

apt install -y libreoffice-style-sifr 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
fonts=mac-fonts.zip
if [ ! -f $apps/$fonts ]; then
	wget -q -O $apps/$fonts http://drive.noobslab.com/data/Mac/macfonts.zip
	unzip $apps/$fonts -d /usr/share/fonts 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
	#rm $apps/$fonts
else
	unzip -o $apps/mac-fonts.zip -d /usr/share/fonts 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
fi
fc-cache -f -v  1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Disable Mouse Acceleration for X server
echo "[*] [ $progress/$total ] Disable X mouse acceleration"
cat > /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf <<EOF
Section "InputClass"
    Identifier "My Mouse"
    MatchIsPointer "yes"
    Option "AccelerationProfile" "-1"
    Option "AccelerationScheme" "none"
    Option "AccelSpeed" "-1"
EndSection
EOF
let progress++


# OpenVPN
echo "[*] [ $progress/$total ] Installing OpenVPN"
apt install -y openvpn 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Virt-Viewer
echo "[*] [ $progress/$total ] Installing virt-viewer"
apt install -y virt-viewer 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# tmux
echo "[*] [ $progress/$total ] Installing tmux"
apt install -y tmux 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# CIFS
#echo "[*] [ $progress/$total ] Installing samba tools"
#apt install -y cifs-utils 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Chrome
echo "[*] [ $progress/$total ] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -q -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
	#rm $apps/$chrome
else
	dpkg -i $apps/$chrome 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
fi
apt install -f -y 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# PlayOnLinux
echo "[*] [ $progress/$total ] Installing PlayOnLinux"
pol=PlayOnLinux.deb
if [ ! -f $apps/$pol ]; then
	wget -q -O $apps/$pol 'http://repository.playonlinux.com/PlayOnLinux/4.2.10/PlayOnLinux_4.2.10.deb'
	dpkg -i $apps/$pol 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
	#rm $apps/$pol
else
	dpkg -i $apps/$pol 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
fi
if [ -d usr ]; then
	rsync -rti usr /
fi
dpkg --add-architecture i386
apt update 1>>$log 2>>$err
apt install -y wine-stable 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -f -y 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Pycharm
echo "[*] [ $progress/$total ] Installing Pycharm"
pycharm=pycharm.tgz
if [ ! -f $apps/$pycharm ]; then
	wget -q -O $apps/$pycharm 'https://download-cf.jetbrains.com/python/pycharm-community-2017.1.1.tar.gz'
	tar zxf $apps/$pycharm -C /opt 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
	#rm $apps/$pycharm
else
	tar zxf $apps/$pycharm -C /opt 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
fi
if [ ! -f /usr/local/bin/pycharm ]; then
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
else
    rm /usr/local/bin/pycharm
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
fi
apt install -y git 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt install -y python3-pip 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Visual Studio Code
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update 1>>$log 2>>$err
#apt-get install -y code 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."
apt-get install -y code-insiders 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# nmap
echo "[*] [ $progress/$total ] Installing nmap"
apt install -y nmap 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# wireshark
echo "[*] [ $progress/$total ] Installing wireshark"
apt install -y wireshark 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# QTQR
echo "[*] [ $progress/$total ] Installing QTQR"
apt install -y qtqr 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# VLC
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y vlc 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Virtualbox
echo "[*] [ $progress/$total ] Installing Virtualbox"
apt install -y virtualbox 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Emacs
echo "[*] [ $progress/$total ] Installing Emacs"
apt install -y emacs 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# Skype
echo "[*] [ $progress/$total ] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add - 1>>$log 2>>$err
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list
apt update 1>>$log 2>>$err
apt install -y skypeforlinux 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# iotop
echo "[*] [ $progress/$total ] Installing iotop"
apt install -y iotop 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."


# iftop
echo "[*] [ $progress/$total ] Installing iftop"
apt install -y iftop 1>>$log 2>>$err && let progress++ && echo "[*] [ $progress/$total ] Installing..."



echo "[*] Done"
