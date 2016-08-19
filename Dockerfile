# 拉取基本镜像
FROM centos:latest

# 作者信息
MAINTAINER zhang shi ping "214986304@qq.com"

RUN yum install apt
RUN apt-get update

# 安装软件
RUN apt-get -y install curl \
    git \
    httpd \
    php \
    php-cli \
    php-ldap \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-pear-MDB2-Driver-mysqli \
    php-pecl-memcached \
    php-xml \
    php-gd \
    php-pear && \
    yum -y update bash

# 设置系统时间
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "NETWORKING=yes" > /etc/sysconfig/network

# 安装composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 创建数据目录
RUN mkdir -p /data/html/laravel

# 工作目录
WORKDIR /data/html/laravel

# 拉取代码
RUN git clone https://github.com/zsping1989/laravel.git /data/html/laravel && \
    cd /data/html/laravel && \
    git checkout dev \
    composer install \
    git checkout zhangshiping

# 开放端口
EXPOSE 80



