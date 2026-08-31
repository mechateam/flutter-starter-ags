import 'package:flutter/material.dart';

// ============================================================================
// 🛒 KANTINKU - STARTER TEMPLATE
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK UNTUK SISWA:
// 1. Template ini sudah 100% siap di-run di Android Studio / VS Code / Browser!
// 2. Cari komentar berlabel [GANTI DI SINI] untuk memodifikasi komponen.
// 3. Sesuaikan teks, ikon, warna, dan harga dengan Wireframe Figma tim kamu.
// ============================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Warna background abu-abu terang

      // ----------------------------------------------------------------------
      // 1. APPBAR (Bagian Header Atas)
      // [GANTI DI SINI]: Ubah judul aplikasi atau warna AppBar sesuai tema tim kamu
      // ----------------------------------------------------------------------
      appBar: AppBar(
        title: const Text(
          'KantinKu', // [GANTI DI SINI]: Judul aplikasi kantin kamu
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86), // [GANTI DI SINI]: Warna AppBar
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO (Week 6): Fitur pencarian menu
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO (Week 6): Fitur keranjang belanja
            },
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // 2. BODY (Bagian Konten Utama)
      // Menggunakan Column untuk menyusun elemen secara vertikal (atas ke bawah)
      // ----------------------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================================================================
            // KOMPONEN A: Kartu Informasi Siswa & Saldo
            // [GANTI DI SINI]: Ubah nama siswa, kelas, atau nominal saldo
            // ================================================================
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000), // Shadow halus
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      // Avatar Inisial Nama
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF0E7C86), // [GANTI DI SINI]: Warna avatar
                        child: Text(
                          'MS', // [GANTI DI SINI]: Inisial nama siswa
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meldi Sayoko', // [GANTI DI SINI]: Nama pengguna / persona
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                          ),
                          Text(
                            'Kelas 10-B • AGS', // [GANTI DI SINI]: Kelas / Identitas
                            style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Badge Saldo KantinKu
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Rp 45.000', // [GANTI DI SINI]: Saldo awal kantin
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFB45309)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), // Spacing pemisah antar komponen

            // ================================================================
            // KOMPONEN B: Banner Promo / Menu Spesial
            // [GANTI DI SINI]: Ubah judul promo, teks deskripsi, dan warna banner
            // ================================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A5A61), Color(0xFF0E7C86)], // [GANTI DI SINI]: Warna gradien
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D0E7C86),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD166),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'MENU SPESIAL HARI INI', // [GANTI DI SINI]: Label promo
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nasi Goreng Spesial Kantin', // [GANTI DI SINI]: Nama menu promo
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pre-order sekarang untuk jam istirahat 12.00 WIB.', // [GANTI DI SINI]: Deskripsi
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================================================================
            // KOMPONEN C: Daftar Menu Kantin
            // [GANTI DI SINI]: Ubah judul kategori & daftar item menu di bawah ini
            // ================================================================
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu Populer Hari Ini', // [GANTI DI SINI]: Judul section
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                Text(
                  'Lihat Semua', // [GANTI DI SINI]: Action link
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E7C86)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Kartu Menu Item 1 (Makanan Utama)
            // [GANTI DI SINI]: Sesuaikan nama, harga, dan stan penjual
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mie Ayam Bakso + Es Teh', // [GANTI DI SINI]: Nama Menu
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                      ),
                      Text(
                        'Rp 18.000', // [GANTI DI SINI]: Harga Menu
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kantin Bu Siti (Stan 03)', // [GANTI DI SINI]: Nama Penjual
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO (Week 6): Aksi saat tombol pesan ditekan
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 14),
                        label: const Text('Pesan', style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E7C86),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Kartu Menu Item 2 (Makanan Utama)
            // [GANTI DI SINI]: Sesuaikan nama, harga, dan stan penjual
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nasi Ayam Geprek Sambal Bawang', // [GANTI DI SINI]: Nama Menu
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                      ),
                      Text(
                        'Rp 15.000', // [GANTI DI SINI]: Harga Menu
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kantin Pak Joko (Stan 01)', // [GANTI DI SINI]: Nama Penjual
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO (Week 6): Aksi saat tombol pesan ditekan
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 14),
                        label: const Text('Pesan', style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E7C86),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Kartu Menu Item 3 (Minuman Segar)
            // [GANTI DI SINI]: Sesuaikan nama, harga, dan stan penjual
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Es Teh Manis Jumbo', // [GANTI DI SINI]: Nama Minuman
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                      ),
                      Text(
                        'Rp 5.000', // [GANTI DI SINI]: Harga Minuman
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kantin Bu Siti (Stan 03)', // [GANTI DI SINI]: Nama Penjual
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO (Week 6): Aksi saat tombol pesan ditekan
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 14),
                        label: const Text('Pesan', style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E7C86),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      // ----------------------------------------------------------------------
      // 3. BOTTOM NAVIGATION BAR
      // [GANTI DI SINI]: Sesuaikan tab menu navigasi bawah dengan wireframe kamu
      // ----------------------------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF0E7C86),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedFontSize: 11,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
