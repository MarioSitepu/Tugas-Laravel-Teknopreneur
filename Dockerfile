# Gunakan image resmi PHP dengan Apache
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy semua file proyek ke dalam container
COPY . .

# Install Composer dan dependencies Laravel
RUN apt-get update && apt-get install -y unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader

# Set permission untuk storage dan bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Expose port 80 untuk web server
EXPOSE 80

# Jalankan Laravel menggunakan Apache
CMD ["apache2-foreground"]
