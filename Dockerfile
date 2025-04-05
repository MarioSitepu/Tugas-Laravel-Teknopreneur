FROM php:8.2-apache

# Install dependensi sistem & ekstensi PHP untuk PDO, MySQL & SQLite
RUN apt-get update && apt-get install -y \
    unzip curl libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite

WORKDIR /var/www/html

COPY . .

# Arahkan Apache ke public dan aktifkan rewrite
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && a2enmod rewrite

# Install Composer & dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Setup .env dan generate APP_KEY
RUN cp .env.example .env \
    && php artisan key:generate

# Set permission untuk storage & cache
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 80
CMD ["apache2-foreground"]
