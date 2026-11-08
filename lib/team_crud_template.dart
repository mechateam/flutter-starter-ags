import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================================
// ALTA GLOBAL SCHOOL: IT SHS (GRADES 10 & 11)
// SPRINT 3: WEEK 16 - STRATEGY 2 IMPLEMENTATION (SHELL + CORE ENGINE)
// PACKAGES: INTL + MATERIAL 3 BUILT-IN WIDGETS (DATEPICKER, CHIPS, BADGE)
// TEACHER: MELDI (100% ONLINE VIA GOOGLE MEET)
// ============================================================================
//
// ARCHITECTURE OVERVIEW (STRATEGY 2: SHELL + CORE ENGINE):
// 1. Tier 1 (Shell): WelcomeScreen
//    Lightweight greeting & login screen connecting Week 6 (Navigation pushReplacement)
//    and Week 7 (Forms, TextFormField validation). Saves user name to SharedPreferences.
// 2. Tier 2 (Core Engine): DashboardScreen
//    The main team application wrapping dynamic CRUD, local storage persistence,
//    Material 3 showDatePicker, ChoiceChip/FilterChip, Badge, and intl formatting.
//
// TO INSTALL PACKAGES IN VS CODE TERMINAL:
// flutter pub add shared_preferences intl
// ============================================================================

// ============================================================================
// CUSTOMIZATION ZONE: CHANGE THESE VARIABLES FOR YOUR TEAM APP!
// ============================================================================

/// 1. Your App Name (Appears in top AppBar and Welcome Screen)
/// Examples: 'Tasky', 'PocketWise', 'ResQ', 'HabitHero', 'BullsEye'
const String appTitle = 'Tasky';

/// 2. What noun does your app manage?
/// Examples: 'Task', 'Expense', 'Contact', 'Habit', 'Target'
const String itemNoun = 'Task';

/// 3. Hint text shown inside the input box
/// Examples: 'Enter new task...', 'Enter expense description...', 'Enter habit...'
const String inputHintText = 'Enter a new task...';

/// 4. Icon displayed beside each item in your list
/// Examples:
/// - Tasks: Icons.check_circle_outline
/// - Expenses: Icons.attach_money
/// - Contacts: Icons.phone
/// - Habits: Icons.fitness_center
/// - Goals: Icons.flag
const IconData itemIcon = Icons.check_circle_outline;

/// 5. Your team theme accent color
/// Examples: Color(0xFF0E7C86) [Teal], Color(0xFF2563EB) [Blue], Color(0xFF7C3AED) [Purple]
const Color themeColor = Color(0xFF0E7C86);

/// 6. Category / Tag options for your team app
/// Examples:
/// - Tasky: ['General', 'Priority', 'Review']
/// - PocketWise: ['Food', 'Transport', 'Study']
/// - HabitHero: ['Morning', 'Afternoon', 'Evening']
const List<String> itemCategories = ['General', 'Priority', 'Review'];

/// 7. Default starter items for your team app
final List<TeamItem> defaultStarterItems = [
  TeamItem(
    title: 'Review Flutter sprint slides',
    date: DateTime.now(),
    category: 'Priority',
  ),
  TeamItem(
    title: 'Prepare team project demo',
    date: DateTime.now().add(const Duration(days: 2)),
    category: 'General',
  ),
];

// ============================================================================
// DATA MODEL: TEAM ITEM (WITH JSON SERIALIZATION FOR LOCAL STORAGE)
// ============================================================================

class TeamItem {
  final String title;
  final DateTime date;
  final String category;
  bool isCompleted;

  TeamItem({
    required this.title,
    required this.date,
    required this.category,
    this.isCompleted = false,
  });

  TeamItem.simple(String title, {String category = 'General'})
      : this(title: title, date: DateTime.now(), category: category);

  TeamItem clone() => TeamItem(
        title: title,
        date: date,
        category: category,
        isCompleted: isCompleted,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date.toIso8601String(),
        'category': category,
        'isCompleted': isCompleted,
      };

  factory TeamItem.fromJson(Map<String, dynamic> json) {
    return TeamItem(
      title: json['title'] as String? ?? 'Untitled Item',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      category: json['category'] as String? ?? 'General',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Backward-compatible parser for Week 15 raw string items
  factory TeamItem.fromRawString(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return TeamItem.fromJson(decoded);
      }
    } catch (_) {}
    return TeamItem(
      title: raw,
      date: DateTime.now(),
      category: 'General',
    );
  }
}

// ============================================================================
// ENTRY POINT & MATERIAL APP SHELL
// ============================================================================

void main() {
  runApp(const TeamApp());
}

class TeamApp extends StatelessWidget {
  const TeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeColor,
          primary: themeColor,
          surface: const Color(0xFFF7F2EC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F2EC),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ============================================================================
// TIER 1: WELCOME SCREEN (THE SHELL)
// REPUTATION: WEEK 6 NAVIGATION + WEEK 7 FORM VALIDATION + WEEK 14 STORAGE
// ============================================================================

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _existingSavedName;
  bool _isLoading = true;

