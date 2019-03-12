FROM php:7.2-cli-stretch

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl apt-utils libcurl4-openssl-dev zip libghc-zlib-dev && \
    docker-php-ext-install curl && \
    pecl install swoole && \
        docker-php-ext-enable swoole && \
    docker-php-ext-install zip && \
        docker-php-ext-enable zip &&\
    mkdir -p /usr/share/man/man1 && \
        apt-get install libcups2 libcairo2 \
            libxinerama1 libsm6 libdbus-glib-1-2 poppler-utils qpdf ghostscript exiftool pdf2htmlex \
            fonts-dejavu fonts-lato fonts-lmodern ttf-dejavu ttf-unifont ttf-freefont ttf-liberation git locales \
            -y && \
    mkdir setup && cd setup && \
    git clone https://github.com/vuthaihoc/basic_fonts.git && rm -rf basic_fonts/.git && \
    mv basic_fonts/* /usr/share/fonts/ && fc-cache -fv && fc-list && \
    cd / && rm -rf setup && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    apt-get remove --purge git locales -y && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8