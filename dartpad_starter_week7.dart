import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU - DARTPAD STARTER (Week 7: Form & Validation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 📌 HOW THIS STARTER CODE IS ORGANIZED:
// - SECTION 1: App Setup (KantinKuApp) -> Global Theme & Initial Screen
// - SECTION 2: Login Screen (LoginScreen) -> App Entry & Quick Login
// - SECTION 3: Sign Up Form (SignUpScreen) -> YOUR MAIN WEEK 7 MISSION
// - SECTION 4: Food Menu (MenuScreen) -> Personalized Greeting & Menu Items
// - SECTION 5: Order Cart (CartScreen) -> Checkout & Payment Dialog
//
// 🔍 LOOK FOR '// [CHANGE HERE]' COMMENTS TO CUSTOMIZE YOUR TEAM'S APP!
// ============================================================================

void main() {
  runApp(const KantinKuApp());
}

// ============================================================================
// SECTION 1: APP SETUP (KantinKuApp)
//
// WHAT YOU CAN EDIT HERE:
// - seedColor: Change the primary theme color for your entire application.
// ============================================================================
class KantinKuApp extends StatelessWidget {
  const KantinKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Primary brand color
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ============================================================================
// SECTION 2: LOGIN SCREEN (LoginScreen)
//
// WHAT YOU CAN EDIT HERE:
// 1. App Title ('KantinKu') and Tagline below it.
// 2. Background Color (Color(0xFF0E7C86)).
// 3. Input placeholder text ('Enter your name').
// 4. 'Log In' button styling and navigation.
// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Captures the text typed in the quick login box
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Login background color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Logo Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.restaurant_menu, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),

                // [CHANGE HERE]: App Name & Tagline
                const Text(
                  'KantinKu', // [CHANGE HERE]: Your group's app name
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text(
                  'Order canteen food quickly and effortlessly', // [CHANGE HERE]: Tagline
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 36),

                // [CHANGE HERE]: Name Input Field
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter your name', // [CHANGE HERE]: Placeholder hint
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Button 1: Quick Log In -> Navigates to MenuScreen
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0E7C86),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    onPressed: () {
                      final name = _nameController.text.trim().isEmpty
                          ? 'AGS Student'
                          : _nameController.text.trim();

                      // Navigator.push: Move forward to MenuScreen carrying student name
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(userName: name),
                        ),
                      );
                    },
                    child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider Line
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.white38)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'NEW USER?',
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8), letterSpacing: 1.1),
                      ),
                    ),
                    const Expanded(child: Divider(color: Colors.white38)),
                  ],
                ),
                const SizedBox(height: 20),

                // Button 2: Create Account -> Navigates to SignUpScreen
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.person_add_alt_1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    label: const Text(
                      'Create New Account (Sign Up)', // [CHANGE HERE]: Button label
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// ============================================================================
// SECTION 3: SIGN UP REGISTRATION FORM (SignUpScreen)
// ⭐ YOUR MAIN WEEK 7 PRACTICUM MISSION ⭐
//
// WHAT YOU SHOULD EDIT & CUSTOMIZE HERE:
// 1. Form Header ('New Student Registration') and Subtitle.
// 2. Field 1 (Full Name): Edit placeholder or minimum length validator.
// 3. Field 2 (Class / Student ID): You can change this into 'Table Number',
//    'WhatsApp Number', or 'Email Address'.
// 4. Field 3 & 4 (Password): Edit minimum length requirement (e.g. 6 chars).
// 5. Submit Button ('Sign Up Now'): Customize button styling and SnackBar text.
//
// HOW TO TEST VALIDATION:
// 1. Run the app and click 'Create New Account (Sign Up)'.
// 2. Tap 'Sign Up Now' with all boxes empty: red error borders will appear!
// 3. Fill in correct info and tap submit: green SnackBar appears and opens Menu.
// ============================================================================
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Master key that controls validation across all fields in the Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to read text typed by the student
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Controls show/hide password characters
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // [CHANGE HERE]: Page background
      appBar: AppBar(
        title: const Text(
          'Create KantinKu Account', // [CHANGE HERE]: AppBar Title
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Theme color
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // Form widget wraps all TextFormFields
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Titles
                  const Text(
                    'New Student Registration', // [CHANGE HERE]: Form Title
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Fill out the form below to start ordering canteen food.', // [CHANGE HERE]: Description
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),

                  // ----------------------------------------------------------
                  // [EDITABLE FIELD 1]: FULL NAME
                  // ----------------------------------------------------------
                  const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Alex Johnson', // [CHANGE HERE]: Placeholder
                      prefixIcon: Icon(Icons.person_outline, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: returns error string if empty or < 3 characters
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Full name is required';
                      if (value.trim().length < 3) return 'Name must be at least 3 characters';
                      return null; // Valid!
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // [EDITABLE FIELD 2]: CLASS / STUDENT ID
                  // (Tip: You can rename this to 'Table Number' or 'WhatsApp Number')
                  // ----------------------------------------------------------
                  const Text('Class / Student ID', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 10-B (ID: 2026010)', // [CHANGE HERE]: Placeholder
                      prefixIcon: Icon(Icons.school_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: cannot be empty
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Class / Student ID is required';
                      return null; // Valid!
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // [EDITABLE FIELD 3]: PASSWORD
                  // ----------------------------------------------------------
                  const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword, // Hides characters
                    decoration: InputDecoration(
                      hintText: 'Minimum 6 characters', // [CHANGE HERE]: Placeholder
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF0E7C86)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF64748B)),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: minimum 6 characters
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null; // Valid!
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // [EDITABLE FIELD 4]: CONFIRM PASSWORD
                  // ----------------------------------------------------------
                  const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: const InputDecoration(
                      hintText: 'Re-enter your password', // [CHANGE HERE]: Placeholder
                      prefixIcon: Icon(Icons.lock_reset_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: checks if matching Field 3
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null; // Valid!
                    },
                  ),
                  const SizedBox(height: 32),

                  // ----------------------------------------------------------
                  // [EDITABLE SUBMIT BUTTON]: SIGN UP NOW
                  // ----------------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Button color
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                      onPressed: () {
                        // _formKey.currentState!.validate() runs ALL field validators
                        if (_formKey.currentState!.validate()) {
                          final userName = _nameController.text.trim();

                          // 1. Show green success SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Welcome, $userName! Account created successfully.'),
                              backgroundColor: const Color(0xFF0E7C86),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          // 2. Navigate to MenuScreen carrying the registered name
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuScreen(userName: userName),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Sign Up Now', // [CHANGE HERE]: Button text
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Return to Login Link
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Already have an account? Log in here',
                        style: TextStyle(color: Color(0xFF0E7C86), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// ============================================================================
// SECTION 4: FOOD MENU CATALOG (MenuScreen)
//
// WHAT YOU CAN EDIT & CUSTOMIZE HERE:
// 1. menuItems List: Add your own food names, prices, stall names, and icons!
// 2. Greeting Header: Change greeting text or background colors.
// ============================================================================
class MenuScreen extends StatelessWidget {
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // ------------------------------------------------------------------------
    // [EDITABLE LIST]: FOOD & BEVERAGE MENU ITEMS
    // Customize food names, prices, and stall categories here!
    // ------------------------------------------------------------------------
    final List<Map<String, dynamic>> menuItems = [
      {'name': 'Special Fried Rice', 'price': 'Rp 18.000', 'icon': Icons.rice_bowl, 'stall': 'Stall A'},
      {'name': 'Chicken Noodles',    'price': 'Rp 15.000', 'icon': Icons.ramen_dining, 'stall': 'Stall B'},
      {'name': 'Crispy Chicken',     'price': 'Rp 20.000', 'icon': Icons.set_meal, 'stall': 'Stall A'},
      {'name': 'Iced Sweet Tea',     'price': 'Rp 5.000',  'icon': Icons.local_drink, 'stall': 'Stall C'},
      {'name': 'Vegetable Salad',    'price': 'Rp 14.000', 'icon': Icons.grass, 'stall': 'Stall B'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // [CHANGE HERE]: Background color
      appBar: AppBar(
        title: const Text(
          'Canteen Menu', // [CHANGE HERE]: Page Title
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'View Cart',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(userName: userName)),
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
            // User Greeting Header Card
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
                          'Hello, $userName!', // Displays the registered student's name
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61)),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'What would you like to order for break today?',
                          style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text('Available Menu Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 12),

            // Render Menu Cards
            ...menuItems.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE8F4FD),
                  child: Icon(item['icon'] as IconData, color: const Color(0xFF0E7C86)),
                ),
                title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('${item['stall']}  •  ${item['price']}', style: const TextStyle(color: Color(0xFF607D8B), fontSize: 13)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E7C86),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Navigate to CartScreen carrying chosen item details
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
                  child: const Text('Order', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 5: ORDER CART & CHECKOUT (CartScreen)
//
// WHAT YOU CAN EDIT & CUSTOMIZE HERE:
// 1. Order Summary Card layout.
// 2. Checkout Popup Dialog message.
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
        title: const Text('Order Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order for $userName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61))),
            const SizedBox(height: 20),

            // Item Details Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F4FD),
                  child: Icon(Icons.fastfood, color: Color(0xFF0E7C86)),
                ),
                title: Text(selectedItem, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text('Quantity: 1 Portion', style: TextStyle(color: Color(0xFF607D8B))),
                trailing: Text(selectedPrice, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0E7C86))),
              ),
            ),
            const SizedBox(height: 24),

            // Total Payment Row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Payment:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(selectedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0E7C86))),
                ],
              ),
            ),
            const Spacer(),

            // Pay Now Button (Shows checkout confirmation dialog)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7C86),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Order Successful!'),
                      content: Text('$selectedItem has been ordered for $userName. Please collect at the canteen counter.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.popUntil(context, (route) => route.isFirst); // Return to Login
                          },
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