  static const String _userNameKey = 'user_name';

  @override
  void initState() {
    super.initState();
    _checkExistingUser();
  }

  Future<void> _checkExistingUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedName = prefs.getString(_userNameKey);
      if (savedName != null && savedName.trim().isNotEmpty) {
        if (!mounted) return;
        setState(() {
          _existingSavedName = savedName.trim();
          _nameController.text = savedName.trim();
        });
      }
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final enteredName = _nameController.text.trim();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userNameKey, enteredName);
    } catch (_) {}

    if (!mounted) return;

    // Week 6 Navigation: Use pushReplacement to route to the Dashboard Screen
    // so pressing back does not return to the Welcome Shell.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen(initialUserName: enteredName)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Alta Dark Design Token
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: _isLoading
                ? const CircularProgressIndicator(color: themeColor)
                : Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Icon Pill Badge
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: themeColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: themeColor, width: 2),
                          ),
                          child: const Icon(itemIcon, size: 64, color: Colors.white),
                        ),
                        const SizedBox(height: 20),

                        // App Title
                        const Text(
                          appTitle,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Alta Global School · Mobile App Development',
                          style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.7)),
                        ),
                        const SizedBox(height: 32),

                        // Shell Login Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Welcome to Your Team App',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Strategy 2 Shell: Enter your name to store in phone disk and unlock the $itemNoun dashboard.',
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              const SizedBox(height: 20),

                              // Week 7: TextFormField with Validation
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Student / User Name',
                                  hintText: 'e.g., Meldi, Alex, Sarah',
                                  prefixIcon: const Icon(Icons.person, color: themeColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFFAFAF7),
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Please enter your name to proceed.';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) => _handleLogin(),
                              ),
                              const SizedBox(height: 20),

                              // Primary Submit Button
                              ElevatedButton(
                                onPressed: _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                ),
                                child: Text(
                                  _existingSavedName != null
                                      ? 'Continue as $_existingSavedName'
                                      : 'Enter $appTitle Dashboard',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Metaphor / Strategy Note
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Strategy 2: Lightweight Welcome Shell → Core Engine Router',
                            style: TextStyle(fontSize: 11, color: Colors.white70),
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
}

// ============================================================================
// TIER 2: DASHBOARD SCREEN (THE CORE ENGINE)
// INTEGRATES: INTL DATE/CURRENCY + DATEPICKER + CHIPS + BADGE + CRUD
// ============================================================================

class DashboardScreen extends StatefulWidget {
  final String? initialUserName;
  const DashboardScreen({super.key, this.initialUserName});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String _userName;
  List<TeamItem> _items = [];
  String _selectedFilter = 'All';

  // Input state
  final TextEditingController _itemInputController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = itemCategories.first;

  static const String _userNameKey = 'user_name';
  static const String _itemsKey = 'team_items_v2';

  @override
  void initState() {
    super.initState();
    _userName = widget.initialUserName ?? 'Student';
    _loadAllSavedData();
  }

  Future<void> _loadAllSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String savedName = prefs.getString(_userNameKey) ?? widget.initialUserName ?? 'Student';
      final List<String>? savedJsonList = prefs.getStringList(_itemsKey) ?? prefs.getStringList('team_items_list');

