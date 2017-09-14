# PHP Image for Azure and Composer
# To build execute in the current folder:
#    docker build -t local:azurecomposer .
FROM php:7.1-apache
COPY php.ini /usr/local/etc/php/
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath

#MSSQL
RUN apt-get update && apt-get install -y --no-install-recommends unixodbc unixodbc-dev
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

#install composer
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    zip \
    unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
