#!/bin/sh

softPath=`pwd`

confyum()
{
	yum -y install wget
	cd /etc/yum.repos.d/
	mkdir bak
	mv ./*.repo bak
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
	wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
	yum clean all && yum makecache
	yum -y install vim unzip  openssl-client gcc gcc-c++ ntp

yum groupinstall -y "Development tools" 
yum -y install wget libxml2 libxml2-devel openssl openssl-devel libcurl libcurl-devel libmcrypt libmcrypt-devel enca

cd $softPath
#tar -xzvf php-5.5.38.tar.gz
cd php-*

./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--enable-fpm \
--enable-zip \
--enable-ftp \
--with-zlib \
--with-mcrypt \
--with-openssl \
--with-curl \
--enable-mbstring  \
--enable-sockets  \
--with-mysql \
--with-mysqli \
--with-pdo-mysql \
--with-mcrypt \
--enable-xml

make && make install

cd $softPath/php-*/sapi/fpm
cp init.d.php-fpm.in  /etc/init.d/php-fpm

sed -i 's/@prefix@/\/usr\/local\/php/' /etc/init.d/php-fpm
sed -i 's/@exec_prefix@/${prefix}/' /etc/init.d/php-fpm
sed -i 's/@sbindir@/${prefix}\/sbin/' /etc/init.d/php-fpm
sed -i 's/@sysconfdir@/${prefix}\/etc/' /etc/init.d/php-fpm
sed -i 's/@localstatedir@/\/var/' /etc/init.d/php-fpm

chmod +x /etc/init.d/php-fpm
chkconfig --add /etc/init.d/php-fpm
chkconfig php-fpm on

cd $softPath/php-*/
cp php.ini-production /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/' /usr/local/php/etc/php.ini

cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
sed -i 's#user = nobody#user = www-data#' /usr/local/php/etc/php-fpm.conf
sed -i 's#group = nobody#group = www-data#' /usr/local/php/etc/php-fpm.conf

groupadd www-data
useradd -s /bin/nologin -r -g www-data www-data
echo 'export PATH=$PATH:/usr/local/php/bin' >> /etc/profile
usermod -a -G root www-data
source /etc/profile
	/etc/init.d/php-fpm start
}

confyum
