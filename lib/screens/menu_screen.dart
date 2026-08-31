import 'package:flutter/material.dart';
import 'cart_screen.dart';

// ============================================================================
// 🍽️ MENUSCREEN - KANTINKU STARTER TEMPLATE (Week 6 & 7)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// File ini adalah halaman Daftar Menu yang menerima data nama dari Login/Sign Up.
// Di file ini kamu bisa mengganti daftar makanan, stan, harga, dan ikon!
// ============================================================================

class MenuScreen extends StatelessWidget {
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // [GANTI DI SINI]: Sesuaikan daftar menu makanan & minuman tim kamu!
    final List<Map<String, dynamic>> menuItems = [
      {'name': 'Nasi Goreng Spesial', 'price': 'Rp 18.000', 'icon': Icons.rice_bowl, 'stall': 'Kantin A'},
      {'name': 'Mie Ayam Bakso',       'price': 'Rp 15.000', 'icon': Icons.ramen_dining, 'stall': 'Kantin B'},
      {'name': 'Ayam Geprek Sambal',   'price': 'Rp 20.000', 'icon': Icons.set_meal, 'stall': 'Kantin A'},
      {'name': 'Es Teh Manis Jumbo',   'price': 'Rp 5.000',  'icon': Icons.local_drink, 'stall': 'Kantin C'},
      {'name': 'Gado-Gado Jakarta',    'price': 'Rp 14.000', 'icon': Icons.grass, 'stall': 'Kantin B'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // [GANTI DI SINI]: Warna background
      appBar: AppBar(
        title: const Text(
          'Menu Kantin', // [GANTI DI SINI]: Judul halaman menu
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Lihat Keranjang',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Buka CartScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(userName: userName),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Salam Siswa
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFE8F4FD),
                    radius: 24,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'S',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, $userName!',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61)),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Mau pesan apa untuk istirahat hari ini?',
                          style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Judul Bagian Menu
            const Text(
              'Daftar Menu Tersedia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 12),

            // Render Kartu-Kartu Menu
            ...menuItems.map((item) => _buildMenuCard(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk membuat kartu setiap menu makanan
  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8F4FD),
          child: Icon(
            item['icon'] as IconData,
            color: const Color(0xFF0E7C86),
          ),
        ),
        title: Text(
          item['name'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          '${item['stall']}  •  ${item['price']}',
          style: const TextStyle(color: Color(0xFF607D8B), fontSize: 13),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0E7C86),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          onPressed: () {
            // 🚀 Buka CartScreen membawa data item yang dipilih
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  userName: userName,
                  selectedItem: item['name'] as String,
                  selectedPrice: item['price'] as String,
                ),
              ),
            );
          },
          child: const Text('Pesan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
