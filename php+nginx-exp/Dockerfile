FROM centos:6

WORKDIR /root
ENV LANG en_US.UTF-8
RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
    rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm;
RUN yum -y install nginx; \
    /etc/init.d/nginx start; \
    sleep 5; \
    /etc/init.d/nginx stop; \
    yum clean all;
RUN cp -f /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf$(date  +%Y%m%d) ;\
    sed -i 's/listen.*]:80/#listen       [::]:80/' /etc/nginx/conf.d/default.conf ;\
    sed -i 's/^user.*;/user www-data;/' /etc/nginx/nginx.conf ;\
    groupadd www-data ; \
    useradd -s /bin/nologin -r -g www-data www-data ;\
    chown www-data:www-data -R /var/log/nginx ;
COPY php-5.5.38.tar.gz /root/php-5.5.38.tar.gz
COPY installphp.sh /root/installphp.sh
RUN tar -xzvf php-5.5.38.tar.gz; \
    /bin/sh installphp.sh; \
    yum clean all;\
    rm -rf php-5.5.38*   
COPY entrypoint.sh /root/entrypoint.sh
EXPOSE 80 443
ENTRYPOINT sh entrypoint.sh
