import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';

// ============================================================================
// KANTINKU: HOME SCREEN (Week 8: State Management & Widget Lifecycle)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// WEEK 8 CONCEPTS DEMONSTRATED HERE:
// 1. Lifting State Up: HomeScreen acts as the 'State Owner'
//    The `cartItems` list is stored here so it can be shared with Menu & Cart.
// 2. Widget Lifecycle:
//    - initState(): Called ONCE when the screen first enters memory.
//    - dispose(): Called when the screen is permanently destroyed to clean up.
// 3. Passing Data Down: Forwarding cartItems via constructor parameters.
// 4. Returning Data Up: Awaiting results from MenuScreen via Navigator.push
//    and calling setState() to trigger live UI rebuilds.
//
// Look for '// [CHANGE HERE]' comments to customize your team's application!
// ============================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // [CHANGE HERE]: Single Source of Truth (Primary State Owner)
  // All cart items are stored here, not inside MenuScreen or CartScreen.
  List<Map<String, dynamic>> cartItems = [];

  // --------------------------------------------------------------------------
  // LIFECYCLE 1: initState()
  // Called ONCE when the widget is created and inserted into the widget tree.
  // Use for controller initialization, data pre-loading, or listener setup.
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState(); // Must always be called first!
    // ignore: avoid_print
    print('=== LIFECYCLE: HomeScreen born (initState) ===');
    // ignore: avoid_print
    print('Welcome to KantinKu! System ready to receive orders.');
  }

  // --------------------------------------------------------------------------
  // LIFECYCLE 2: dispose()
  // Called when the widget is removed permanently from the tree.
  // Use to clean up controllers, streams, or timers to prevent memory leaks.
  // --------------------------------------------------------------------------
  @override
  void dispose() {
    // ignore: avoid_print
    print('=== LIFECYCLE: HomeScreen closed (dispose) ===');
    // ignore: avoid_print
    print('Cleaning up resources and ending KantinKu session.');
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // NAVIGATION WITH RETURN VALUE: _openMenu()
  // Opens MenuScreen and AWAITS the updated cart list.
  // When MenuScreen pops with new data, setState() is called to rebuild the UI.
  // --------------------------------------------------------------------------
  Future<void> _openMenu() async {
    // 1. Pass current cart data down via constructor
    final updatedCart = await Navigator.push<List<Map<String, dynamic>>>(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(cartSaatIni: cartItems),
      ),
    );

    // 2. If the user tapped 'Complete Order' and returned an updated list
    if (updatedCart != null) {
      setState(() {
        // Update parent state
        cartItems = List<Map<String, dynamic>>.from(updatedCart);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cart updated: ${cartItems.length} items stored!'),
            backgroundColor: const Color(0xFF0E7C86),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // --------------------------------------------------------------------------
  // VIEW NAVIGATION: _viewCart()
  // Passes cartItems to CartScreen so students can view their order summary.
  // --------------------------------------------------------------------------
  void _viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems),
      ),
    );
  }

  // Calculate total price of all items in cart
  int get totalPrice {
    return cartItems.fold<int>(0, (sum, item) => sum + (item['price'] as int));
  }

  @override
  Widget build(BuildContext context) {
    // [CHANGE HERE]: Primary brand theme color
    const Color brandTeal = Color(0xFF0E7C86);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: const Text(
          'KantinKu', // [CHANGE HERE]: Your canteen team name
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: brandTeal,
        elevation: 0,
        actions: [
          // Cart Badge in top-right corner
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: _viewCart,
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD166),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Banner Card
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F4FD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.storefront, color: brandTeal, size: 32),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Digital School Canteen', // [CHANGE HERE]: App subtitle
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Order meals effortlessly without queueing',
                                  style: TextStyle(fontSize: 13, color: Color(0xFF607D8B)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      // State Management Status Indicator
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAF7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF8E9AAF), width: 0.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 20, color: brandTeal),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'State Owner: ${cartItems.length} items in cart (Rp $totalPrice)',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0A5A61),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Main Navigation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 12),

              // Button 1: Browse Menu & Order (Opens MenuScreen + passes data)
              ElevatedButton.icon(
                onPressed: _openMenu,
                icon: const Icon(Icons.restaurant_menu, color: Colors.white),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    'Browse Canteen Menu', // [CHANGE HERE]: Menu button label
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandTeal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),

              const SizedBox(height: 14),

              // Button 2: View Cart (Opens CartScreen)
              OutlinedButton.icon(
                onPressed: _viewCart,
                icon: const Icon(Icons.shopping_bag_outlined, color: brandTeal),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    'View Cart (${cartItems.length} Items)', // [CHANGE HERE]: Cart button label
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: brandTeal),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: brandTeal, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const Spacer(),

              // Week 8 Architectural Reminder
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFD166)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Color(0xFFD4880A)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Week 8 Concept: HomeScreen stores cartItems (State Owner). MenuScreen updates it via pop, and HomeScreen triggers setState()!',
                        style: TextStyle(fontSize: 12, color: Color(0xFFD4880A), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
