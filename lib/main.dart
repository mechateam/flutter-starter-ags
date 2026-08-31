import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// ============================================================================
// 🚀 KANTINKU - MAIN.DART (Week 7: Form & Validation Update)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// STRUKTUR APLIKASI KANTINKU:
// 1. LoginScreen (screens/login_screen.dart) -> Gerbang masuk aplikasi
// 2. SignUpScreen (screens/signup_screen.dart) -> Formulir registrasi & validasi (Week 7)
// 3. MenuScreen (screens/menu_screen.dart) -> Menampilkan daftar menu kantin
// 4. CartScreen (screens/cart_screen.dart) -> Rincian pesanan & checkout
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
        useMaterial3: true,
      ),
      // LoginScreen adalah pintu masuk pertama aplikasi
      home: const LoginScreen(),
    );
  }
}
