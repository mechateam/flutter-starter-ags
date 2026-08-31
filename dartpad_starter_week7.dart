import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU - DARTPAD STARTER WEEK 7 (All-in-One Single File)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 🎯 LEARNING OBJECTIVES FOR HIGH SCHOOL STUDENTS:
// 1. Navigation (Week 6): Move between screens with Navigator.push / Navigator.pop.
// 2. Form Validation (Week 7): Capture and verify user input before submission.
// 3. Data Passing: Send student name from Login/SignUp forward to Menu and Cart.
//
// 💡 HOW TO RUN ON DARTPAD (https://dartpad.dev):
// 1. Open https://dartpad.dev in Google Chrome.
// 2. Clear all default code (Ctrl+A / Cmd+A, then delete).
// 3. Paste this entire file into DartPad.
// 4. Click the blue 'Run' button in the top right.
// ============================================================================

void main() {
  runApp(const KantinKuApp());
}

// ============================================================================
// CLASS 1: KantinKuApp (Root Application Widget)
//
// PURPOSE:
// The entry point of the Flutter application. It sets up the MaterialApp,
// defines the global color theme (Teal), and sets the initial screen.
// ============================================================================
class KantinKuApp extends StatelessWidget {
  const KantinKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary brand color used across buttons and app bars
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
        useMaterial3: true,
      ),
      // Set LoginScreen as the very first screen users see
      home: const LoginScreen(),
    );
  }
}

// ============================================================================
// CLASS 2: LoginScreen (StatefulWidget)
//
// PURPOSE:
// The entry screen where users can either log in quickly by entering their name
// or navigate to the Sign Up screen to register a new account.
// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ============================================================================
// CLASS 3: _LoginScreenState (State for LoginScreen)
//
// PURPOSE:
// Manages the text controller for quick login and handles two navigation routes:
// 1. Log In button -> Navigator.push to MenuScreen (carrying student name)
// 2. Sign Up button -> Navigator.push to SignUpScreen (for Form validation)
// ============================================================================
class _LoginScreenState extends State<LoginScreen> {
  // Controller to read the name entered in the quick login text field
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Main theme background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Canteen Icon Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.restaurant_menu, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),

                // App Title & Subtitle
                const Text(
                  'KantinKu', // [CHANGE HERE]: Your group's unique app name
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text(
                  'Order canteen food quickly and effortlessly', // [CHANGE HERE]: Tagline
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 36),

                // Quick Login Text Input
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter your name', // [CHANGE HERE]: Input placeholder
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

                // Button 1: Quick Log In (Navigates to MenuScreen)
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

                      // Navigator.push: Place MenuScreen on top of the navigation stack
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

                // Visual Divider
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

                // Button 2: Create Account (Navigates to SignUpScreen for Form Validation)
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
                      // Navigator.push: Move forward to SignUpScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    label: const Text(
                      'Create New Account (Sign Up)',
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

  // Dispose controller to release device memory
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// ============================================================================
// CLASS 4: SignUpScreen (StatefulWidget)
//
// PURPOSE:
// The registration screen widget. Since form inputs change dynamically and
// password visibility toggles, this must be a StatefulWidget.
// ============================================================================
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// ============================================================================
// CLASS 5: _SignUpScreenState (State for SignUpScreen)
//
// PURPOSE:
// The core Form Validation engine!
// 1. _formKey (GlobalKey<FormState>): Master validator lock.
// 2. 4 TextEditingControllers: Reads Full Name, Class/ID, Password, Confirm Password.
// 3. validator functions: Checks each field for empty text or short passwords.
// 4. SnackBar: Displays a green success banner on valid submit.
// ============================================================================
class _SignUpScreenState extends State<SignUpScreen> {
  // 1. Master key for the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. Controllers for each input field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 3. Password visibility toggle state
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // [CHANGE HERE]: Page background
      appBar: AppBar(
        title: const Text(
          'Create KantinKu Account', // [CHANGE HERE]: Title
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // Form widget wraps all TextFormFields so they can be validated simultaneously
            child: Form(
              key: _formKey, // Attach master key here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Student Registration', // [CHANGE HERE]: Header
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Fill out the form below to start ordering canteen food.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),

                  // ----------------------------------------------------------
                  // FIELD 1: FULL NAME
                  // ----------------------------------------------------------
                  const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Alex Johnson', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.person_outline, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // Validator: checks if empty or less than 3 letters
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Full name is required';
                      if (value.trim().length < 3) return 'Name must be at least 3 characters';
                      return null; // null means valid
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // FIELD 2: CLASS / STUDENT ID
                  // ----------------------------------------------------------
                  const Text('Class / Student ID', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 10-B (ID: 2026010)', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.school_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // Validator: cannot be empty
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Class / Student ID is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // FIELD 3: PASSWORD
                  // ----------------------------------------------------------
                  const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword, // Hides characters with dots
                    decoration: InputDecoration(
                      hintText: 'Minimum 6 characters', // [CHANGE HERE]
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF0E7C86)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF64748B)),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // Validator: minimum 6 characters
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // ----------------------------------------------------------
                  // FIELD 4: CONFIRM PASSWORD
                  // ----------------------------------------------------------
                  const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: const InputDecoration(
                      hintText: 'Re-enter your password', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.lock_reset_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // Validator: must match initial password
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),

                  // ----------------------------------------------------------
                  // SUBMIT BUTTON (SIGN UP NOW)
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
                        // _formKey.currentState!.validate() checks ALL validators at once
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

                          // 2. Navigate to MenuScreen carrying registered name
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuScreen(userName: userName),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign Up Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Back to Login Button
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context), // Go back to login
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

  // Dispose all 4 controllers when leaving this screen
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
// CLASS 6: MenuScreen (StatelessWidget)
//
// PURPOSE:
// Displays the food & beverage menu catalog. It receives the student's name
// via its constructor (userName) and shows a personalized greeting card.
// Tapping 'Order' navigates forward to CartScreen.
// ============================================================================
class MenuScreen extends StatelessWidget {
  // Variable to receive student name from Login or Sign Up screen
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // [CHANGE HERE]: Customize your food menu catalog!
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
        title: const Text('Canteen Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'View Cart',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Open CartScreen directly
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
            // Personalized Greeting Card
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
                        Text('Hello, $userName!', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0A5A61))),
                        const SizedBox(height: 2),
                        const Text('What would you like to order for break today?', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text('Available Menu Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 12),

            // Render food menu cards dynamically
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
                    // Navigate to CartScreen carrying the chosen food item
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
// CLASS 7: CartScreen (StatelessWidget)
//
// PURPOSE:
// The final checkout confirmation screen. Displays the student's name,
// chosen item, total price calculation, and opens a success dialog on pay.
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
            // Item details card
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
            // Total payment row
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
            // Pay Now Button (Shows success dialog)
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
                            Navigator.popUntil(context, (route) => route.isFirst); // Return to home/login
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
