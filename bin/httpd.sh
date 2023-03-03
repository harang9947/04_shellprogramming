#!/bin/bash

yum -y install httpd \
    && echo"<h1>>>>httpd Web Server</h1>" > /var/www/html/index.html \
    && service httpd restart \
    && echo "[ OK ] Apache HTTPD Web Server started."