# Powered by wsm
# For debian

# root
if [[ $EUID -ne 0 ]]; then
	echo "Error:This script must be run as root!" 1>&2
	exit 1
fi

# update & upgrade
mv /etc/apt/source.list /etc/apt/source.list.bak
echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\ndeb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\ndeb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\ndeb http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib\n#deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib\n#deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\n#deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\n#deb-src http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib" > /etc/apt/source.list
apt update
apt dist-upgrade -y

# create user
echo "please input username & its key:\n"
read usrname usrkey
useradd -m $usrname -g $usrname -s /bin/bash -d /home/$usrname
echo $usrkey | passwd $usrname --stdin
usrdir=/home/$usrname

# zsh
apt install zsh git -y
sudo -u $usrname -H $usrdir chsh -s /bin/zsh
echo "PATH=$PATH:/sbin" >> $usrdir/.zshrc
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
echo "\nNow please change theme into \'ys\'"
sleep 1s
vim +/ZSH_THEME $usrdir/.zshrc

# ssh
apt install openssh-client openssh-server -y && echo "\nPermitRootLogin yes\nPasswordAuthentication yes" >> /etc/ssh/sshd_config && update-rc.d ssh enable

# kms
git clone git://github.com/wsm25/py-kms
mv ./py-kms $usrdir/py-kms
echo "nohup python $usrdir/py-kms/server.py>>$usrdir/py-kms/log &" >> /etc/init.d/startkms && chmod +x /etc/init.d/startkms 
update-rc.d startkms defaults 99