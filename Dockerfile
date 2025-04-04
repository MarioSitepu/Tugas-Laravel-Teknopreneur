FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan Laravel
RUN docker-php-ext-install pdo pdo_mysql

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

# Ubah kepemilikan dan permission untuk folder storage dan bootstrap/cache
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

EXPOSE 80

CMD ["apache2-foreground"]
