import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// ============================================================================
// 🚀 KANTINKU - MAIN.DART (Week 6: Navigation Update)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// PERUBAHAN WEEK 6:
// - home sekarang adalah LoginScreen (bukan HomeScreen)
// - Dari LoginScreen, user bisa navigate ke MenuScreen
// - Dari MenuScreen, user bisa navigate ke CartScreen
// ============================================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Week 6: LoginScreen adalah pintu masuk pertama aplikasi
      home: const LoginScreen(),
    );
  }
}

