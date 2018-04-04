#!/bin/bash

/etc/init.d/nginx start
/etc/init.d/php-fpm start
touch /root/touchlog
tailf /root/touchlog
