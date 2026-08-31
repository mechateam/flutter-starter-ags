# 🛒 KantinKu - Panduan Praktikum Form & Validasi (Week 7)
**Alta Global School | IT Grade 10 & 11 (SHS)**  
*Sprint 2: Multi-Screen Navigation, Form & State Management*

---

## 🎯 Tujuan Pembelajaran Hari Ini
Hari ini setiap kelompok akan menambahkan **Halaman Pendaftaran Akun Siswa (Sign Up Screen)** pada aplikasi KantinKu dengan fitur **Validasi Form**:
1. Menggunakan widget `Form` dan `GlobalKey<FormState>` sebagai pengaman data.
2. Menggunakan `TextEditingController` untuk menangkap input nama, kelas/NIS, dan password.
3. Memasang aturan `validator` agar form tidak bisa dikirim jika ada kolom yang kosong atau password terlalu pendek.
4. Menghubungkan alur pendaftaran ke `MenuScreen` membawa nama akun yang baru dibuat.

---

## 📢 Khusus Siswa Grade 10-B (Materi Gabungan Week 6 & 7)
Karena minggu lalu kelas 10-B libur, tugas minggu ini menggabungkan:
- **Week 6:** Navigasi antar halaman (`Navigator.push`, `Navigator.pop`).
- **Week 7:** Pembuatan Form pendaftaran (`Form`, `TextEditingController`, `validator`).

Semua alur sudah disatukan di template ini: `LoginScreen` ➡️ `SignUpScreen` ➡️ `MenuScreen` ➡️ `CartScreen`.

---

## 💡 Pilih Jalur Praktikum Sesuai Laptop Kamu

| Opsi | Kapan Memilih Opsi Ini? | Panduan Singkat |
|---|---|---|
| 🌐 **Jalur 1: Google DartPad (Web Browser)** | Laptop spek terbatas (RAM 4GB) atau belum install Flutter/IDE. | Buka **[dartpad.dev](https://dartpad.dev)**, hapus semua kode, copy isi file `dartpad_starter_week7.dart`, lalu klik **Run**. |
| 🔵 **Jalur 2: VS Code + Chrome Web** | Rekomendasi utama untuk koding cepat dan ringan. | Buka folder project di VS Code, pilih device **`Chrome (web)`**, tekan **`F5`**. |
| 🟢 **Jalur 3: Android Studio** | Bagi yang sudah memakai Android Studio sejak Week 1. | Buka folder di Android Studio, klik **`Pub get`**, pilih device **`Chrome (web)`**, klik tombol **Run `▶️`**. |

---

## 🛠️ Panduan Koding: Yang Perlu Dimodifikasi Kelompok Kamu

Buka file **`lib/screens/signup_screen.dart`** dan cari tanda komentar **`[GANTI DI SINI]`**:

### 1. Sesuaikan Judul & Tema Warna
- Ubah judul form `'Buat Akun Siswa Baru'` sesuai konsep aplikasi tim kamu.
- Sesuaikan warna AppBar dan tombol (`Color(0xFF0E7C86)`).

### 2. Tambah / Modifikasi Kolom Input (TextFormField)
Di template sudah tersedia 4 kolom input:
- **Nama Lengkap:** Cek validator minimal 3 huruf.
- **Kelas / NIS:** Bisa kamu ubah menjadi `'Nomor WhatsApp'` atau `'Nomor Meja'`.
- **Kata Sandi:** Cek validator minimal 6 karakter.
- **Konfirmasi Sandi:** Cek kecocokan dengan kata sandi utama.

### 3. Coba Fitur Validasi (Uji Coba Bug)
1. Jalankan aplikasi di browser/emulator.
2. Klik tombol **Daftar Akun Baru (Sign Up)**.
3. Langsung klik tombol **Daftar Sekarang** tanpa mengisi kotak apapun.
4. **Hasil yang benar:** Garis merah dan pesan error peringatan akan muncul di bawah kotak yang kosong!

---

## ❓ Tanya Jawab & Solusi Kendala Umum (Troubleshooting)

| Kendala | Penyebab | Solusi |
|---|---|---|
| **Pesan merah tidak muncul saat submit ditekan** | Lupa memanggil `_formKey.currentState!.validate()` | Pastikan tombol memanggil `if (_formKey.currentState!.validate())` sebelum `Navigator.push`. |
| **Password tetap terlihat / tidak berbintang** | `obscureText` bernilai `false` | Pastikan properti `obscureText: _obscurePassword` terpasang di `TextFormField` password. |
| **Error: A Key must be unique** | `GlobalKey` dideklarasikan di dalam method `build()` | Pindahkan deklarasi `final _formKey = GlobalKey<FormState>();` ke atas (di dalam class `_SignUpScreenState`). |

---

## 📤 Pengumpulan Tugas (Google Classroom)

Kumpulkan bukti praktikum kelompokmu:
1. **Screenshot 1:** Halaman Sign Up saat menampilkan pesan error validasi (ketika submit kosong).
2. **Screenshot 2:** Halaman Sign Up saat berhasil terisi dan berpindah ke Menu dengan salam nama kamu.
3. **Source Code:** Zip folder project atau copy link DartPad kelompokmu.

*Selamat bereksplorasi dan membangun aplikasi impian tim kamu! 🚀*
