import 'package:flutter/material.dart';

/// Alta Global School: IT SHS (Grades 10 & 11)
/// Sprint 3: Simple In-Memory CRUD Helper Screen
/// Teacher: Meldi
///
/// This is the ultra-simple in-memory version.
/// If you want the full template with Week 14 Local Storage included,
/// use team_crud_template.dart!
///
/// CUSTOMIZE THESE 4 VARIABLES FOR YOUR TEAM APP:
const String appTitle = 'Team App CRUD';
const String itemNoun = 'Item';
const String inputHint = 'Type something here...';
const IconData listIcon = Icons.check_circle_outline;

class SimpleCrudListScreen extends StatefulWidget {
  final String title;

  const SimpleCrudListScreen({
    super.key,
    this.title = appTitle,
  });

  @override
  State<SimpleCrudListScreen> createState() => _SimpleCrudListScreenState();
}

class _SimpleCrudListScreenState extends State<SimpleCrudListScreen> {
  // 1. In-memory data list (starts with 2 friendly sample items)
  final List<String> _items = [
    'Sample $itemNoun 1',
    'Sample $itemNoun 2',
  ];

  // 2. Controller to read text from the user input field
  final TextEditingController _textController = TextEditingController();

  // 3. CREATE: Function to add a new item
  void _addItem() {
    final String enteredText = _textController.text.trim();

    // Only add if user typed something
    if (enteredText.isNotEmpty) {
      setState(() {
        _items.add(enteredText);
      });

      // Clear the text box so it is ready for the next entry
      _textController.clear();

      // Show a quick confirmation message at the bottom
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added $itemNoun: $enteredText'),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF0E7C86),
        ),
      );
    }
  }

  // 4. DELETE: Function to remove an item by its row number (index)
  void _deleteItem(int index) {
    final String removedItem = _items[index];

    setState(() {
      _items.removeAt(index);
    });

    // Show a quick confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted $itemNoun: $removedItem'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF0E7C86),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row with Input Box and Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: inputHint,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: Text('Add $itemNoun'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E7C86),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Section Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Current ${itemNoun}s (${_items.length}):',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Scrollable List of Items
            Expanded(
              child: _items.isEmpty
                  ? Center(
                      child: Text(
                        'No ${itemNoun.toLowerCase()}s in your list yet.\nType above and tap Add!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFFE8F4FD),
                              foregroundColor: const Color(0xFF0E7C86),
                              child: Icon(listIcon, size: 20),
                            ),
                            title: Text(
                              _items[index],
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFEF4444)),
                              tooltip: 'Delete item',
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
    );
  }
}
