# EduTrack - Student Activity Management Platform

EduTrack is a starter project built with Laravel 11, designed to help students manage their learning activities and notes. It features a clean, MVC-structured codebase with a minimal and professional UI using Tailwind CSS.

## Features

### Core Modules
- **Authentication**: Secure login and registration.
- Composer
- MySQL

## Langkah Instalasi

Ikuti langkah-langkah berikut untuk menjalankan proyek di komputer lokal Anda:

1.  **Clone Repositori**
    ```bash
    git clone https://github.com/reyhananf/edutrack.git
    cd edutrack
    ```

2.  **Instal Dependensi**
    ```bash
    composer install
    ```

3.  **Konfigurasi Lingkungan (.env)**
    Salin file `.env.example` ke `.env` dan sesuaikan konfigurasi database:
    ```bash
    cp .env.example .env
    ```
    Buka file `.env` dan atur:
    ```env
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=edutrack
    DB_USERNAME=root
    DB_PASSWORD=
    ```

4.  **Generate Key Aplikasi**
    ```bash
    php artisan key:generate
    ```

5.  **Migrasi dan Seeding Database**
    Jalankan perintah ini untuk membuat tabel dan mengisi data awal (termasuk akun Siswa):
    ```bash
    php artisan migrate --seed
    ```

6.  **Jalankan Server Lokal**
    ```bash
    php artisan serve
    ```
    Akses aplikasi di `http://localhost:8000`.

## Akses Login Default

Setelah menjalankan seeding, Anda dapat masuk menggunakan akun berikut:

-   **Email**: `siswa@edutrack.com`
-   **Password**: `password`

## Deploy Demo Gratis

EduTrack menggunakan Laravel 13, PHP 8.3, dan migrasi MySQL. Konfigurasi deploy tersedia untuk Render; database demo menggunakan MySQL Free dari Aiven.

1. Buat layanan MySQL Free di [Aiven](https://aiven.io/). Catat host, port, nama database, username, password, lalu unduh CA certificate.
2. Push branch `deploy/latest` ke fork GitHub. Jangan commit `.env`, password, atau file sertifikat.
3. Di [Render](https://render.com/), pilih **New > Blueprint** dan hubungkan fork pada branch `deploy/latest`.
4. Pada Environment service Render, isi `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, dan `DB_PASSWORD` dari Aiven. URL aplikasi diambil otomatis dari Render.
5. Tambahkan Secret File bernama `aiven-ca.pem` di Render dengan isi CA certificate Aiven. `MYSQL_ATTR_SSL_CA` sudah diarahkan ke `/etc/secrets/aiven-ca.pem`.
6. Tunggu deploy dan migrasi selesai. EduTrack dibuka di root URL; game catur tersedia pada `/index.html`.
7. Masukkan URL HTTPS Render ke [PWABuilder](https://www.pwabuilder.com/) untuk membuat paket Android.

Paket gratis ditujukan untuk demo: Render dapat menidurkan service saat idle; layanan Aiven Free memiliki batas sumber daya dan dapat dinonaktifkan jika tidak digunakan lama. Jangan pakai untuk data penting tanpa backup.

## Struktur Data

- **Models**:
  - `App\Models\User`
  - `App\Models\Note`
  - `App\Models\Subject`
  - `App\Models\Assignment`
  - `App\Models\Schedule`
  - `App\Models\Grade`
  - `App\Models\Attendance`

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
