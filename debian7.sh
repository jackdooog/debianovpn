#!/bin/bash
clear
echo "=============================="
echo "        Selamat Datang        "
echo "=============================="
echo "Ketik 'I' SETUL VPS Non-Lokal"
echo "Ketik 'L' SETUP VPS Lokal" 
echo "=============================="
read -p "Location : " -e loc
apt-get update

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
#MYIP=$(wget -qO- ipv4.icanhazip.com);

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`

#MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";
ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`
if [[ $ether = "" ]]; then
        ether=eth0
fi

#vps="zvur";
vps="blangkon";

#if [[ $vps = "zvur" ]]; then
	#source="http://"
#else
	source="https://raw.githubusercontent.com/Boedaxbayah-vpn/boedaxbayah"
#fi

# go to root
cd


# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
#sed -i 's/net.ipv6.conf.all.disable_ipv6 = 0/net.ipv6.conf.all.disable_ipv6 = 1/g' /etc/sysctl.conf
#sed -i 's/net.ipv6.conf.default.disable_ipv6 = 0/net.ipv6.conf.default.disable_ipv6 = 1/g' /etc/sysctl.conf
#sed -i 's/net.ipv6.conf.lo.disable_ipv6 = 0/net.ipv6.conf.lo.disable_ipv6 = 1/g' /etc/sysctl.conf
#sed -i 's/net.ipv6.conf.eth0.disable_ipv6 = 0/net.ipv6.conf.eth0.disable_ipv6 = 1/g' /etc/sysctl.conf
#sysctl -p

# install wget and curl
apt-get update;apt-get -y install wget curl;
apt-get install gem
# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;
apt-get -y --purge remove dropbear*;
#apt-get -y autoremove;

