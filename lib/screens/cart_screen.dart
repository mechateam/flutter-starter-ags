import 'package:flutter/material.dart';

// ============================================================================
// CART SCREEN - KANTINKU STARTER TEMPLATE (Week 6 & 7)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// STUDENT GUIDE:
// This is the Order Summary & Checkout Confirmation Screen.
// It receives user name and selected item data via constructor arguments.
// ============================================================================

class CartScreen extends StatelessWidget {
  final String userName;
  final String selectedItem;
  final String selectedPrice;

  const CartScreen({
    super.key,
    required this.userName,
    this.selectedItem = 'Special Fried Rice',
    this.selectedPrice = 'Rp 18.000',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Order Cart', // [CHANGE HERE]: Cart title
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
            // Student Order Header
            Text(
              'Order for $userName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A5A61),
              ),
            ),
            const SizedBox(height: 20),

            // Item Details Card
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
                subtitle: const Text('Quantity: 1 Portion', style: TextStyle(color: Color(0xFF607D8B))),
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

            // Total Payment Row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Payment:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

            // Pay Now Button
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
                  // Show confirmation alert dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Order Successful!'),
                      content: Text('$selectedItem has been ordered for $userName. Please collect at the canteen counter.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.popUntil(context, (route) => route.isFirst); // Return to home/login
                          },
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Pay Now',
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
