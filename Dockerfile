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

# Buat SQLite DB file dan set permission
RUN mkdir -p database && touch database/database.sqlite \
    && chown -R www-data:www-data storage bootstrap/cache database \
    && chmod -R 775 storage bootstrap/cache database

RUN sed -i 's/80/10000/g' /etc/apache2/ports.conf /etc/apache2/sites-available/000-default.conf
EXPOSE 10000
ENV PORT=10000
CMD ["apache2-foreground"]
    