FROM centos:7

WORKDIR /root
ENV LANG en_US.UTF-8
RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
    rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm;
RUN yum -y install nginx; \
    nginx; \
    sleep 3; \
    nginx -s stop; \
    yum clean all;
RUN mkdir -p /var/www/html && chmod 777 /var/www/html; \
	echo -e "<?php\nphpinfo();\n?>"  > /var/www/html/test.php; 
COPY php-7.2.0.tar.gz /root/php-7.2.0.tar.gz
COPY installphp7.sh /root/installphp7.sh
RUN tar -xzvf php-7.2.0.tar.gz; \
    /bin/sh installphp7.sh; \
    yum clean all;\
    rm -rf php-7.2.0*   
COPY entrypoint.sh /root/entrypoint.sh
EXPOSE 80 443
ENTRYPOINT sh entrypoint.sh
