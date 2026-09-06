import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU: MENU SCREEN (Week 8: Receiving Data & Returning Updates)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// WEEK 8 CONCEPTS DEMONSTRATED HERE:
// 1. Constructor Parameter: Receives `cartSaatIni` from HomeScreen.
// 2. initState(): Copies constructor data into local state `_localCart`.
// 3. setState(): Adds food items to local cart when 'Add' button is pressed.
// 4. Navigator.pop(context, _localCart): Returns updated cart list back to
//    HomeScreen when 'Complete Order' button is tapped.
//
// Look for '// [CHANGE HERE]' comments to customize your team's canteen menu!
// ============================================================================

class MenuScreen extends StatefulWidget {
  // [CHANGE HERE]: Receives current cart data from HomeScreen
  final List<Map<String, dynamic>> cartSaatIni;
  final String? userName;

  const MenuScreen({
    super.key,
    this.cartSaatIni = const [],
    this.userName,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Local temporary cart list on MenuScreen
  late List<Map<String, dynamic>> _localCart;

  // [CHANGE HERE]: Canteen menu catalog (customize name, price, emoji, description)
  final List<Map<String, dynamic>> kantinMenu = [
    {
      'name': 'Special Fried Rice',
      'price': 15000,
      'emoji': '🍳',
      'desc': 'Wok-fried rice with fried egg and savory shredded chicken',
    },
    {
      'name': 'Chicken Meatball Noodles',
      'price': 13000,
      'emoji': '🍜',
      'desc': 'Chewy noodles in savory broth with 2 beef meatballs',
    },
    {
      'name': 'Crispy Sambal Chicken',
      'price': 18000,
      'emoji': '🍗',
      'desc': 'Crispy battered chicken with fresh spicy sambal and rice',
    },
    {
      'name': 'Iced Jasmine Sweet Tea',
      'price': 5000,
      'emoji': '🧊',
      'desc': 'Chilled aromatic jasmine sweet tea',
    },
  ];

  // --------------------------------------------------------------------------
  // LIFECYCLE 1: initState()
  // Copy list from widget.cartSaatIni into _localCart so changes stay isolated
  // until the student explicitly taps 'Complete Order'.
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _localCart = List<Map<String, dynamic>>.from(widget.cartSaatIni);
    // ignore: avoid_print
    print('=== LIFECYCLE: MenuScreen born (initState) ===');
    // ignore: avoid_print
    print('MenuScreen received ${_localCart.length} items from HomeScreen');
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('=== LIFECYCLE: MenuScreen closed (dispose) ===');
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // ACTION: Add item to local cart with setState()
  // --------------------------------------------------------------------------
  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      _localCart.add(item);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['emoji']} ${item['name']} added to cart!'),
        duration: const Duration(milliseconds: 1200),
        backgroundColor: const Color(0xFF0E7C86),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color brandTeal = Color(0xFF0E7C86);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: Text(
          widget.userName != null ? 'Menu (${widget.userName})' : 'Canteen Food Catalog',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: brandTeal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Return updated local cart when back button is tapped
            Navigator.pop(context, _localCart);
          },
        ),
        actions: [
          // Cart count badge in AppBar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD166),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_bag, size: 16, color: Color(0xFF1A1A2E)),
                    const SizedBox(width: 4),
                    Text(
                      '${_localCart.length}',
                      style: const TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top helper banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFFE8F4FD),
              child: const Row(
                children: [
                  Icon(Icons.touch_app, size: 20, color: brandTeal),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Select your favorite food. Tap "Complete Order" below when finished.',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF0A5A61)),
                    ),
                  ),
                ],
              ),
            ),

            // List of Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: kantinMenu.length,
                itemBuilder: (context, index) {
                  final item = kantinMenu[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Color(0xFF8E9AAF), width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Emoji box
                          Container(
                            width: 52,
                            height: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAF7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['emoji'] as String,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['desc'] as String,
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF607D8B)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Rp ${item['price']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0E7C86),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add Button
                          ElevatedButton(
                            onPressed: () => _addToCart(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brandTeal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 16),
                                SizedBox(width: 4),
                                Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ----------------------------------------------------------------------
      // FLOATING ACTION BUTTON: Complete Order (Returns data to HomeScreen)
      // ----------------------------------------------------------------------
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.pop returns _localCart to HomeScreen (parent)
          Navigator.pop(context, _localCart);
        },
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        label: Text(
          'Complete Order (${_localCart.length})',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: brandTeal,
      ),
    );
  }
}
