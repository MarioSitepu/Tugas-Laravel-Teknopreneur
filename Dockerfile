FROM php:8.2-apache

# Install ekstensi PHP (PDO untuk MySQL & SQLite)
RUN docker-php-ext-install pdo pdo_mysql pdo_sqlite

# Set working directory
WORKDIR /var/www/html

# Copy semua file proyek ke dalam container
COPY . .

# Update config Apache agar root-nya ke /public Laravel
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Install Composer dan dependencies Laravel
RUN apt-get update && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Salin file .env dan generate APP_KEY
RUN cp .env.example .env
RUN php artisan key:generate

# Buat file SQLite dan set permission
RUN mkdir -p database && touch database/database.sqlite \
    && chown -R www-data:www-data database storage bootstrap/cache \
    && chmod -R 775 database storage bootstrap/cache

# Clear dan cache config biar pakai .env yang baru
RUN php artisan config:clear && php artisan config:cache

EXPOSE 80

CMD ["apache2-foreground"]
