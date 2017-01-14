yum -y update
yum -y upgrade
yum -y install wget git python-setuptools && easy_install pip
yum -y groupinstall "Development Tools"
cd ~
wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
pip install cymysql

cd ~
git clone https://github.com/cheneyveron/shadowsocks-manyuser.git

echo "* soft nofile 51200" >> /etc/security/limits.conf
echo "* hard nofile 51200" >> /etc/security/limits.conf
ulimit -n 51200

#supervisord
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm --quiet
yum install supervisor python-pip -y
pip install supervisor==3.1
chkconfig supervisord on
wget https://raw.githubusercontent.com/cheneyveron/shadowsocks-manyuser/master/supervisord/supervisord.conf -O /etc/supervisord.conf
wget https://raw.githubusercontent.com/cheneyveron/shadowsocks-manyuser/master/supervisord/supervisord -O /etc/init.d/supervisord