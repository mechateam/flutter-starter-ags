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

## Step 4: Your Homework (Very Easy!)

Goal: Prove that your app can save 1 piece of information and remember it!

### What to Submit on Google Classroom:
1. **Screenshot 1:** You typed your name in the app and tapped "Save" (Snackbar message visible).
2. **Screenshot 2:** You completely closed the app or refreshed the page, and the app automatically displays your saved name!
3. **GitHub Commit Link:** Link to your commit on your team repository.

### Easy Rubric (100 Points):
* Added `shared_preferences` to `pubspec.yaml`: 25 pts
* Data saved successfully: 25 pts
* Data persists after app reload (Screenshot proof): 25 pts
* GitHub commit link provided: 25 pts

---

## Common Mistakes & Easy Fixes

* **Problem: `pubspec.yaml` throws YAML syntax error!**
  * *Fix:* Check your indentation. YAML is strict: exactly 2 spaces, no tabs!
* **Problem: Name shows "Loading..." and never updates.**
  * *Fix:* Did you call `_loadSavedName()` inside `initState()`? Make sure `setState()` is called after `await`.
* **Problem: Git says "Merge conflict"!**
  * *Fix:* Work on different files. One team member handles `storage_helper.dart`, another updates `home_screen.dart`.
