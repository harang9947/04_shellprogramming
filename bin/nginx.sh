#!/bin/bash

yum -y install nginx \
    && echo "<h1>nginx WebServer</h1>" > /usr/share/nginx/html/index.html \
    && service nginx restart \
    && echo "[ OK ] Nginx Web Server Started. "

curl localhost