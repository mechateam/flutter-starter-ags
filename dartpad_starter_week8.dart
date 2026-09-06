import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU: DARTPAD SINGLE-FILE STARTER (Week 8: State & Lifecycle)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 🎯 WEEK 8 LEARNING GOALS:
// 1. Understand Widget Lifecycle (initState, build, dispose).
// 2. Implement Lifting State Up: cartItems is elevated to parent (_KantinKuAppState).
// 3. Pass and share live cart data between Menu and Cart views.
// 4. Call setState() to trigger live UI rebuilds when items are added.
//
// 📌 HOW THIS STARTER RUNS IN DARTPAD:
// In DartPad web, all code lives in a single file. Navigation between screens
// is simulated using boolean flags: `showMenu` and `showCart`.
// Because `cartItems` lives in the top-level parent widget, state is NEVER lost
// when switching views and automatically updates in real time!
//
// 🔍 LOOK FOR '// [CHANGE HERE]' COMMENTS TO CUSTOMIZE YOUR TEAM'S APP!
// ============================================================================

void main() {
  runApp(const KantinKuApp());
}

class KantinKuApp extends StatefulWidget {
  const KantinKuApp({super.key});

  @override
  State<KantinKuApp> createState() => _KantinKuAppState();
}

class _KantinKuAppState extends State<KantinKuApp> {
  // ==========================================================================
  // CONCEPT 1: LIFTING STATE UP (State stored in topmost parent)
  // cartItems acts as the "Single Source of Truth".
  // ==========================================================================
  List<Map<String, dynamic>> cartItems = [];

  // Boolean flags to simulate multi-screen navigation in DartPad browser
  bool showMenu = false;
  bool showCart = false;

  // [CHANGE HERE]: Canteen menu catalog (customize name, price, emoji, description)
  final List<Map<String, dynamic>> menuCatalog = [
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

  // ==========================================================================
  // CONCEPT 2: WIDGET LIFECYCLE: initState()
  // Called ONCE when the widget is first instantiated and inserted into tree.
  // Ideal location for initial setup, controller prep, or initial data loads.
  // ==========================================================================
  @override
  void initState() {
    super.initState(); // Always call super first!
    // ignore: avoid_print
    print('====================================================');
    // ignore: avoid_print
    print('LIFECYCLE: KantinKuApp born (initState)!');
    // ignore: avoid_print
    print('Initial setup complete. Available menu items: ${menuCatalog.length}');
    // ignore: avoid_print
    print('====================================================');
  }

  // ==========================================================================
  // CONCEPT 2: WIDGET LIFECYCLE: dispose()
  // Called when the widget is permanently removed from memory.
  // ==========================================================================
  @override
  void dispose() {
    // ignore: avoid_print
    print('LIFECYCLE: KantinKuApp disposed (teardown complete)');
    super.dispose();
  }

  // Calculate total price of current cart items
  int get totalPrice {
    return cartItems.fold<int>(0, (sum, item) => sum + (item['price'] as int));
  }

  // Add item to parent cart state
  void _addItemToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
  }

  // ==========================================================================
  // BUILD METHOD: Live (Called every time setState triggers a rebuild)
  // ==========================================================================
  @override
  Widget build(BuildContext context) {
    // [CHANGE HERE]: Primary brand theme color
    const Color brandTeal = Color(0xFF0E7C86);

    return MaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandTeal),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF7F2EC),
        appBar: AppBar(
          title: Text(
            showMenu
                ? 'Canteen Food Menu'
                : showCart
                    ? 'Shopping Cart'
                    : 'KantinKu', // [CHANGE HERE]: Your team's app name
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: brandTeal,
          elevation: 0,
          leading: (showMenu || showCart)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Return to Home view
                    setState(() {
                      showMenu = false;
                      showCart = false;
                    });
                  },
                )
              : null,
          actions: [
            // Cart count badge in app bar
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    showCart = true;
                    showMenu = false;
                  });
                },
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
                        const Icon(Icons.shopping_cart, size: 16, color: Color(0xFF1A1A2E)),
                        const SizedBox(width: 4),
                        Text(
                          '${cartItems.length}',
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
            ),
          ],
        ),
        body: SafeArea(
          // Conditional Screen Rendering based on active view state
          child: showMenu
              ? _buildMenuView(brandTeal)
              : showCart
                  ? _buildCartView(brandTeal)
                  : _buildHomeView(brandTeal),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SCREEN 1: HOME VIEW
  // --------------------------------------------------------------------------
  Widget _buildHomeView(Color brandColor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Card
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
                        child: Icon(Icons.storefront, color: brandColor, size: 32),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KantinKu App', // [CHANGE HERE]: Banner title
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Week 8: State Management & Lifecycle',
                              style: TextStyle(fontSize: 12.5, color: Color(0xFF607D8B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAF7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF8E9AAF), width: 0.5),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 20, color: brandColor),
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
            'Navigation Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),

          // Browse Menu Button
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                showMenu = true;
                showCart = false;
              });
            },
            icon: const Icon(Icons.restaurant_menu, color: Colors.white),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text(
                'Browse Canteen Menu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: brandColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 12),

          // View Cart Button
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                showCart = true;
                showMenu = false;
              });
            },
            icon: Icon(Icons.shopping_bag_outlined, color: brandColor),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Text(
                'View Cart (${cartItems.length} Items)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: brandColor),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: brandColor, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          const Spacer(),

          // Info Box
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
                    'Notice: cartItems remains intact as you switch between Menu and Cart views because state was lifted up to the parent!',
                    style: TextStyle(fontSize: 12, color: Color(0xFFD4880A), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SCREEN 2: MENU VIEW
  // --------------------------------------------------------------------------
  Widget _buildMenuView(Color brandColor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: const Color(0xFFE8F4FD),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 20, color: brandColor),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Tap "+ Add" on any menu item. The cart count in the top-right updates live!',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF0A5A61)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: menuCatalog.length,
            itemBuilder: (context, index) {
              final item = menuCatalog[index];
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
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAF7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['emoji'] as String,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                      const SizedBox(width: 14),
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
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: brandColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _addItemToCart(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
        // Bottom Complete Order Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  showMenu = false;
                  showCart = true;
                });
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  'Complete Order: View Cart (${cartItems.length})',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // SCREEN 3: CART VIEW
  // --------------------------------------------------------------------------
  Widget _buildCartView(Color brandColor) {
    if (cartItems.isEmpty) {
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
                'Cart is Empty',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              const Text(
                'No meals have been selected yet. Browse the canteen menu to place an order!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF607D8B)),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    showMenu = true;
                    showCart = false;
                  });
                },
                icon: const Icon(Icons.restaurant_menu, color: Colors.white),
                label: const Text('Browse Menu Now', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFFE8F4FD),
          child: Text(
            'Active orders (${cartItems.length} items):',
            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0A5A61)),
          ),
        ),
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
                    item['desc'] as String? ?? 'Order',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF607D8B)),
                  ),
                  trailing: Text(
                    'Rp ${item['price']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: brandColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Summary Checkout Card
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
                    'Rp $totalPrice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: brandColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Reset cart after checkout
                    setState(() {
                      cartItems.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment successful! Your cart has been cleared.'),
                        backgroundColor: Color(0xFF4CAF50),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
