# UMKM REST API (CodeIgniter 4) dan Flutter

Tugas Pemrograman Mobile Topic 10: REST API dan JSON Parsing.

## Struktur
- `backend/` : REST API CodeIgniter 4
- `frontend/` : Aplikasi Flutter (GetX + http)

## Endpoint
| Method | URL | Fungsi |
|---|---|---|
| GET | /api/umkm | Ambil semua data |
| POST | /api/umkm | Tambah data |
| PUT | /api/umkm/{id} | Ubah data |
| DELETE | /api/umkm/{id} | Hapus data |

## Menjalankan Backend
1. `cd backend`
2. `composer install`
3. Salin `env.example` menjadi `.env`, atur database `db_umkm`
4. `php spark migrate`
5. `php spark serve`

## Menjalankan Frontend
1. `cd frontend`
2. `flutter pub get`
3. `flutter run -d chrome`

Catatan: ubah `baseUrl` di `lib/app/services/service.dart` untuk emulator (`10.0.2.2`) atau HP fisik (IP laptop).
