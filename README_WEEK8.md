# AGS Flutter Week 8: State Management & Widget Lifecycle

Welcome to the **Week 8 IT Mobile App Development Bootcamp (Alta Global School)**!

In this module, you will integrate all components learned in Week 6 (Navigation & Routing) and Week 7 (Forms & Validation) into a unified, reactive application using **Lifting State Up** and the **Widget Lifecycle**.

---

## 1. What is New in Week 8 (vs Week 7)

In Week 7, you built secure input forms and validated user text entries. However, each screen remained isolated. Here is what is new in Week 8:

* **Widget Lifecycle (`initState` & `dispose`)**: Understand when a widget is created in memory (`initState`), when it rebuilds (`build`), and when it cleans up resources (`dispose`).
* **Lifting State Up**: Elevate the shared shopping cart state (`cartItems`) to the common parent widget (`HomeScreen`), establishing a *Single Source of Truth*.
* **Passing Data Down**: Forward cart data to child widgets via constructor parameters: `MenuScreen(cartSaatIni: cartItems)`.
* **Returning Data Up**: Return the updated cart from child back to parent using `Navigator.pop(context, _localCart)`.
* **Live Dynamic Rebuilds**: Call `setState()` inside `HomeScreen` upon receiving returned data from `Navigator.push`, updating badge counts and total prices instantly.

---

## 2. KantinKu Week 8 Data Flow

Here is the bidirectional data flow between HomeScreen, MenuScreen, and CartScreen:

```text
+-------------------------------------------------------------------+
|                     HomeScreen (STATE OWNER)                      |
|           cartItems = [{name: 'Special Fried Rice', price: 15000}]|
+-------------------------------------------------------------------+
       |                                              |
       | 1. Constructor:                              | 3. Constructor:
       |    MenuScreen(cartSaatIni: cartItems)        |    CartScreen(cartItems: cartItems)
       v                                              v
+-----------------------------+               +---------------------+
|         MenuScreen          |               |     CartScreen      |
|                             |               |                     |
| User taps "Add Item"        |               | Reads shared state  |
| Local cart state updates    |               | Calculates total Rp |
|                             |               | Displays checkout   |
+-----------------------------+               +---------------------+
       |
       | 2. Navigator.pop(context, _localCart)
       v
+-------------------------------------------------------------------+
|                    HomeScreen (Awaits Result)                     |
|           setState(() { cartItems = updatedCart; });              |
|           ==> UI and Cart Badge Rebuild Live in Real Time!        |
+-------------------------------------------------------------------+
```

---

## 3. Setup Guide (Choose 1 of 3 Tracks)

### Track 1: Browser / DartPad (Fastest, Zero Installation)
1. Open your browser and navigate to [DartPad Flutter](https://dartpad.dev/flutter).
2. Open the file `dartpad_starter_week8.dart` from this package.
3. Copy all code, paste it into DartPad, and click **Run**.
4. KantinKu Week 8 will run immediately in your browser.

### Track 2: VS Code (Recommended for Laptops)
1. Open your Flutter project folder in Visual Studio Code.
2. Copy the `lib/screens/` folder (`home_screen.dart`, `menu_screen.dart`, `cart_screen.dart`) into your project's `lib/` directory.
3. In `lib/main.dart`, set your home widget to `HomeScreen`:
   ```dart
   import 'package:flutter/material.dart';
   import 'screens/home_screen.dart';

   void main() {
     runApp(const MaterialApp(
       home: HomeScreen(),
       debugShowCheckedModeBanner: false,
     ));
   }
   ```
4. Run `flutter run` or press **F5**.

### Track 3: Android Studio
1. Open your Flutter project in Android Studio.
2. Place `home_screen.dart`, `menu_screen.dart`, and `cart_screen.dart` into `lib/screens/`.
3. Launch your Android emulator or connect a physical device via USB Debugging.
4. Click the green **Run** button (Shift + F10).

---

## 4. `[CHANGE HERE]` Customization Checklist

Give your team's application its own unique identity by customizing every `[CHANGE HERE]` tag:

- [ ] **App Name & Canteen Concept**: Update the AppBar title in `home_screen.dart` and `dartpad_starter_week8.dart` (e.g. *HealthyBites*, *BentoStation*, *CampusCanteen*).
- [ ] **Brand Color Theme**: Customize `brandTeal = Color(0xFF0E7C86)` to your team's custom color palette.
- [ ] **Food Menu Catalog**: Edit the `kantinMenu` list in `menu_screen.dart` (provide at least 4 items with distinct names, prices, emojis, and descriptions).
- [ ] **Lifecycle Console Logs**: Personalize the welcome log in `initState()` and cleanup log in `dispose()`.
- [ ] **Checkout Confirmation Message**: Customize the SnackBar message displayed when 'Pay Now' is tapped in `cart_screen.dart`.

---

## 5. Note for Grade 10-B (Merged W6 + W7 + W8 Submission)

For students in **Grade 10-B**, due to previous public holiday scheduling, your Sprint 2 submission integrates:
1. **Multi-Screen Navigation** (switching screens with `Navigator.push` and `pop`).
2. **Form Input & Validation** (registration form with validator callbacks).
3. **State Management & Lifecycle** (cart state held in parent and updating live).

You only need to submit **1 final project ZIP file** and **1 screenshot showing your cart count updating live** to Google Classroom.

---

## 6. Troubleshooting & Common Errors

| Issue / Error | Root Cause | Solution |
|---|---|---|
| Cart count does not increase after returning from Menu | Forgot to invoke `setState()` when receiving the return value from `Navigator.push` | Make sure to call `setState(() { cartItems = updatedCart; });` inside `_openMenu()`. |
| App freezes in an infinite rebuild loop | Invoking `setState()` directly inside the `build()` method | **Never** call `setState()` inside `build()`. Move it inside user event callbacks like `onPressed`. |
| Cart resets to empty every time you return to Home | Re-initializing `cartItems = []` inside the `build()` method | Declare `cartItems` as a property of `_HomeScreenState`, not as a local variable inside `build()`. |
| Error: `Null check operator used on a null value` | User tapped the Android back button, returning a `null` pop value | Add an `if (updatedCart != null)` guard before assigning to `cartItems`. |
| Controllers are not cleared when screen closes | Failed to override the `dispose()` method | Add `@override void dispose() { controller.dispose(); super.dispose(); }` to clean up resources. |

---

Happy building and have fun mastering Sprint 2 Week 8!
