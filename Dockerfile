FROM node:22-alpine AS assets
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY resources ./resources
COPY public ./public
COPY vite.config.js tsconfig.json postcss.config.js tailwind.config.js components.json ./
RUN npm run build

FROM php:8.3-cli AS vendor
RUN apt-get update && apt-get install -y --no-install-recommends libicu-dev libonig-dev libzip-dev \
    && docker-php-ext-install intl mbstring pcntl pdo_mysql sockets zip \
    && rm -rf /var/lib/apt/lists/*
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
WORKDIR /app
COPY . .
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

FROM php:8.3-apache
RUN apt-get update && apt-get install -y --no-install-recommends libicu-dev libonig-dev libzip-dev \
    && docker-php-ext-install intl mbstring pcntl pdo_mysql sockets zip \
    && a2enmod rewrite \
    && sed -ri 's/Listen 80/Listen 10000/' /etc/apache2/ports.conf \
    && sed -ri 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri 's/:80>/:10000>/' /etc/apache2/sites-available/000-default.conf \
    && sed -ri 's/^[[:space:]]*DirectoryIndex .*/DirectoryIndex index.php index.html/' /etc/apache2/mods-available/dir.conf \
    && sed -ri '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY --from=vendor /app ./
COPY --from=assets /app/public/ ./public/
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 10000
CMD ["sh", "-c", "export APP_URL=\"${APP_URL:-${RENDER_EXTERNAL_URL:-http://localhost}}\"; php artisan config:cache && php artisan migrate --force && chown -R www-data:www-data storage bootstrap/cache && exec apache2-foreground"]