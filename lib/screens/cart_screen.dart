import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU: CART SCREEN (Week 8: Reading Shared State from Parent)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// WEEK 8 CONCEPTS DEMONSTRATED HERE:
// 1. Receiving State via Constructor: CartScreen receives `cartItems` from HomeScreen.
// 2. Stateless Architecture: CartScreen does not need its own state,
//    it simply renders the data owned and shared by HomeScreen (Lifting State Up).
// 3. Data Aggregation: Calculates total order price using `fold()`.
// 4. Empty State Handling: Friendly UI when the cart has no items.
//
// Look for '// [CHANGE HERE]' comments to customize your team's cart screen!
// ============================================================================

class CartScreen extends StatelessWidget {
  // [CHANGE HERE]: Receives cart items stored in HomeScreen
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    const Color brandTeal = Color(0xFF0E7C86);

    // Calculate total price of all items in cart
    final int totalPrice = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: brandTeal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: cartItems.isEmpty
            ? _buildEmptyState(context, brandTeal)
            : _buildCartList(context, brandTeal, totalPrice),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Empty state view when cart contains no items
  // --------------------------------------------------------------------------
  Widget _buildEmptyState(BuildContext context, Color brandColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F4FD),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove_shopping_cart_outlined, size: 64, color: brandColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cart is Empty', // [CHANGE HERE]: Empty state title
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 8),
            const Text(
              'You have not selected any meals yet. Browse the canteen menu to place an order!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF607D8B)),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.restaurant_menu, color: Colors.white),
              label: const Text('Back to Menu', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Populated cart view with list of items and checkout summary
  // --------------------------------------------------------------------------
  Widget _buildCartList(BuildContext context, Color brandColor, int totalPrice) {
    return Column(
      children: [
        // Info bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFFE8F4FD),
          child: Text(
            'Total ${cartItems.length} items ready for payment:',
            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0A5A61)),
          ),
        ),

        // Items list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF8E9AAF), width: 0.5),
                ),
                child: ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAF7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['emoji'] as String? ?? '🍽️',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  title: Text(
                    item['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    item['desc'] as String? ?? 'KantinKu Order',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF607D8B)),
                  ),
                  trailing: Text(
                    'Rp ${item['price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF0E7C86),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Checkout Bottom Sheet Summary
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                offset: const Offset(0, -3),
                blurRadius: 10,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Payment:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                  ),
                  Text(
                    'Rp $totalPrice', // [CHANGE HERE]: Currency formatting
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E7C86),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Show confirmation SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment of Rp $totalPrice successful! Your order is being prepared.'),
                        backgroundColor: const Color(0xFF4CAF50),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'Pay Now', // [CHANGE HERE]: Pay button label
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
