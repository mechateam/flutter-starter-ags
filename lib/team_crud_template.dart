import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================================
// ALTA GLOBAL SCHOOL: IT SHS (GRADES 10 & 11)
// SPRINT 3: WEEK 14 & 15 COMBINED ASSIGNMENT TEMPLATE
// TEACHER: MELDI
// ============================================================================
//
// INSTRUCTIONS FOR STUDENTS:
// You only need to edit the CUSTOMIZATION ZONE below to match your team app!
// Everything else works out of the box.
//
// To install the storage package, open your terminal in VS Code and run:
// flutter pub add shared_preferences
// ============================================================================

// ============================================================================
// CUSTOMIZATION ZONE: CHANGE THESE 6 VARIABLES FOR YOUR TEAM APP!
// ============================================================================

/// 1. Your App Name (Appears in top AppBar)
/// Examples: 'Tasky', 'PocketWise', 'ResQ', 'HabitHero', 'BullsEye'
const String appTitle = 'Tasky';

/// 2. What noun does your app manage?
/// Examples: 'Task', 'Expense', 'Contact', 'Habit', 'Target'
const String itemNoun = 'Task';

/// 3. Hint text shown inside the input box
/// Examples: 'Enter new task...', 'Enter expense name...', 'Enter habit...'
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

/// 6. Default starter items for your team app
final List<String> defaultStarterItems = [
  'Review Flutter sprint slides',
  'Prepare team project demo',
];

// ============================================================================
// END OF CUSTOMIZATION ZONE. CODE BELOW POWERS YOUR SCREEN AUTOMATICALLY.
// ============================================================================

class TeamCrudScreen extends StatefulWidget {
  const TeamCrudScreen({super.key});

  @override
  State<TeamCrudScreen> createState() => _TeamCrudScreenState();
}

class _TeamCrudScreenState extends State<TeamCrudScreen> {
  // Week 14: Local Storage state for user profile name
  String _userName = 'Guest';

  // Week 15: Dynamic list of items
  List<String> _items = [];

  // Controllers for text inputs
  final TextEditingController _itemInputController = TextEditingController();
  final TextEditingController _nameInputController = TextEditingController();

  // Storage key names
  static const String _userNameKey = 'user_name';
  static const String _itemsKey = 'team_items_list';

  @override
  void initState() {
    super.initState();
    _loadAllSavedData();
  }

  /// Load both user name (Week 14) and items list (Week 15) from disk
  Future<void> _loadAllSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String savedName = prefs.getString(_userNameKey) ?? 'Guest';
      final List<String>? savedItems = prefs.getStringList(_itemsKey);

      setState(() {
        _userName = savedName;
        _items = (savedItems != null && savedItems.isNotEmpty)
            ? savedItems
            : List<String>.from(defaultStarterItems);
      });
    } catch (e) {
      // In-memory fallback if storage is initializing or unavailable
      setState(() {
        _items = List<String>.from(defaultStarterItems);
      });
    }
  }

  /// Week 14: Save user name to disk
  Future<void> _saveUserName(String newName) async {
    final cleanName = newName.trim();
    if (cleanName.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userNameKey, cleanName);
    } catch (_) {}

    setState(() {
      _userName = cleanName;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated: Welcome, $cleanName!'),
          backgroundColor: themeColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Week 15: CREATE (Add an item to list and save to disk)
  Future<void> _addItem() async {
    final String text = _itemInputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.add(text);
    });

    _itemInputController.clear();

    // Persist to disk (solving app amnesia)
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_itemsKey, _items);
    } catch (_) {}

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added $itemNoun: "$text"'),
          backgroundColor: themeColor,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// Week 15: DELETE (Remove an item by row index and update disk)
  Future<void> _deleteItem(int index) async {
    final String removedText = _items[index];

    setState(() {
      _items.removeAt(index);
    });

    // Update disk storage
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_itemsKey, _items);
    } catch (_) {}

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted $itemNoun: "$removedText"'),
          backgroundColor: const Color(0xFFEF4444),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// Week 14: Dialog popup to change user name
  void _showChangeNameDialog() {
    _nameInputController.text = _userName == 'Guest' ? '' : _userName;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Update Profile Name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This tests Week 14 Local Storage. Your app remembers this name even after you restart the phone emulator!',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameInputController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _saveUserName(_nameInputController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: themeColor, foregroundColor: Colors.white),
            child: const Text('Save to Storage'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _itemInputController.dispose();
    _nameInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: Text(appTitle),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Change Profile Name (Week 14)',
            onPressed: _showChangeNameDialog,
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
              // 1. WEEK 14 LOCAL STORAGE GREETING CARD
              // -------------------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: themeColor.withOpacity(0.3), width: 1.5),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: themeColor.withOpacity(0.15),
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
                          const Text(
                            'Saved in phone disk (Week 14 Local Storage)',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showChangeNameDialog,
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit', style: TextStyle(fontSize: 12)),
                      style: TextButton.styleFrom(foregroundColor: themeColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // -------------------------------------------------------------
              // 2. WEEK 15 CREATE (ADD ITEM) INPUT ROW
              // -------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _itemInputController,
                        decoration: InputDecoration(
                          hintText: inputHintText,
                          prefixIcon: Icon(itemIcon, color: themeColor),
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
                      label: Text('Add $itemNoun'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // -------------------------------------------------------------
              // 3. WEEK 15 READ & DELETE (DYNAMIC LISTVIEW)
              // -------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active ${itemNoun}s (${_items.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Tap trash can to delete',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Expanded(
                child: _items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(itemIcon, size: 56, color: Colors.black26),
                            const SizedBox(height: 12),
                            Text(
                              'No ${itemNoun.toLowerCase()}s in your list yet.',
                              style: const TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Type above and tap "Add $itemNoun"',
                              style: const TextStyle(fontSize: 12, color: Colors.black38),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: themeColor.withOpacity(0.12),
                                foregroundColor: themeColor,
                                child: Icon(itemIcon, size: 20),
                              ),
                              title: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              subtitle: Text(
                                '${itemNoun} #${index + 1}',
                                style: const TextStyle(fontSize: 11, color: Colors.black45),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                                tooltip: 'Delete this item',
                                onPressed: () => _deleteItem(index),
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

// Optional standalone runner so students can test this screen directly
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TeamCrudScreen(),
  ));
}
