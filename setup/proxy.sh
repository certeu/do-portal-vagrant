#!/bin/bash

echo "http_proxy=\"http://10.1.1.80:8080/\"" >> /etc/environment
echo "https_proxy=\"http://10.1.1.80:8080/\"" >> /etc/environment
echo "HTTP_PROXY=\"http://10.1.1.80:8080/\"" >> /etc/environment
echo "HTTPS_PROXY=\"http://10.1.1.80:8080/\"" >> /etc/environment
echo "Acquire::http::proxy \"http://10.1.1.80:8080/\";" >> /etc/apt/apt.conf
echo "Acquire::https::proxy \"http://10.1.1.80:8080/\";" >> /etc/apt/apt.conf
