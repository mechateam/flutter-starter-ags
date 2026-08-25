import 'package:flutter/material.dart';

// ============================================================================
// 🛒 KANTINKU - DARTPAD WEEK 6 STARTER (Single File Version)
// Alta Global School | IT Grade 10 & 11 (SHS)
// Salin seluruh kode ini ke https://dartpad.dev lalu klik Run!
// ============================================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}

// ─── SCREEN 1: LOGIN ────────────────────────────────────────────────────────
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
      backgroundColor: const Color(0xFF0E7C86), // [GANTI DI SINI]: warna background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                  child: const Icon(Icons.storefront, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text('KantinKu', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text('Pesan makanan kantin dengan mudah', style: TextStyle(fontSize: 14, color: Colors.white70)),
                const SizedBox(height: 40),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama kamu',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white38)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white, width: 2)),
                  ),
                ),
                const SizedBox(height: 16),
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
                      final name = _nameController.text.trim().isEmpty ? 'Siswa' : _nameController.text.trim();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen(userName: name)));
                    },
                    child: const Text('Masuk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
  void dispose() { _nameController.dispose(); super.dispose(); }
}

// ─── SCREEN 2: MENU ─────────────────────────────────────────────────────────
class MenuScreen extends StatelessWidget {
  final String userName;
  const MenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // [GANTI DI SINI]: Ganti dengan menu proyek tim kamu
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
        title: const Text('Menu Kantin', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(userName: userName))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text('Halo, $userName! Pilih menu kamu:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61))),
            ),
            ...menuItems.map((item) => _buildCard(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 8, offset: const Offset(0, 2))]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(backgroundColor: const Color(0xFFE8F4FD), child: Icon(item['icon'] as IconData, color: const Color(0xFF0E7C86))),
        title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text('${item['stall']}  •  ${item['price']}', style: const TextStyle(color: Color(0xFF607D8B), fontSize: 13)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0E7C86), foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => CartScreen(userName: userName, selectedItem: item['name'] as String, selectedPrice: item['price'] as String),
          )),
          child: const Text('Pesan', style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}

// ─── SCREEN 3: CART ─────────────────────────────────────────────────────────
class CartScreen extends StatelessWidget {
  final String userName;
  final String selectedItem;
  final String selectedPrice;

  const CartScreen({super.key, required this.userName, this.selectedItem = 'Nasi Goreng Spesial', this.selectedPrice = 'Rp 18.000'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Keranjang Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pesanan $userName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61))),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 8, offset: const Offset(0, 2))]),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(backgroundColor: Color(0xFFE8F4FD), child: Icon(Icons.rice_bowl, color: Color(0xFF0E7C86))),
                title: Text(selectedItem, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text('Jumlah: 1', style: TextStyle(color: Color(0xFF607D8B))),
                trailing: Text(selectedPrice, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0E7C86))),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(selectedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86))),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7C86), foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Pesanan Berhasil!'),
                      content: Text('$selectedItem sudah dipesan. Silakan ambil di kantin.'),
                      actions: [
                        TextButton(
                          onPressed: () { Navigator.pop(ctx); Navigator.popUntil(context, (r) => r.isFirst); },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Bayar Sekarang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
