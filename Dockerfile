FROM php:8.2-apache

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

COPY . .

# Update config Apache agar root-nya ke /public Laravel
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

RUN apt-get update && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

RUN cp .env.example .env

RUN php artisan key:generate

RUN chmod -R 775 storage bootstrap/cache

EXPOSE 80

CMD ["apache2-foreground"]
