import 'package:flutter/material.dart';

// ============================================================================
// ALTA GLOBAL SCHOOL | IT SHS (Grades 10 & 11)
// Sprint 3: Local Storage & Data Persistence (DartPad Edition)
//
// Classroom Reference: KantinKu Demo App
//
// MENTAL MODEL 1: Whiteboard (In-Memory State) vs Desk Notebook (Local Storage)
// MENTAL MODEL 2: Game Save Slot (Saving state before turning off the console)
//
// In this single-file DartPad template, we include:
// 1. A simulated Local Storage engine so you can test persistence in your browser.
// 2. A 'Simulate App Restart' button to prove your data persists after restart.
// 3. The exact code pattern you will use in your VS Code / Android Studio project.
// ============================================================================

void main() {
  runApp(const KantinKuApp());
}

// ----------------------------------------------------------------------------
// Local Storage Helper (Simulated for DartPad browser environment)
// In your full Flutter project with VS Code, replace this with shared_preferences!
// ----------------------------------------------------------------------------
class SimulatedStorageHelper {
  // Simulated phone disk storage
  static final Map<String, dynamic> _simulatedPhoneDisk = {
    'user_name': 'Guest Student',
    'dark_mode': false,
    'favorite_item': 'Nasi Goreng Spesial',
  };

  // Save a string to disk
  static Future<void> setString(String key, String value) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate disk I/O
    _simulatedPhoneDisk[key] = value;
  }

  // Read a string from disk
  static Future<String> getString(String key, {String defaultValue = ''}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _simulatedPhoneDisk[key] as String? ?? defaultValue;
  }

  // Clear disk
  static Future<void> clear() async {
    _simulatedPhoneDisk.clear();
  }
}

// ----------------------------------------------------------------------------
// Main Application Widget
// ----------------------------------------------------------------------------
class KantinKuApp extends StatefulWidget {
  const KantinKuApp({super.key});

  @override
  State<KantinKuApp> createState() => _KantinKuAppState();
}

class _KantinKuAppState extends State<KantinKuApp> {
  // Key used to completely unmount and remount the child widget on restart
  Key _appSessionKey = UniqueKey();

  void _restartApp() {
    setState(() {
      _appSessionKey = UniqueKey(); // Erases RAM variables, forces reload from storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KantinKu Local Storage Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7C86),
          primary: const Color(0xFF0E7C86),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(
        key: _appSessionKey,
        onSimulateRestart: _restartApp,
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Home Screen with Local Storage Hydration
// ----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  final VoidCallback onSimulateRestart;

  const HomeScreen({
    super.key,
    required this.onSimulateRestart,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // RAM Variables (Whiteboard: erased when app closes)
  String _displayName = 'Loading...';
  String _favoriteItem = 'None';
  bool _isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _favController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Step 3: Load data on launch (State Hydration)
    _loadDataFromStorage();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _favController.dispose();
    super.dispose();
  }

  // Read saved data from local storage into RAM state
  Future<void> _loadDataFromStorage() async {
    final savedName = await SimulatedStorageHelper.getString('user_name', defaultValue: 'Guest Student');
    final savedFav = await SimulatedStorageHelper.getString('favorite_item', defaultValue: 'None');

    if (mounted) {
      setState(() {
        _displayName = savedName;
        _favoriteItem = savedFav;
        _isLoading = false;
      });
    }
  }

  // Step 2: Save data asynchronously
  Future<void> _saveProfile() async {
    final newName = _nameController.text.trim();
    final newFav = _favController.text.trim();

    if (newName.isEmpty) return;

    // Write to local storage
    await SimulatedStorageHelper.setString('user_name', newName);
    if (newFav.isNotEmpty) {
      await SimulatedStorageHelper.setString('favorite_item', newFav);
    }

    // Refresh state
    await _loadDataFromStorage();

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success: Saved to local storage notebook!'),
          backgroundColor: Color(0xFF0E7C86),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showEditProfileDialog() {
    _nameController.text = _displayName;
    _favController.text = _favoriteItem;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile & Preferences'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter student name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _favController,
              decoration: const InputDecoration(
                labelText: 'Favorite Team Item',
                hintText: 'e.g. Task name, favorite meal',
                prefixIcon: Icon(Icons.bookmark),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveProfile,
            child: const Text('Save to Storage'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        title: Text('Welcome, $_displayName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: _showEditProfileDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Status Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SAVED STORAGE CHECKPOINT',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Color(0xFF0E7C86),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Active User: $_displayName',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Favorite Saved Item: $_favoriteItem',
                          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _showEditProfileDialog,
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Change and Save New Name'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0E7C86),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Simulation Card: Test App Restart
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TEST LOCAL STORAGE PERSISTENCE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2DD4BF),
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap below to simulate completely quitting and restarting the application. Notice that in-memory RAM resets, but your saved data persists because it was saved to disk!',
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: widget.onSimulateRestart,
                          icon: const Icon(Icons.restart_alt, color: Colors.white),
                          label: const Text(
                            'Simulate App Restart (Clear RAM & Reload)',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2DD4BF)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Homework Instructions Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WEEK 14 HOMEWORK CHECKLIST',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0E7C86),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1. Add shared_preferences: ^2.2.2 to pubspec.yaml\n'
                          '2. Copy lib/services/storage_helper.dart to your team project\n'
                          '3. Save 1 item (user name, score, or preference)\n'
                          '4. Take 2 screenshots: (a) saved state confirmation, (b) persisted state on relaunch\n'
                          '5. Submit screenshots + commit URL to Google Classroom',
                          style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
