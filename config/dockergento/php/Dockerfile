FROM php:7.4-fpm

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; } echo PHP_EOL;"

RUN php composer-setup.php --filename=composer --version=1.10.19 && mv composer /usr/local/bin/composer

RUN rm composer-setup.php

RUN docker-php-ext-install pdo_mysql

RUN apt-get update && \
    apt-get install -y zlib1g-dev libicu-dev g++ libxml2-dev libpng-dev libxslt1-dev git && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-install xsl

RUN pecl install apcu

RUN apt-get update && \
  apt-get install -y \
  libzip-dev

RUN docker-php-ext-install zip
RUN docker-php-ext-enable apcu

RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install sockets
RUN docker-php-ext-configure gd
RUN docker-php-ext-install gd

RUN apt-get remove -y libxslt1-dev icu-devtools libicu-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PHP_MEMORY_LIMIT=1G

WORKDIR /var/www/html
