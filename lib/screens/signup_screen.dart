import 'package:flutter/material.dart';
import 'menu_screen.dart';

// ============================================================================
// 📝 SIGNUPSCREEN - KANTINKU STARTER TEMPLATE (Week 7: Form & Validation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// Ini adalah halaman Daftar Akun Baru (Sign Up).
// Di file ini kamu mempelajari 3 konsep utama Flutter Form:
// 1. GlobalKey<FormState>: Kunci untuk mengecek apakah semua input sudah valid.
// 2. TextEditingController: Jembatan untuk mengambil teks yang diketik siswa.
// 3. validator: Aturan pengecekan (tidak boleh kosong, password minimal 6 digit).
// ============================================================================

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // --------------------------------------------------------------------------
  // 🔑 1. FORM KEY & CONTROLLERS
  // --------------------------------------------------------------------------
  // _formKey bertindak sebagai 'rem' sebelum data dikirim: memastikan tidak ada input kosong
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller untuk membaca teks dari masing-masing kotak input (TextFormField)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Status untuk menyembunyikan atau menampilkan password (mata tertutup/terbuka)
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // [GANTI DI SINI]: Warna background form
      appBar: AppBar(
        title: const Text(
          'Daftar Akun KantinKu', // [GANTI DI SINI]: Judul header aplikasi tim kamu
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86), // [GANTI DI SINI]: Warna tema utama
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // ------------------------------------------------------------------
            // 📋 2. WIDGET FORM
            // Widget Form membungkus semua TextFormField agar bisa divalidasi sekaligus
            // ------------------------------------------------------------------
            child: Form(
              key: _formKey, // Pasangkan form key di sini
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header & Salam
                  const Text(
                    'Buat Akun Siswa Baru', // [GANTI DI SINI]: Judul form pendaftaran
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A5A61),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Lengkapi formulir di bawah ini untuk mulai memesan makanan kantin.', // [GANTI DI SINI]: Subtitle
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),

                  // ============================================================
                  // 🏷️ INPUT 1: NAMA LENGKAP
                  // ============================================================
                  const Text(
                    'Nama Lengkap',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Contoh: Budi Pratama', // [GANTI DI SINI]
                      prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    // 🛡️ VALIDATOR NAMA: Tidak boleh kosong
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama lengkap tidak boleh kosong'; // Pesan jika error
                      }
                      if (value.trim().length < 3) {
                        return 'Nama terlalu pendek (minimal 3 huruf)';
                      }
                      return null; // Return null artinya input SUDAH BENAR / VALID
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // 🏷️ INPUT 2: KELAS & NIS
                  // ============================================================
                  const Text(
                    'Kelas / NIS', // [GANTI DI SINI]: Bisa diganti 'Nomor Meja' atau 'Email'
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _classController,
                    decoration: InputDecoration(
                      hintText: 'Contoh: 10-B (NIS: 2026010)', // [GANTI DI SINI]
                      prefixIcon: const Icon(Icons.school_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    // 🛡️ VALIDATOR KELAS: Tidak boleh kosong
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kelas / NIS wajib diisi';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // 🏷️ INPUT 3: KATA SANDI (PASSWORD)
                  // ============================================================
                  const Text(
                    'Kata Sandi (Password)',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword, // Menyembunyikan karakter password
                    decoration: InputDecoration(
                      hintText: 'Minimal 6 karakter', // [GANTI DI SINI]
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF0E7C86)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF64748B),
                        ),
                        onPressed: () {
                          // Ubah status obscure saat tombol mata ditekan
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    // 🛡️ VALIDATOR PASSWORD: Minimal 6 karakter
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // 🏷️ INPUT 4: KONFIRMASI KATA SANDI
                  // ============================================================
                  const Text(
                    'Konfirmasi Kata Sandi',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Ulangi kata sandi di atas', // [GANTI DI SINI]
                      prefixIcon: const Icon(Icons.lock_reset_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    // 🛡️ VALIDATOR KONFIRMASI: Harus sama persis dengan password pertama
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password wajib diisi';
                      }
                      if (value != _passwordController.text) {
                        return 'Password tidak cocok, mohon periksa kembali';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 32),

                  // ============================================================
                  // 🚀 3. TOMBOL SUBMIT (DAFTAR SEKARANG)
                  // ============================================================
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7C86), // [GANTI DI SINI]: Warna tombol
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        // 🔍 CEK VALIDASI KESELURUHAN FORM
                        // _formKey.currentState!.validate() akan memanggil validator di SEMUA TextFormField
                        if (_formKey.currentState!.validate()) {
                          final userName = _nameController.text.trim();

                          // 1. Tampilkan SnackBar hijau tanda pendaftaran berhasil
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selamat datang, $userName! Akun berhasil dibuat.'),
                              backgroundColor: const Color(0xFF0E7C86),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          // 2. Langsung pindah ke MenuScreen membawa nama yang didaftarkan
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuScreen(userName: userName),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Daftar Sekarang', // [GANTI DI SINI]: Teks tombol submit
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tombol Kembali ke Login
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Kembali ke halaman LoginScreen (pop)
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sudah punya akun? Masuk di sini',
                        style: TextStyle(
                          color: Color(0xFF0E7C86),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 🧹 DISPOSE CONTROLLERS (Mencegah kebocoran memori RAM laptop/HP)
  // --------------------------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
