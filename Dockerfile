FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    unzip curl libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite

WORKDIR /var/www/html

COPY . .

RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# HAPUS cp .env.example .env dan key:generate

# Buat file SQLite & permission
RUN mkdir -p database && touch database/database.sqlite \
    && chown -R www-data:www-data storage bootstrap/cache database \
    && chmod -R 775 storage bootstrap/cache database

# Clear semua cache config
RUN php artisan config:clear \
    && php artisan route:clear \
    && php artisan view:clear \
    && php artisan cache:clear

EXPOSE 80
CMD ["apache2-foreground"]
