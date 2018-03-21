FROM alpine:3.7
MAINTAINER FAN VINGA<fanalcest@gmail.com>

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

RUN apk --no-cache --virtual  exts add          \
                            php7                \
                            php7-gd             \
                            php7-fpm            \
                            php7-xml            \
                            php7-zip            \
                            php7-xsl            \
                            php7-pdo            \
                            php7-dom            \
                            php7-soap           \
                            php7-curl           \
                            php7-json           \
                            php7-phar           \
                            php7-zlib           \
                            php7-exif           \
                            php7-intl           \
                            php7-iconv          \
                            php7-mcrypt         \
                            php7-mysqli         \
                            php7-openssl        \
                            php7-opcache        \
                            php7-mbstring       \
                            php7-xmlreader      \
                            php7-pdo_mysql      \
                            php7-simplexml      \
                            php7-tokenizer      \
                            php7-xmlwriter   && \
    apk --no-cache --virtual run-times add \
                            zip                 \
                            curl                \
                            nginx               \
                            dcron               \
                            mariadb-client      \
                            ca-certificates  && \
    apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing add gnu-libiconv

COPY . /var/www/html

RUN apk --no-cache add tzdata git               && \
    cp -rf /usr/share/zoneinfo/Hongkong /etc/localtime && echo "Hongkong" > /etc/timezone    && \
    cd /var/www/html/                           && \
    git clone https://github.com/lhie1/ss-panel-v3-mod.git tmp -b new_master --depth 1    && \
    mv tmp/.git . && rm -rf tmp                 && \
    git reset --hard                            && \
    chown -R root:root * && chmod -R 777 *      && \
    chown -R nginx:www-data storage             && \
    curl -sS getcomposer.org/installer | php    && \
    php composer.phar install                   && \
    php composer.phar dump-autoload --optimize  && \
    cp config/.config.php.example config/.config.php\
    &&php xcat initQQWry                        && \
    cp  nginx.conf           /etc/nginx/        && \
    cp  php-fpm.conf         /etc/php7/         && \
    apk --no-cache del --purge tzdata           && \
    rm -rf ~/.composer/cache /tmp/*             && \
    find / -name ".git" -type d | xargs rm -rf  && \
    grep -rl "REMOTE_ADDR" /var/www/html | xargs sed -i "s#REMOTE_ADDR#HTTP_X_REAL_IP#"              && \
    crontab -l | { cat;echo "* * * * * php /var/www/html/xcat checkjob";}           | crontab -     && \
    crontab -l | { cat;echo "00 22 * * * php /var/www/html/xcat dailyjob";}       | crontab -     && \
    crontab -l | { cat;echo "00 22 * * * php /var/www/html/xcat sendDiaryMail";}  | crontab -

WORKDIR /var/www/html/
EXPOSE 80

CMD crond && nginx && \
    php-fpm7 --nodaemonize --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini
