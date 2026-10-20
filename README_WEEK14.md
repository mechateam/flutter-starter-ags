# Week 14: Sprint 3 - Local Storage (SharedPreferences) Guide

Welcome to Week 14 of our Mobile App Development Bootcamp!

This week we solve the **App Amnesia** problem. Right now, whenever you close your app or restart the phone emulator, all your variables reset to zero or empty. With **Local Storage**, your app writes data to the phone's memory so it remembers your users forever!

---

## The Big Idea: Whiteboard vs Notebook

* **RAM (Variables in State):** Like writing on a classroom whiteboard. As soon as someone turns off the classroom lights (closes the app), the board gets erased completely.
* **Local Storage (`SharedPreferences`):** Like writing in a physical notebook on your desk. Even if you turn off the computer and go to sleep, what you wrote in the notebook is still there tomorrow!

---

## Step 1: Add the Package (1 Line of Code)

Open your project's `pubspec.yaml` file. Under `dependencies:`, add `shared_preferences: ^2.2.2`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2  # <-- ADD THIS LINE (keep the 2-space indentation!)
```

Then in your terminal, run:
```bash
flutter pub get
```

---

## Step 2: Add the Helper File

Copy the file `lib/services/storage_helper.dart` into your team project. It contains 2 simple methods:

```dart
// 1. To save a name:
await StorageHelper.saveUserName('Alex');

// 2. To get the saved name:
String name = await StorageHelper.getUserName();
```

---

## Step 3: Use it in Your Screen (Example: `HomeScreen`)

In your screen's `State` class:

```dart
import 'package:flutter/material.dart';
import '../services/storage_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayName = 'Loading...';
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedName();
  }

  // Load the name from disk when screen opens
  Future<void> _loadSavedName() async {
    final name = await StorageHelper.getUserName();
    setState(() {
      _displayName = name;
    });
  }

  // Save the new name to disk
  Future<void> _saveName() async {
    if (_nameController.text.trim().isNotEmpty) {
      await StorageHelper.saveUserName(_nameController.text.trim());
      _loadSavedName();
      Navigator.pop(context); // Close dialog

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name saved to storage successfully!')),
      );
    }
  }

  void _showEditDialog() {
    _nameController.text = _displayName;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Your Name'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Type your name here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveName,
            child: const Text('Save to Disk'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $_displayName!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, $_displayName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _showEditDialog,
              icon: const Icon(Icons.person),
              label: const Text('Change My Name'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Step 4: In-Class Sprint 3 Lab (No Homework Due This Sunday!)

**Zero homework deadline this Sunday!** You all just submitted your Week 8 and Week 12 assignments on Sunday. Today is an in-class engineering workshop to get your team app ready for Sprint 3 without deadline pressure.

### Sprint 3 Roadmap (Weeks 14 to 17: From Storage to Beta App)

| Week | Focus | Milestone / Output |
| :--- | :--- | :--- |
| **Week 14 (Today)** | **Local Storage (`SharedPreferences`)** | **In-Class Workshop (Ungraded):** Add `storage_helper.dart` and persist 1 data item. |
| **Week 15** | **Core CRUD Features** | **Feature Build:** Add, view, edit, and delete items in your team app. |
| **Week 16** | **Flutter Packages (`pub.dev`)** | **Sprint 3 Checkpoint 1 (Graded, 50 pts):** Team commit showing persistent core features + 1 package. |
| **Week 17** | **Testing & Code Improvement** | **Sprint 3 Checkpoint 2 (Graded, 50 pts):** Version Beta Release + 1-page Team Bug Report. |

### In-Class Checklist for Today:
1. One team member adds `shared_preferences: ^2.2.2` in `pubspec.yaml` and runs `flutter pub get`.
2. Add `storage_helper.dart` to `lib/services/` in your team codebase.
3. Test saving 1 key-value pair (e.g. user name, counter, or toggle) on your emulator or web screen.
4. Commit and push your code to your team GitHub repository:
   ```bash
   git add .
   git commit -m "feat: setup local storage with shared_preferences"
   git push
   ```

---

## Common Mistakes & Easy Fixes

* **Problem: `pubspec.yaml` throws YAML syntax error!**
  * *Fix:* Check your indentation. YAML is strict: exactly 2 spaces, no tabs!
* **Problem: Name shows "Loading..." and never updates.**
  * *Fix:* Did you call `_loadSavedName()` inside `initState()`? Make sure `setState()` is called after `await`.
* **Problem: Git says "Merge conflict"!**
  * *Fix:* Work on different files. One team member handles `storage_helper.dart`, another updates `home_screen.dart`.
