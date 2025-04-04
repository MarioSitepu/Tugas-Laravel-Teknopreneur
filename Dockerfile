# Gunakan image resmi PHP dengan Apache
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy semua file proyek ke dalam container
COPY . .

# Install Composer dan dependencies Laravel
RUN apt-get update && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Salin .env (pastikan .env.example ada)
RUN cp .env.example .env

# Generate app key
RUN php artisan key:generate

# Set permission untuk storage dan bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Expose port 80 untuk Apache (default)
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]
