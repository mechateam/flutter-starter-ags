# KantinKu - Grade 10-B Merged Sprint 2 Tutorial
**Alta Global School | IT Grade 10-B**  
*Weeks 6 & 7 Accelerated Lab: Multi-Screen Navigation & Form Validation*

---

## Welcome Grade 10-B

Because our Tuesday class last week fell on a public holiday, this tutorial guides you through **both Week 6 (Multi-Screen Navigation)** and **Week 7 (Form Validation)** from the ground up.

Everything you need is already built into this starter repository:
- **`lib/screens/login_screen.dart`**: App entry screen with quick login and navigation buttons.
- **`lib/screens/signup_screen.dart`**: Student registration form with input validation.
- **`lib/screens/menu_screen.dart`**: Food menu catalog displaying the registered student's name.
- **`lib/screens/cart_screen.dart`**: Order summary and checkout dialog.
- **`dartpad_starter_week7.dart`**: Single-file copy-paste runner for browser coding on [dartpad.dev](https://dartpad.dev).

---

## Part 1: Understanding Week 6 Multi-Screen Navigation

In Sprint 1, all your widgets lived on a single screen. In Sprint 2, your app has multiple screens connected by Flutter's **Navigator**.

### 1. The Navigation Stack (LIFO: Last In, First Out)
Flutter manages screens like a stack of plates:
- When you open a new screen, you **push** it onto the top of the stack.
- When you leave a screen, you **pop** it off the top of the stack to reveal the screen underneath.

### 2. Moving Forward with `Navigator.push`
To navigate from `LoginScreen` to `SignUpScreen`, use:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SignUpScreen(),
  ),
);
```

### 3. Returning Backward with `Navigator.pop`
To go back to the previous screen (e.g. from `SignUpScreen` back to `LoginScreen`):
```dart
Navigator.pop(context);
```
*(Note: Flutter automatically adds a back button in the AppBar that calls `Navigator.pop(context)` for you).*

### 4. Passing Data Between Screens
To send data (like the student's name) from `SignUpScreen` to `MenuScreen`, pass it through the constructor:
```dart
// In MenuScreen:
class MenuScreen extends StatelessWidget {
  final String userName;
  const MenuScreen({super.key, required this.userName});
  ...
}

// In SignUpScreen (when navigating):
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => MenuScreen(userName: userName),
  ),
);
```

---

## Part 2: Understanding Week 7 Form Validation

A mobile form without validation is risky: users might submit empty text, wrong formats, or short passwords. Flutter provides a 3-part validation system:

### 1. `Form` and `GlobalKey<FormState>`
Wrap all your input fields inside a `Form` widget and assign a `GlobalKey`:
```dart
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// In build():
Form(
  key: _formKey,
  child: Column(
    children: [
      // your TextFormFields here
    ],
  ),
)
```

### 2. Capturing Text with `TextEditingController`
A controller acts as a bridge between the phone keyboard and your Dart logic:
```dart
final TextEditingController _nameController = TextEditingController();

TextFormField(
  controller: _nameController,
  decoration: const InputDecoration(labelText: 'Full Name'),
)

// Read the text anytime:
String name = _nameController.text.trim();
```

### 3. Writing `validator` Rules
Every `TextFormField` has a `validator` callback function:
- Return a **String** (e.g. `'Full name is required'`) if there is a mistake. This displays red error text beneath the field.
- Return **null** if the input is valid.

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Full name is required';
  }
  if (value.trim().length < 3) {
    return 'Name must be at least 3 characters';
  }
  return null; // Input is valid!
}
```

### 4. Validating Everything on Button Press
When the student taps **Sign Up Now**, call `_formKey.currentState!.validate()`:
```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      // All fields passed! Proceed with navigation.
      final userName = _nameController.text.trim();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuScreen(userName: userName),
        ),
      );
    }
  },
  child: const Text('Sign Up Now'),
)
```

---

## Part 3: Choose Your Lab Track

| Track | Best For | How to Run |
|---|---|---|
| **Track 1: Google DartPad** | Chromebooks, laptops with 4GB RAM, or no Flutter installed. | 1. Open [dartpad.dev](https://dartpad.dev) in Google Chrome.<br>2. Clear all default code.<br>3. Copy the entire content of `dartpad_starter_week7.dart` and paste into DartPad.<br>4. Click the blue **Run** button. |
| **Track 2: VS Code (Recommended)** | Students with VS Code & Flutter installed. | 1. Open the project folder in VS Code.<br>2. Select device: **Chrome (web)** in the bottom right bar.<br>3. Press **F5** or click Run without Debugging. |
| **Track 3: Android Studio** | Students using Android Studio. | 1. Open the project folder in Android Studio.<br>2. Click **Pub get** in the top bar.<br>3. Select device: **Chrome (web)**.<br>4. Click the green **Play** button. |

---

## Part 4: Step-by-Step Customization Mission

Open **`lib/screens/signup_screen.dart`** and customize the code at the **`// [CHANGE HERE]`** markers:

1. **Brand Your App**:
   - Change `'Create KantinKu Account'` to your group's unique app name.
   - Adjust theme colors (e.g. `Color(0xFF0E7C86)`).
2. **Customize Input Fields**:
   - Change or add an input field (e.g., replace Class/ID with `'Table Number'` or `'WhatsApp Number'`).
   - Add custom validator checks.
3. **Test Validation Errors**:
   - Run the app, click **Create New Account (Sign Up)**, and immediately click **Sign Up Now** with empty boxes.
   - Verify that red warning borders and messages appear beneath every required field.
4. **Test Successful Registration**:
   - Fill out the form with valid information and submit.
   - Verify that the green SnackBar appears and the app moves to `MenuScreen` displaying `'Hello, [Your Name]!'`.

---

## Part 5: Common Troubleshooting

| Issue | Cause | Solution |
|---|---|---|
| **Red error messages do not appear on submit** | Missing `_formKey.currentState!.validate()` | Ensure the button handler checks `if (_formKey.currentState!.validate())` before navigating. |
| **Password is visible in plain text** | `obscureText` is set to `false` | Ensure `obscureText: _obscurePassword` is set on the password `TextFormField`. |
| **Error: A Key must be unique** | `GlobalKey` declared inside `build()` method | Move `final _formKey = GlobalKey<FormState>();` to the top of `_SignUpScreenState`. |
| **Password confirmation fails** | Incorrect comparison in validator | Ensure `if (value != _passwordController.text)` is checking the controller value. |

---

## Part 6: Google Classroom Submission Checklist

Since Grade 10-B is combining Weeks 6 & 7, you only submit **one single merged submission** to Google Classroom:

1. **Screenshot 1**: Sign Up screen showing red validation error highlights when submitted empty.
2. **Screenshot 2**: Menu screen showing your personalized user greeting after successful registration.
3. **Code Deliverable**: ZIP archive of your project or public DartPad share link.

*Good luck Grade 10-B! Ask questions in class if you get stuck.*
