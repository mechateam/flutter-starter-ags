import 'package:flutter/material.dart';
import 'menu_screen.dart';

// ============================================================================
// 🔐 LOGINSCREEN - KANTINKU STARTER TEMPLATE (Week 6: Navigation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// Ini adalah halaman Login - halaman pertama yang dilihat user.
// Tombol "Masuk" di sini menggunakan Navigator.push untuk membuka MenuScreen.
// ============================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E7C86), // [GANTI DI SINI]: warna background login
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo / Ikon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.storefront, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),

                // App Title
                const Text(
                  'KantinKu', // [GANTI DI SINI]: Nama aplikasi tim kamu
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Pesan makanan kantin dengan mudah', // [GANTI DI SINI]: Tagline
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 40),

                // Name Input
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama kamu', // [GANTI DI SINI]
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Masuk Button — THIS IS THE KEY PART
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0E7C86),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      final name = _nameController.text.trim().isEmpty
                          ? 'Siswa'
                          : _nameController.text.trim();

                      // ✅ Navigator.push: Buka halaman Menu!
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(userName: name),
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk', // [GANTI DI SINI]: Teks tombol
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
