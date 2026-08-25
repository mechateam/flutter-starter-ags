# 🧭 KantinKu - Panduan Praktikum Week 6: Navigation & Routing
**Alta Global School | IT Grade 10 & 11 (SHS)**  
*Sprint 2: Routing & Multi-Screen Architecture*

---

## 🗂️ Perubahan Template Minggu Ini

Template sudah diupdate dengan 3 screen baru yang saling terhubung:

| File | Fungsi |
|---|---|
| `lib/main.dart` | Entry point. Sekarang mengarah ke `LoginScreen`. |
| `lib/screens/login_screen.dart` | **Halaman Login** — tombol Masuk membuka MenuScreen. |
| `lib/screens/menu_screen.dart` | **Halaman Menu** — daftar makanan, tombol Pesan membuka CartScreen. |
| `lib/screens/cart_screen.dart` | **Halaman Cart** — ringkasan pesanan dan konfirmasi pembayaran. |
| `lib/screens/home_screen.dart` | *(Tetap ada untuk referensi Week 5, tidak dipakai di main lagi.)* |

---

## 💡 Pilih Jalur Menjalankan Aplikasi

| Opsi | Kapan Memilih | Waktu Setup |
|---|---|---|
| 🌐 **Jalur 1: DartPad** | Laptop tanpa Flutter / RAM terbatas | 0 detik |
| 🔵 **Jalur 2: VS Code + Chrome** | VS Code sudah terinstall | 1 menit |
| 🟢 **Jalur 3: Android Studio** | Android Studio sudah siap sejak Week 1 | 2 menit |

---

## 🌐 JALUR 1: DartPad (Tanpa Installasi)

> Karena DartPad hanya bisa menjalankan **satu file**, kamu perlu menggabungkan semua kode ke dalam satu file.

1. Buka [https://dartpad.dev](https://dartpad.dev)
2. Hapus semua kode bawaan (`Ctrl + A` lalu `Delete`)
3. Copy isi file **`dartpad_starter_week6.dart`** (ada di folder template)
4. Paste ke DartPad, klik **Run**
5. Hasil: Aplikasi KantinKu 3 screen langsung berjalan di browser!

---

## 🔵 JALUR 2: VS Code + Chrome (Direkomendasikan)

### A. Setup (Sekali Saja)
1. Buka **VS Code**
2. Extensions (`Ctrl + Shift + X`) cari **Flutter** lalu Install
3. Ekstrak **`AGS_Flutter_Starter.zip`** ke folder Documents kamu

### B. Menjalankan Project
1. **File** > **Open Folder** > pilih folder `AGS_Flutter_Starter`
2. Buka Terminal (`Ctrl + ~`) lalu ketik:
   ```bash
   flutter pub get
   ```
3. Di pojok kanan bawah, pilih device **Chrome (web)**
4. Tekan **F5** — browser Chrome akan terbuka otomatis

### C. Melihat Hasilnya
- Halaman Login akan muncul pertama
- Isi nama kamu, klik **Masuk** — berpindah ke Halaman Menu
- Klik **Pesan** pada salah satu menu — berpindah ke Cart
- Klik **Bayar Sekarang** — dialog muncul, lalu kembali ke Login

---

## 🟢 JALUR 3: Android Studio

1. **Open** folder `AGS_Flutter_Starter`
2. Tunggu Gradle sync selesai, klik **Pub get** jika ada notifikasi
3. Device target: pilih **Chrome (web)** atau emulator
4. Klik ▶️ **Run**

---

## 🛠️ Tugas Kelompok: Hubungkan Layar Proyekmu

Setelah template berhasil jalan, langkah berikutnya:

### Langkah 1: Buat file screen untuk proyekmu
```
lib/
  screens/
    login_screen.dart      <- sudah ada (edit sesuai brandmu)
    menu_screen.dart       <- sudah ada (edit nama & harga menu)
    cart_screen.dart       <- sudah ada (edit tampilan cart)
```

### Langkah 2: Sesuaikan LoginScreen dengan wireframe timmu
Buka `lib/screens/login_screen.dart`, cari komentar **`[GANTI DI SINI]`**:
- Ganti nama aplikasi, warna background, tagline
- Ganti placeholder teks input

### Langkah 3: Sesuaikan MenuScreen dengan menu proyek timmu
Buka `lib/screens/menu_screen.dart`:
```dart
// [GANTI DI SINI]: Ganti daftar menu dengan menu tim kamu!
final List<Map<String, dynamic>> menuItems = [
  {'name': 'Nama Menu 1', 'price': 'Rp XX.000', 'icon': Icons.rice_bowl, 'stall': 'Nama Stan'},
  // Tambah menu ke-2, ke-3, dst...
];
```

### Langkah 4: Pastikan Navigator.push terpasang di tombol

Ini adalah kode paling penting. Pastikan ada di tombol aksi kamu:
```dart
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NamaScreenSelanjutnya(),
    ),
  );
},
```

### Langkah 5: Pastikan ada jalan pulang (Navigator.pop atau AppBar)

AppBar sudah otomatis menampilkan tombol Back. Kalau tidak pakai AppBar:
```dart
ElevatedButton(
  onPressed: () { Navigator.pop(context); },
  child: const Text('Kembali'),
)
```

---

## ❓ Solusi Kendala Umum

| Kendala | Solusi |
|---|---|
| **Error: Could not find target 'LoginScreen'** | Pastikan `import 'screens/login_screen.dart';` ada di `main.dart` |
| **Error: The named parameter 'userName' is required** | Setiap kali kamu push ke `MenuScreen`, wajib isi `userName:` |
| **Layar hitam / blank setelah push** | Cek apakah nama class di builder sama persis dengan nama class di file |
| **Tombol back tidak muncul** | Pastikan screen kedua menggunakan `Scaffold` dengan `AppBar` |
| **Data tidak tersampaikan ke screen berikutnya** | Gunakan constructor parameter seperti `MenuScreen(userName: name)` |

---

## 📤 Pengumpulan Tugas

Upload ke **Google Classroom: [Sprint 1] Week 6: Navigation Submission**:

1. **Screenshot / Screen Recording:** Rekam atau screenshot 3 transisi layer (Login > Menu > Cart)
2. **Source Code:** Zip folder `AGS_Flutter_Starter` yang sudah kamu modifikasi

---

*Sprint 2 — Semangat! Aplikasi yang bisa navigate antar screen sudah 70% jadi produk nyata. 🚀*
