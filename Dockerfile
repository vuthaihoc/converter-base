FROM php:7.1-cli-stretch

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
            fonts-dejavu fonts-lato fonts-lmodern ttf-dejavu ttf-unifont ttf-freefont ttf-liberation \
            -y

COPY ./debs /debs

RUN dpkg -i /debs/*.deb && rm -rf /debs && rm -rf /var/lib/apt/lists/*

# Update fonts
COPY ./fonts/* /usr/share/fonts/
RUN fc-cache -fv && fc-list