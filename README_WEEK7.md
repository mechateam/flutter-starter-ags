# KantinKu - Flutter Lab Guide: Form & Validation (Week 7)
**Alta Global School | IT Grade 10 & 11 (SHS)**  
*Sprint 2: Multi-Screen Navigation, Form & State Management*

---

## Learning Objectives
Today, every team will implement a **Student Registration Screen (Sign Up Screen)** for their mobile app with **Form Validation**:
1. Use the `Form` widget and `GlobalKey<FormState>` to safeguard and validate user input.
2. Use `TextEditingController` to capture input for Full Name, Class / Student ID, and Password.
3. Attach `validator` callbacks to prevent empty submissions and enforce minimum character rules.
4. Connect the registration flow to `MenuScreen`, carrying the newly registered student's name forward.

---

## Grade 10-B Special Notice (Weeks 6 & 7 Merged)
Because Grade 10-B had a public holiday last week, this week's sprint combines:
- **Week 6:** Multi-Screen Navigation (`Navigator.push`, `Navigator.pop`).
- **Week 7:** Form Registration & Validation (`Form`, `TextEditingController`, `validator`).

All routes are fully connected in this template: `LoginScreen` -> `SignUpScreen` -> `MenuScreen` -> `CartScreen`.

---

## Choose Your Lab Track

| Track | When to Choose | Quick Instructions |
|---|---|---|
| **Track 1: Google DartPad (Browser)** | Low-spec laptop (4GB RAM) or no Flutter/IDE installed. | Open **[dartpad.dev](https://dartpad.dev)**, delete all default code, copy all code from `dartpad_starter_week7.dart`, and click **Run**. |
| **Track 2: VS Code + Chrome Web** | Recommended for fast, lightweight coding. | Open the project folder in VS Code, select target device **`Chrome (web)`**, press **`F5`**. |
| **Track 3: Android Studio** | For students using Android Studio since Week 1. | Open the project folder in Android Studio, click **`Pub get`**, select target device **`Chrome (web)`**, click the green **Run `Play`** button. |

---

## Team Customization Guide

Open **`lib/screens/signup_screen.dart`** and find the **`[CHANGE HERE]`** comments:

### 1. Customize App Titles & Theme Colors
- Update the form header `'New Student Registration'` to match your group's product concept.
- Adjust the AppBar and button theme colors (`Color(0xFF0E7C86)`).

### 2. Customize Input Fields (TextFormField)
The starter template provides 4 pre-configured fields:
- **Full Name:** Validator checks for non-empty and minimum 3 letters.
- **Class / Student ID:** Can be customized to `'WhatsApp Number'` or `'Table Number'`.
- **Password:** Validator checks for minimum 6 characters.
- **Confirm Password:** Validator verifies exact match with the password field.

### 3. Test Form Validation (Bug Testing)
1. Run the app in your browser or emulator.
2. Click the **Create New Account (Sign Up)** button.
3. Immediately click **Sign Up Now** without filling in any fields.
4. **Expected Result:** Clear red highlight borders and descriptive error messages will appear beneath all empty required fields!

---

## Troubleshooting Guide

| Issue | Cause | Solution |
|---|---|---|
| **Red error messages do not appear on submit** | Missing `_formKey.currentState!.validate()` call | Ensure your submit button calls `if (_formKey.currentState!.validate())` before navigating. |
| **Password is visible in plain text** | `obscureText` is set to `false` | Ensure `obscureText: _obscurePassword` is present on the password `TextFormField`. |
| **Error: A Key must be unique** | `GlobalKey` declared inside the `build()` method | Move `final _formKey = GlobalKey<FormState>();` to the top of `_SignUpScreenState`. |

---

## Submission Checklist (Google Classroom)

Submit the following to **Google Classroom: Sprint 2 UI & Form Submission**:
1. **Screenshot 1:** Sign Up screen displaying inline validation error messages (when submitted empty).
2. **Screenshot 2:** Menu screen displaying your personalized user greeting after successful sign up.
3. **Source Code:** Zip archive of your project or shareable public DartPad link.

*Happy building and have fun crafting your mobile app!*
