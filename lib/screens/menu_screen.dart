import 'package:flutter/material.dart';
import 'cart_screen.dart';

// ============================================================================
// 🍽️ MENUSCREEN - KANTINKU STARTER TEMPLATE (Week 6: Navigation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// File ini adalah halaman Daftar Menu setelah user berhasil login.
// Sesuaikan nama menu, harga, ikon, dan warna dengan wireframe tim kamu!
// ============================================================================

class MenuScreen extends StatelessWidget {
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // [GANTI DI SINI]: Ganti daftar menu dengan menu kantin tim kamu!
    final List<Map<String, dynamic>> menuItems = [
      {'name': 'Nasi Goreng Spesial', 'price': 'Rp 18.000', 'icon': Icons.rice_bowl, 'stall': 'Kantin A'},
      {'name': 'Mie Ayam Bakso',       'price': 'Rp 15.000', 'icon': Icons.ramen_dining, 'stall': 'Kantin B'},
      {'name': 'Ayam Geprek',          'price': 'Rp 20.000', 'icon': Icons.set_meal, 'stall': 'Kantin A'},
      {'name': 'Es Teh Manis',         'price': 'Rp 5.000',  'icon': Icons.local_drink, 'stall': 'Kantin C'},
      {'name': 'Gado-Gado',            'price': 'Rp 14.000', 'icon': Icons.grass, 'stall': 'Kantin B'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Menu Kantin', // [GANTI DI SINI]: Judul halaman menu
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
        // AppBar otomatis menampilkan tombol "Back" karena ini screen ke-2
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // [GANTI DI SINI]: Nanti bisa navigate ke CartScreen
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
            // Greeting
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Halo, $userName! Pilih menu kamu:', // Menerima nama dari LoginScreen
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A5A61),
                ),
              ),
            ),

            // Daftar Menu
            ...menuItems.map((item) => _buildMenuCard(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 8,
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
            // TODO: Tambahkan ke cart, lalu push ke CartScreen
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
          child: const Text('Pesan', style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
