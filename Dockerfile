FROM php:8.2-apache

# Apache 모듈 활성화 (.htaccess 지원)
RUN a2enmod rewrite deflate expires headers

# zip 익스텐션 추가
RUN apt-get update && apt-get install -y libzip-dev && docker-php-ext-install zip

# Apache가 .htaccess를 읽도록 설정
RUN sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

# 프로젝트 전체 복사
COPY . /var/www/html/

# 권한 설정
RUN chown -R www-data:www-data /var/www/html

# 볼륨에 연결할 초기 데이터를 /init-data에 백업
RUN cp -r /var/www/html/content /init-data-content && \
    cp -r /var/www/html/cache   /init-data-cache   && \
    cp -r /var/www/html/users   /init-data-users   && \
    cp -r /var/www/html/history /init-data-history

# 엔트리포인트 스크립트 복사
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]