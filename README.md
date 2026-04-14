# Shopping List

**Proyek Pembelajaran** - Aplikasi ini dibuat hanya untuk tujuan pembelajaran dan eksplorasi Flutter. Tidak untuk distribusi atau penggunaan komersial.

Aplikasi daftar belanja sederhana yang dibuat dengan Flutter. Aplikasi ini memungkinkan pengguna untuk menambah, melihat, dan menghapus item belanja dengan kategori yang berbeda. Data disimpan di Firebase Realtime Database.

## Fitur

- **Tambah Item Baru**: Pengguna dapat menambahkan item belanja baru dengan nama, jumlah, dan kategori.
- **Lihat Daftar Belanja**: Menampilkan semua item belanja dalam daftar dengan warna kategori.
- **Hapus Item**: Pengguna dapat menghapus item dari daftar.
- **Kategori Item**: Item dibagi ke dalam berbagai kategori seperti Sayuran, Buah, Daging, Susu, dll.
- **Tema Gelap**: Aplikasi menggunakan tema gelap untuk pengalaman yang nyaman.

## Teknologi yang Digunakan

- **Flutter**: Framework untuk membangun aplikasi mobile.
- **Firebase Realtime Database**: Untuk penyimpanan data online.
- **HTTP Package**: Untuk komunikasi dengan API Firebase.
- **Flutter Dotenv**: Untuk mengelola variabel environment.

## Persyaratan Sistem

- Flutter SDK versi 3.11.4 atau lebih baru.
- Dart SDK yang kompatibel.
- Akun Firebase untuk database.

## Setup dan Instalasi

1. **Clone Repository**:
   ```
   git clone <url-repository>
   cd shopping_list
   ```

2. **Install Dependencies**:
   ```
   flutter pub get
   ```

3. **Setup Firebase**:
   - Buat proyek baru di [Firebase Console](https://console.firebase.google.com/).
   - Aktifkan Realtime Database.
   - Salin URL database (misalnya: `your-project.firebaseio.com`).

4. **Konfigurasi Environment**:
   - Buat file `.env` di root direktori proyek.
   - Tambahkan URL Firebase Anda:
     ```
     FIREBASE_URL=your-project.firebaseio.com
     ```

5. **Jalankan Aplikasi**:
   ```
   flutter run
   ```

## Struktur Proyek

```
lib/
├── main.dart              # Entry point aplikasi
├── data/
│   ├── categories.dart    # Definisi kategori item
│   └── dummy_items.dart   # Data dummy untuk testing
├── models/
│   ├── category.dart      # Model untuk kategori
│   └── grocery_item.dart  # Model untuk item belanja
└── widgets/
    ├── grocery_list.dart  # Widget untuk daftar belanja
    └── new_item.dart      # Widget untuk form tambah item
```

## Cara Penggunaan

1. **Menjalankan Aplikasi**: Jalankan `flutter run` di terminal.
2. **Menambah Item**: Tekan tombol "+" di aplikasi untuk membuka form tambah item.
3. **Mengisi Form**: Masukkan nama item, jumlah, dan pilih kategori.
4. **Simpan Item**: Tekan "Add Item" untuk menyimpan.
5. **Melihat Daftar**: Item akan muncul di daftar utama dengan warna kategori.
6. **Menghapus Item**: Geser item ke kiri atau kanan untuk menghapus.
