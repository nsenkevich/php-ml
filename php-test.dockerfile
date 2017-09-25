FROM php:7.1-cli
ENV TZ=Europe/London
RUN echo $TZ | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update && apt-get install -y
RUN apt-get install -y git
RUN apt-get install -y unzip

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
WORKDIR /app
RUN composer install --prefer-source --no-interaction
ENV PATH="~/.composer/vendor/bin:../vendor/bin:${PATH}"