      if (!mounted) return;
      setState(() {
        _userName = savedName;
        if (savedJsonList != null && savedJsonList.isNotEmpty) {
          _items = savedJsonList.map((str) => TeamItem.fromRawString(str)).toList();
        } else {
          _items = defaultStarterItems.map((item) => item.clone()).toList();
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _userName = widget.initialUserName ?? _userName;
        _items = defaultStarterItems.map((item) => item.clone()).toList();
      });
    }
  }

  Future<void> _persistItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedList = _items.map((item) => jsonEncode(item.toJson())).toList();
      await prefs.setStringList(_itemsKey, encodedList);
    } catch (_) {}
  }

  // Week 16: Material 3 showDatePicker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: themeColor,
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // CRUD: CREATE
  void _addItem() {
    final text = _itemInputController.text.trim();
    if (text.isEmpty) return;

    final newItem = TeamItem(
      title: text,
      date: _selectedDate,
      category: _selectedCategory,
    );

    setState(() {
      _items.insert(0, newItem);
      _itemInputController.clear();
      _selectedDate = DateTime.now();
    });

    _persistItems();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added $itemNoun: "$text" for ${DateFormat('d MMM').format(newItem.date)}'),
          backgroundColor: themeColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // CRUD: TOGGLE COMPLETE
  void _toggleItemStatus(int index) {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
    _persistItems();
  }

  // CRUD: DELETE
  void _deleteItem(int index) {
    final removed = _items[index];
    setState(() {
      _items.removeAt(index);
    });
    _persistItems();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted $itemNoun: "${removed.title}"'),
          backgroundColor: const Color(0xFFEF4444),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Route back to Welcome Screen (Switch User)
  void _handleLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  // Filtered Items Getter
  List<TeamItem> get _filteredItems {
    if (_selectedFilter == 'All') return _items;
    if (_selectedFilter == 'Active') return _items.where((i) => !i.isCompleted).toList();
    if (_selectedFilter == 'Completed') return _items.where((i) => i.isCompleted).toList();
    return _items.where((i) => i.category == _selectedFilter).toList();
  }

  // Week 16: intl Currency Formatter Helper (for expense / shop apps)
  static String formatIDR(num amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  void dispose() {
    _itemInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = _items.where((i) => !i.isCompleted).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: const Text(appTitle),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          // Week 16: Material 3 Badge widget displaying active item count
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: Badge.count(
                count: activeCount,
                backgroundColor: const Color(0xFFFFD166), // Yellow Accent
                textColor: const Color(0xFF1E293B),
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  tooltip: '$activeCount active $itemNoun(s)',
                  onPressed: () {},
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Switch User (Shell)',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // -------------------------------------------------------------
              // 1. GREETING CARD (WEEK 14 STORAGE + STRATEGY 2 STATE)
              // -------------------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: themeColor.withValues(alpha: 0.3), width: 1.5),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: themeColor.withValues(alpha: 0.15),
                      foregroundColor: themeColor,
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logged In: $_userName',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'Today: ${DateFormat('EEEE, d MMM yyyy').format(DateTime.now())}',
                            style: const TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.swap_horiz, size: 16),
                      label: const Text('Switch', style: TextStyle(fontSize: 12)),
                      style: TextButton.styleFrom(foregroundColor: themeColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // -------------------------------------------------------------
              // WEEK 16 INTL CURRENCY & SUMMARY STRIP
              // -------------------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.insights, size: 16, color: Color(0xFF0A5A61)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Total Estimated Value: ${formatIDR(_items.length * 25000)} ($activeCount pending)',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0A5A61)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // -------------------------------------------------------------
              // 2. INPUT CARD: CREATE + INTL DATEPICKER + CHOICE CHIPS
              // -------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _itemInputController,
                            decoration: InputDecoration(
                              hintText: inputHintText,
                              prefixIcon: const Icon(itemIcon, color: themeColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            ),
                            onSubmitted: (_) => _addItem(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add $itemNoun'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Controls Row: Date Picker Button + Category Chips
                    Row(
                      children: [
                        // Week 16: showDatePicker Trigger Button with intl formatted date
                        OutlinedButton.icon(
                          onPressed: _pickDate,
                          icon: const Icon(Icons.calendar_month, size: 16),
                          label: Text(
                            DateFormat('d MMM yyyy').format(_selectedDate),
                            style: const TextStyle(fontSize: 12),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: themeColor,
                            side: BorderSide(color: themeColor.withValues(alpha: 0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Week 16: Category ChoiceChips
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: itemCategories.map((cat) {
                                final isSelected = _selectedCategory == cat;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ChoiceChip(
                                    label: Text(cat, style: const TextStyle(fontSize: 11)),
                                    selected: isSelected,
                                    selectedColor: themeColor.withValues(alpha: 0.2),
                                    onSelected: (val) {
                                      if (val) setState(() => _selectedCategory = cat);
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // -------------------------------------------------------------
              // 3. FILTER STRIP (MATERIAL 3 FILTER CHIPS)
              // -------------------------------------------------------------
              Row(
                children: [
                  Text(
                    'Active ${itemNoun}s (${_items.length})',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 6,
                    children: ['All', 'Active', 'Completed'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return FilterChip(
                        label: Text(filter, style: const TextStyle(fontSize: 11)),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedFilter = filter),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // -------------------------------------------------------------
              // 4. DYNAMIC LISTVIEW (READ, UPDATE/TOGGLE, DELETE)
              // -------------------------------------------------------------
              Expanded(
                child: _filteredItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(itemIcon, size: 52, color: Colors.black26),
                            const SizedBox(height: 10),
                            Text(
                              'No ${itemNoun.toLowerCase()}s match the filter.',
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Type above and tap "Add $itemNoun"',
                              style: TextStyle(fontSize: 11, color: Colors.black38),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          final masterIndex = _items.indexOf(item);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: item.isCompleted,
                                activeColor: themeColor,
                                onChanged: (_) => _toggleItemStatus(masterIndex),
                              ),
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: item.isCompleted
                                      ? Colors.black38
                                      : const Color(0xFF1E293B),
                                  decoration: item.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  // Formatted Date
                                  const Icon(Icons.calendar_today, size: 11, color: Color(0xFF757575)),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('d MMM yyyy').format(item.date),
                                    style: const TextStyle(fontSize: 11, color: Color(0xFF757575)),
                                  ),
                                  const SizedBox(width: 8),

                                  // Category Pill
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: themeColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item.category,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: themeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                                tooltip: 'Delete this item',
                                onPressed: () => _deleteItem(masterIndex),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
