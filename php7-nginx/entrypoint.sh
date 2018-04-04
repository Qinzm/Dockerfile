#!/bin/bash

nginx
/etc/init.d/php-fpm start
touch /root/touchlog
tailf /root/touchlog