# set repo
ver=`cat /etc/debian_version`
if [ $ver = '6.0' ]
then
debver='6'
elif [ $ver = '6.1' ]
then
debver='6'
elif [ $ver = '6.2' ]
then
debver='6'
elif [ $ver = '6.3' ]
then
debver='6'
elif [ $ver = '6.4' ]
then
debver='6'
elif [ $ver = '6.5' ]
then
debver='6'
elif [ $ver = '6.6' ]
then
debver='6'
elif [ $ver = '6.7' ]
then
debver='6'
elif [ $ver = '6.8' ]
then
debver='6'
elif [ $ver = '6.9' ]
then
debver='6'
elif [ $ver = '7.0' ]
then
debver='7'
elif [ $ver = '7.1' ]
then
debver='7'
elif [ $ver = '7.2' ]
then
debver='7'
elif [ $ver = '7.3' ]
then
debver='7'
elif [ $ver = '7.4' ]
then
debver='7'
elif [ $ver = '7.5' ]
then
debver='7'
elif [ $ver = '7.6' ]
then
debver='7'
elif [ $ver = '7.7' ]
then
debver='7'
elif [ $ver = '7.8' ]
then
debver='7'
elif [ $ver = '7.9' ]
then
debver='7'
elif [ $ver = '8.0' ]
then
debver='8'
elif [ $ver = '8.1' ]
then
debver='8'
elif [ $ver = '8.2' ]
then
debver='8'
elif [ $ver = '8.3' ]
then
debver='8'
elif [ $ver = '8.4' ]
then
debver='8'
elif [ $ver = '8.5' ]
then
debver='8'
elif [ $ver = '8.6' ]
then
debver='8'
elif [ $ver = '8.7' ]
then
debver='8'
elif [ $ver = '8.8' ]
then
debver='8'
elif [ $ver = '8.9' ]
then
debver='8'
else
debver='Null'
fi
if [ $debver = '6' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
    elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	fi
elif [ $debver = '7' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
    elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
    apt-get update
	elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
fi  	
elif [ $debver = '8' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
    apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	fi
else
	cd
fi

gpg --keyserver pgpkeys.mit.edu --recv-key  9D6D8F6BC857C906      
gpg -a --export 9D6D8F6BC857C906 | sudo apt-key add -
gpg --keyserver pgpkeys.mit.edu --recv-key  7638D0442B90D010      
gpg -a --export 7638D0442B90D010 | sudo apt-key add -

# update
apt-get update;apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli
apt-get -y install zip tar

# install essential package
echo "mrtg mrtg/conf_mods boolean true" | debconf-set-selections
apt-get -y install bmon 
apt-get -y install iftop 
apt-get -y install htop 
apt-get -y install nmap 
apt-get -y install axel 
apt-get -y install nano 
apt-get -y install iptables 
apt-get -y install traceroute 
apt-get -y install sysv-rc-conf 
apt-get -y install dnsutils 
apt-get -y install bc 
apt-get -y install nethogs
apt-get -y install openvpn 
apt-get -y install vnstat 
apt-get -y install less 
apt-get -y install screen 
apt-get -y install psmisc 
apt-get -y install apt-file 
apt-get -y install whois 
apt-get -y install ptunnel 
apt-get -y install ngrep 
apt-get -y install mtr 
apt-get -y install git 
apt-get -y install zsh 
apt-get -y install mrtg 
apt-get -y install snmp 
apt-get -y install snmpd 
apt-get -y install snmp-mibs-downloader 
apt-get -y install unzip 
apt-get -y install unrar 
apt-get -y install rsyslog 
apt-get -y install debsums 
apt-get -y install rkhunter
apt-get -y install build-essential
apt-get -y --force-yes -f install libxml-parser-perl

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i $ether
service vnstat restart

#text gambar
apt-get install boxes

# text pelangi
sudo apt-get install ruby
sudo gem install lolcat

# text warna
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc $source/debian7/.bashrc

# Install Webserver Port 81
apt-get install nginx php5 libapache2-mod-php5 php5-fpm php5-cli php5-mysql php5-mcrypt libxml-parser-perl -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
curl https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/uptime.php "http://autoscript.kepalatupai.com/uptime.php1"
wget -O /home/vps/public_html/index.html "http://borneobesthosting.me/index.html"
service php5-fpm restart
service nginx restart
cd

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://github.com/Mbah-Shondong/Debian732/raw/master/Debian7/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/Mbah-Shondong/Debian732/master/Debian7/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/Mbah-Shondong/Debian732/master/Debian7/iptables"
chmod +x /etc/network/if-up.d/iptables
service openvpn restart

#konfigurasi openvpn
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/Mbah-Shondong/Debian732/master/Debian7/client-1194.conf"
sed -i $MYIP2 /etc/openvpn/client.ovpn;
cp client.ovpn /home/vps/public_html/

# install mrtg
apt-get update;apt-get -y install snmpd;
wget -O /etc/snmp/snmpd.conf $source/debian7/snmpd.conf
wget -O /root/mrtg-mem.sh $source/debian7/mrtg-mem.sh
chmod +x /root/mrtg-mem.sh
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl $source/debian7/mrtg.conf >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
#sed -i '/Port 22/a Port 80' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
service ssh restart


# Install Dropbear
apt-get install zlib1g-dev dpkg-dev dh-make -y
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2017.75.tar.bz2
tar jxvf dropbear-2014.63.tar.bz2
cd dropbear-2014.63
dpkg-buildpackage
cd ..
OS=`uname -m`;
if [ $OS = 'i686' ]; then
	dpkg -i dropbear_2017.75-0.1_i386.deb
elif [ $OS = 'x86_64' ]; then
	dpkg -i dropbear_2017.75-0.1_amd64.deb
fi
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110 -p 109 -p 999"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart
cd
# bannerssh
wget $source/debian7/bannerssh
mv ./bannerssh /bannerssh
chmod 0644 /bannerssh
service dropbear restart
service ssh restart
cd

# Install VNSTAT
apt-get install vnstat -y
cd /home/vps/public_html/
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
if [[ `ifconfig -a | grep "venet0"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0:0"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0:0-00"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0-00"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "eth0"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0:0"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0:0-00"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0-00"` ]]
then
cekvirt='KVM'
fi
if [ $cekvirt = 'KVM' ]; then
	sed -i 's/eth0/eth0/g' config.php
	sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
	sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
	sed -i 's/Internal/Internet/g' config.php
	sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
	cd
elif [ $cekvirt = 'OpenVZ' ]; then
	sed -i 's/eth0/venet0/g' config.php
	sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
	sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
	sed -i 's/Internal/Internet/g' config.php
	sed -i '/SixXS IPv6/d' config.php
	cd
else
	cd
fi
# Install BadVPN
apt-get -y install cmake make gcc
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/badvpn-1.999.127.tar.bz2
tar xf badvpn-1.999.127.tar.bz2
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.127 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
cd

#if [[ $ether = "eth0" ]]; then
#	wget -O /etc/iptables.conf $source/Debian7/iptables.up.rules.eth0
#else
#	wget -O /etc/iptables.conf $source/Debian7/iptables.up.rules.venet0
#fi

#sed -i $MYIP2 /etc/iptables.conf;
#iptables-restore < /etc/iptables.conf;

# block all port except
#sed -i '$ i\iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 21 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 22 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 53 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 81 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 109 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 110 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 143 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 1194 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 3128 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8000 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8080 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 10000 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 2500 -j ACCEPT' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p udp -m udp -j DROP' /etc/rc.local
#sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp -j DROP' /etc/rc.local

# install fail2ban
apt-get update;apt-get -y install fail2ban;service fail2ban restart;

# install squid3
wget -q https://raw.githubusercontent.com/gidhanbagus/ndasmu/master/squid3.sh
chmod 100 squid3.sh
./squid3.sh

# script unshc
cd
wget -q -O /usr/bin/bongkar "https://raw.githubusercontent.com/yanncam/UnSHc/master/latest/unshc.sh"
chmod +x /usr/bin/bongkar

# install webmin
cd
#wget -O webmin-current.deb http://prdownloads.sourceforge.net/webadmin/webmin_1.760_all.deb
wget -O webmin-current.deb $source/debian7/webmin-current.deb
dpkg -i --force-all webmin-current.deb
apt-get -y -f install;
#sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm -f /root/webmin-current.deb
apt-get -y --force-yes -f install libxml-parser-perl
service webmin restart
service vnstat restart

# install pptp vpn
wget -O /root/pptp.sh $source/debian7/pptp.sh
chmod +x pptp.sh
./pptp.sh

# download script
cd
wget -O /usr/bin/benchmark $source/debian7/benchmark.sh
wget -O /usr/bin/speedtest $source/debian7/speedtest_cli.py
wget -O /usr/bin/ps-mem $source/debian7/ps_mem.py
wget -O /usr/bin/dropmon $source/debian7/dropmon.sh
wget -O /usr/bin/menu $source/debian7/menu.sh
wget -O /usr/bin/user-active-list $source/debian7/user-active-list.sh
wget -O /usr/bin/user-add $source/debian7/user-add.sh
wget -O /usr/bin/user-add-pptp $source/debian7/user-add-pptp.sh
wget -O /usr/bin/user-del $source/debian7/user-del.sh
wget -O /usr/bin/disable-user-expire $source/debian7/disable-user-expire.sh
wget -O /usr/bin/delete-user-expire $source/debian7/delete-user-expire.sh
wget -O /usr/bin/banned-user $source/debian7/banned-user.sh
wget -O /usr/bin/unbanned-user $source/debian7/unbanned-user.sh
wget -O /usr/bin/user-expire-list $source/debian7/user-expire-list.sh
wget -O /usr/bin/user-gen $source/debian7/user-gen.sh
wget -O /usr/bin/userlimit.sh $source/debian7/userlimit.sh
wget -O /usr/bin/userlimitssh.sh $source/debian7/userlimitssh.sh
wget -O /usr/bin/user-list $source/debian7/user-list.sh
wget -O /usr/bin/user-login $source/debian7/user-login.sh
wget -O /usr/bin/user-pass $source/debian7/user-pass.sh
wget -O /usr/bin/user-renew $source/debian7/user-renew.sh
wget -O /usr/bin/clearcache.sh $source/debian7/clearcache.sh
wget -O /usr/bin/bannermenu $source/debian7/bannermenu
wget -O /usr/bin/menu-update-script-vps.sh $source/debian7/menu-update-script-vps.sh
cd

echo "*/30 * * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "00 23 * * * root /usr/bin/disable-user-expire" > /etc/cron.d/disable-user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
#echo "00 01 * * * root echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a" > /etc/cron.d/clearcacheram3swap
echo "0 */1 * * * root /usr/bin/clearcache.sh" > /etc/cron.d/clearcache1

cd
chmod +x /usr/bin/benchmark
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/ps-mem
#chmod +x /usr/bin/autokill
chmod +x /usr/bin/dropmon
chmod +x /usr/bin/menu
chmod +x /usr/bin/user-active-list
chmod +x /usr/bin/user-add
chmod +x /usr/bin/user-add-pptp
chmod +x /usr/bin/user-del
chmod +x /usr/bin/disable-user-expire
chmod +x /usr/bin/delete-user-expire
chmod +x /usr/bin/banned-user
chmod +x /usr/bin/unbanned-user
chmod +x /usr/bin/user-expire-list
chmod +x /usr/bin/user-gen
chmod +x /usr/bin/userlimit.sh
chmod +x /usr/bin/userlimitssh.sh
chmod +x /usr/bin/user-list
chmod +x /usr/bin/user-login
chmod +x /usr/bin/user-pass
chmod +x /usr/bin/user-renew
chmod +x /usr/bin/clearcache.sh
chmod +x /usr/bin/bannermenu
chmod +x /usr/bin/menu-update-script-vps.sh
cd
# swap ram
dd if=/dev/zero of=/swapfile bs=2048 count=2048k
# buat swap
mkswap /swapfile
# jalan swapfile
swapon /swapfile
#auto star saat reboot
wget $source/debian7/fstab
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=10
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile
cd

# install ssl
apt-get update
apt-get upgrade
apt-get install stunnel4
wget -O /etc/stunnel/stunnel.conf "http://insomnet4u.me/aneka/aneka/stunnel.conf"
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# Finishing
wget -O /etc/vpnfix.sh "https://raw.githubusercontent.com/jackdooog/debianovpn/master/vpnfix.sh"
chmod 777 /etc/vpnfix.sh
sed -i 's/exit 0//g' /etc/rc.local
echo "" >> /etc/rc.local
echo "bash /etc/vpnfix.sh" >> /etc/rc.local
echo "$ screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &" >> /etc/rc.local
echo "nohup ./cron.sh &" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local

# finishing
chown -R www-data:www-data /home/vps/public_html
service cron restart
service nginx start
service php5-fpm start
service vnstat restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart

cd
rm -f /root/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo "Autoscript Edited BY Boedaxbayah:" | tee log-install.txt
echo "=======================================================" | tee -a log-install.txt
echo "Service :" | tee -a log-install.txt
echo "---------" | tee -a log-install.txt
echo "OpenSSH  : 22, 143" | tee -a log-install.txt
echo "Dropbear : 443, 80" | tee -a log-install.txt
echo "Squid3   : 8080 limit to IP $MYIP" | tee -a log-install.txt
#echo "OpenVPN  : TCP 1194 (client config : http://$MYIP:81/client.ovpn)" | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300" | tee -a log-install.txt
echo "PPTP VPN : TCP 1723" | tee -a log-install.txt
echo "nginx    : 81" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Tools :" | tee -a log-install.txt
echo "-------" | tee -a log-install.txt
echo "axel, bmon, htop, iftop, mtr, rkhunter, nethogs: nethogs $ether" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Script :" | tee -a log-install.txt
echo "--------" | tee -a log-install.txt
echo "MENU"
echo "" | tee -a log-install.txt
echo "Fitur lain :" | tee -a log-install.txt
echo "------------" | tee -a log-install.txt
echo "Webmin         : http://$MYIP:10000/" | tee -a log-install.txt
echo "vnstat         : http://$MYIP:81/vnstat/ [Cek Bandwith]" | tee -a log-install.txt
echo "MRTG           : http://$MYIP:81/mrtg/" | tee -a log-install.txt
echo "Timezone       : Asia/Jakarta " | tee -a log-install.txt
echo "Fail2Ban       : [on]" | tee -a log-install.txt
echo "DDoS Deflate.  : [on]" | tee -a log-install.txt
echo "Block Torrent  : [off]" | tee -a log-install.txt
echo "IPv6           : [off]" | tee -a log-install.txt
echo "Auto Lock User Expire tiap jam 00:00" | tee -a log-install.txt
echo "Auto Reboot tiap jam 00:00 dan jam 12:00" | tee -a log-install.txt
echo "" | tee -a log-install.txt

if [[ $vps = "zvur" ]]; then
	echo "Boedaxbayah" | tee -a log-install.txt
else
	echo "Boedaxbayah" | tee -a log-install.txt
	
fi
echo "Credit to all developers script, Boedaxbayah" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Log Instalasi --> /root/log-install.txt" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo " !!! SILAHKAN REBOOT VPS ANDA !!!" | tee -a log-install.txt
echo "=======================================================" | tee -a log-install.txt
cd ~/
rm -rf /root/dropbear-2014.63	rm -rf /root/badvpn-1.999.127
	rm /root/dropbear_2017.75.tar.bz2
	rm /root/dropbear_2017.75-0.1.dsc
	rm /root/dropbear_2017.75-0.1.tar.gz
	rm /root/dropbear_2017.75-0.1_*.changes
	rm /root/dropbear_2017.75-0.1_*.deb
	rm /root/badvpn-1.999.127.tar.bz2
	rm /root/jcameron-key.asc
	rm /root/squid3.sh
	rm /root/debian7.sh
