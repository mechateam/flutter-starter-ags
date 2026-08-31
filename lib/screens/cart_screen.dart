import 'package:flutter/material.dart';

// ============================================================================
// 🛒 CARTSCREEN - KANTINKU STARTER TEMPLATE (Week 6 & 7)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// Ini adalah halaman Keranjang Pesanan & Konfirmasi Checkout.
// Halaman ini menerima data nama user dan menu terpilih melalui constructor.
// ============================================================================

class CartScreen extends StatelessWidget {
  final String userName;
  final String selectedItem;
  final String selectedPrice;

  const CartScreen({
    super.key,
    required this.userName,
    this.selectedItem = 'Nasi Goreng Spesial',
    this.selectedPrice = 'Rp 18.000',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Keranjang Pesanan', // [GANTI DI SINI]: Judul keranjang
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Nama Pemesan
            Text(
              'Pesanan $userName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A5A61),
              ),
            ),
            const SizedBox(height: 20),

            // Kartu Rincian Menu yang Dipesan
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F4FD),
                  child: Icon(Icons.fastfood, color: Color(0xFF0E7C86)),
                ),
                title: Text(
                  selectedItem,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: const Text('Jumlah: 1 Porsi', style: TextStyle(color: Color(0xFF607D8B))),
                trailing: Text(
                  selectedPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF0E7C86),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Baris Total Pembayaran
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    selectedPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E7C86),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Tombol Bayar Sekarang (Konfirmasi)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7C86),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                onPressed: () {
                  // Tampilkan popup konfirmasi
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pesanan Berhasil!'),
                      content: Text('$selectedItem telah dipesan untuk $userName. Silakan ambil di kantin.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup dialog
                            Navigator.popUntil(context, (route) => route.isFirst); // Kembali ke halaman awal (Login)
                          },
                          child: const Text('Kembali ke Menu Utama'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
