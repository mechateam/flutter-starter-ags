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

## 2. How to Understand This (Grade 10 Step-by-Step Guide)

If terms like "state management" and "widget lifecycle" sound complicated, do not worry. The core concepts are simple once connected to everyday things you already use.

### Step 1: What is "State"? (Just a Variable with a Fancy Name)
* **State is simply data that changes while your app is running.**
* In Instagram: your like count or follower count is a state.
* In a mobile game: your player health or coin score is a state.
* In **KantinKu**: your `cartItems` list (the food items you picked) is the state.
When you launch the app, `cartItems` starts empty (`[]`). When you pick a snack, the state changes to contain that snack. That is all state is!

### Step 2: Why Do We Need "State Management"? (The Classroom Snack Dilemma)
Imagine 3 screens in your app:
1. `HomeScreen`: Shows your canteen title and a badge with the total items (e.g. "Cart: 0 items").
2. `MenuScreen`: Shows the food catalog where you tap "Add to Cart".
3. `CartScreen`: Shows the final order list and total price in Rupiah.

**The Problem:**
If `MenuScreen` keeps the cart hidden in its own private memory, `CartScreen` cannot see what you picked, and `HomeScreen` will forever show `0 items`. The screens cannot talk to each other directly.

**The Solution: "Lifting State Up"**
Instead of storing the cart inside `MenuScreen`, you **lift the cart up** to their common parent widget: `HomeScreen`.
* *Analogy*: Think of `HomeScreen` like a classroom teacher holding the master order clipboard. When `MenuScreen` or `CartScreen` opens, they look at the teacher's clipboard. Now every screen shares the exact same information.

### Step 3: How Does Data Travel? (The 3-Step Hand-off)
Here is the exact 3-step loop that makes KantinKu work:

1. **Step 1: Parent Hands Data Down (Constructor Injection)**
   When you tap "Open Menu" on `HomeScreen`, the parent opens `MenuScreen` and hands over the current clipboard:
   ```dart
   MenuScreen(cartSaatIni: cartItems)
   ```
   Now `MenuScreen` knows what is already in your cart.

2. **Step 2: Child Updates and Hands Data Back Up (Navigator.pop)**
   Inside `MenuScreen`, you tap "Add Fried Rice". When finished, you tap "Done Ordering". `MenuScreen` closes itself and returns the updated list back to the parent:
   ```dart
   Navigator.pop(context, _localCart);
   ```

3. **Step 3: Parent Catches It and Rebuilds the UI (setState)**
   `HomeScreen` catches the returned list and runs `setState()`:
   ```dart
   final updatedCart = await Navigator.push(...);
   if (updatedCart != null) {
     setState(() {
       cartItems = updatedCart; // Update parent data!
     });
   }
   ```
   **What does `setState()` do?**
   It tells Flutter: "Data has changed! Redraw the screen right now so the new badge number appears!"

### Step 4: What is the "Widget Lifecycle"? (Birth, Life, Death)
Every screen in Flutter has a lifecycle, just like an app on your phone:

* **1. Birth: `initState()`**
  * Runs **once** when the screen is first created.
  * Use it for: Setting up initial data or printing a console welcome greeting.
  * *Analogy*: Putting on your school uniform before class starts.

* **2. Life: `build()`**
  * Runs every time the screen is displayed or updated by `setState()`.
  * Use it for: Returning UI widgets (Text, Containers, Buttons).
  * **Important Rule**: Never call `setState()` inside `build()`. That causes an infinite loop where Flutter redraws forever and crashes.

* **3. Death: `dispose()`**
  * Runs when the screen is closed permanently.
  * Use it for: Cleaning up resources like `TextEditingController` so your device does not run out of memory.
  * *Analogy*: Turning off the lights when leaving a room.

### Summary: The 4 Golden Rules for Grade 10
1. **Rule 1**: Store shared data in the parent (`HomeScreen`).
2. **Rule 2**: Send data **down** using screen constructors (`ScreenName(cartItems: ...)`).
3. **Rule 3**: Send data **up** using `Navigator.pop(context, data)`.
4. **Rule 4**: Always wrap updates in `setState(() { ... })` so Flutter redraws the numbers on your screen.

---

## 3. KantinKu Week 8 Data Flow

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

## 4. Setup Guide (Choose 1 of 3 Tracks)

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

## 5. `[CHANGE HERE]` Customization Checklist

Give your team's application its own unique identity by customizing every `[CHANGE HERE]` tag:

- [ ] **App Name & Canteen Concept**: Update the AppBar title in `home_screen.dart` and `dartpad_starter_week8.dart` (e.g. *HealthyBites*, *BentoStation*, *CampusCanteen*).
- [ ] **Brand Color Theme**: Customize `brandTeal = Color(0xFF0E7C86)` to your team's custom color palette.
- [ ] **Food Menu Catalog**: Edit the `kantinMenu` list in `menu_screen.dart` (provide at least 4 items with distinct names, prices, emojis, and descriptions).
- [ ] **Lifecycle Console Logs**: Personalize the welcome log in `initState()` and cleanup log in `dispose()`.
- [ ] **Checkout Confirmation Message**: Customize the SnackBar message displayed when 'Pay Now' is tapped in `cart_screen.dart`.

---

## 6. Note for Grade 10-B (Merged W6 + W7 + W8 Submission)

For students in **Grade 10-B**, due to previous public holiday scheduling, your Sprint 2 submission integrates:
1. **Multi-Screen Navigation** (switching screens with `Navigator.push` and `pop`).
2. **Form Input & Validation** (registration form with validator callbacks).
3. **State Management & Lifecycle** (cart state held in parent and updating live).

You only need to submit **1 final project ZIP file** and **1 screenshot showing your cart count updating live** to Google Classroom.

---

## 7. Troubleshooting & Common Errors

| Issue / Error | Root Cause | Solution |
|---|---|---|
| Cart count does not increase after returning from Menu | Forgot to invoke `setState()` when receiving the return value from `Navigator.push` | Make sure to call `setState(() { cartItems = updatedCart; });` inside `_openMenu()`. |
| App freezes in an infinite rebuild loop | Invoking `setState()` directly inside the `build()` method | **Never** call `setState()` inside `build()`. Move it inside user event callbacks like `onPressed`. |
| Cart resets to empty every time you return to Home | Re-initializing `cartItems = []` inside the `build()` method | Declare `cartItems` as a property of `_HomeScreenState`, not as a local variable inside `build()`. |
| Error: `Null check operator used on a null value` | User tapped the Android back button, returning a `null` pop value | Add an `if (updatedCart != null)` guard before assigning to `cartItems`. |
| Controllers are not cleared when screen closes | Failed to override the `dispose()` method | Add `@override void dispose() { controller.dispose(); super.dispose(); }` to clean up resources. |

---

Happy building and have fun mastering Sprint 2 Week 8!
