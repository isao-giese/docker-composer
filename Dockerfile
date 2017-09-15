# PHP Image for Azure and Composer
# To build execute in the current folder:
#    docker build -t local:azurecomposer .
FROM php:7.1-apache
COPY php.ini /usr/local/etc/php/
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath

#General
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    zip \
    unzip

#MSSQL
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && apt-get install -y --no-install-recommends locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql
RUN apt-get update && apt-get install -y unixodbc unixodbc-dev
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

#build log
echo "AZURE-COMPOSER `date '+%Y-%m-%d %H:%M:%S'`" >> /var/mydockerlog
