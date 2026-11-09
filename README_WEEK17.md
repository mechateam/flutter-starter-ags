# Week 17: Sprint 3 - Packages & Beta Polish (Combined Week 16 & 17 Guide)

Welcome to Sprint 3 of our Mobile App Development Bootcamp at Alta Global School!  
* Teacher: Meldi  
* Target Classes: Grades 10 & 11 (IT-10B, IT-10E, IT-10C, IT-11A, IT-10F)  
* Delivery Mode: 100% Online via Google Meet  
* Assignment: `[Sprint 3] Week 16 & 17 Combined: Packages & Beta Polish` (100 Points)  

---

## 1. The Big Picture: You Are 70% of the Way to Demo Day!

Look at how far your team has come since Week 1:

```
Sprint 0 (Weeks 1-2): Problem Discovery & Team Setup (Completed)
Sprint 1 (Weeks 3-5): Planning, Wireframing & Home UI (Completed)
Sprint 2 (Weeks 6-9): Navigation, Forms & Lists (Completed)
Sprint 3 (Weeks 14-17): The Working App Core Engine
  * Weeks 14-15: Local Storage + Dynamic CRUD (Completed)
  * Weeks 16-17 Combined: Packages + Beta Polish (You are here!)
Sprint 4 (Weeks 18-19): The Polished App
  * Week 18: Responsive Layout (Phones & Tablets)
  * Week 19: Final Polish & Release Candidate
Week 21: DEMO DAY! (Final Showcase to Teachers & Friends!)
```

Weeks 16 and 17 are combined into one focused mission: turn your working CRUD prototype into a clean, crash-free Version Beta (`v0.3.0-beta`). Every week builds directly on your existing project: you are not starting over, you are simply adding one layer of polish each week until your app is ready for the Demo Day stage!

---

## 2. What Your Team Needs to Do (The 4-Step Action Plan)

Here is your exact roadmap for this assignment:
1. **Step 1: Install 2 Packages (30 Seconds):** Run one command in your VS Code terminal.
2. **Step 2: Open `lib/team_crud_template.dart`:** The complete working two-tier template is already prepared for you.
3. **Step 3: Edit the Customization Zone (60 Seconds):** Change 6 variables at the top of the file to brand the app for your team.
4. **Step 4: Run Defensive Checks & Tag Git (60 Seconds):** Test the keyboard scroll and empty input guard, commit, and push tag `v0.3.0-beta`.

---

## 3. The Strategy: Two-Tier Architecture in One File (Strategy 2)

To keep your code simple and prevent broken imports across multiple files, `lib/team_crud_template.dart` combines two connected screens in one single file:

1. **Tier 1 (The Shell): `WelcomeScreen`**
   * Acts as your welcome and login gate.
   * Users type their name and tap "Enter App".
   * Saves the user name to `SharedPreferences` so your app remembers who logged in even after restarting the emulator.
   * Smoothly navigates to the Dashboard using `Navigator.pushReplacement`.

2. **Tier 2 (The Core Engine): `DashboardScreen`**
   * Displays a personalized welcome banner with the saved user name.
   * Lets users add items with dates (`intl` date formatting + `showDatePicker`).
   * Categorizes items with Material 3 chips (`ChoiceChip`).
   * Displays the dynamic item counter badge and list with instant delete buttons.

You do not need to create new files or debug multi-file imports. Everything runs seamlessly out of the box!

---

## 4. Step-by-Step: How to Customize Your Team App in 60 Seconds

### Step 1: Install Required Packages
In your VS Code terminal, run:
```bash
flutter pub add shared_preferences intl
```
This adds local storage persistence (`shared_preferences`) and date formatting (`intl`) to your project.

### Step 2: Open `lib/team_crud_template.dart`
Locate `lib/team_crud_template.dart` in your project's `lib/` folder. If you want this screen to run when you press play in VS Code, ensure your `lib/main.dart` points to `WelcomeScreen()` from `team_crud_template.dart`.

### Step 3: Customize for Your Team App (Top of the File)
Open `lib/team_crud_template.dart`. Right at the top (lines 29 to 68), you will find the **CUSTOMIZATION ZONE**. You only need to edit these 6 variables:

```dart
// ============================================================================
// CUSTOMIZATION ZONE: CHANGE THESE VARIABLES FOR YOUR TEAM APP!
// ============================================================================

/// 1. Your App Name (Appears in top AppBar and Welcome Screen)
const String appTitle = 'Tasky';

/// 2. What noun does your app manage?
const String itemNoun = 'Task';

/// 3. Hint text shown inside the input box
const String inputHintText = 'Enter a new task...';

/// 4. Icon displayed beside each item in your list
const IconData itemIcon = Icons.check_circle_outline;

/// 5. Your team theme accent color
const Color themeColor = Color(0xFF0E7C86);

/// 6. Category / Tag options for your team app
const List<String> itemCategories = ['General', 'Priority', 'Review'];
```

### What Happens When You Save?
The moment you save your changes, your entire screen automatically adapts:
* The AppBar and Welcome screen display your team's title and theme color.
* The input field prompts for your specific item (e.g., "Enter expense description...", "Enter habit...").
* The category selector displays your team's custom tags (e.g., Food / Transport / Study for PocketWise).
* The item cards show your team's custom icon and accent color.
* Everything is fully functional: Create, Read, Delete, Date Picker, and Local Storage work immediately!

---

## 5. The Pre-Flight Inspection: 2 Quick Defensive Checks

Before submitting, verify that your app handles common mobile edge cases gracefully:

### Check 1: Keyboard Overflow (`RenderFlex`)
* **Test:** Tap the text field so the mobile software keyboard appears on screen.
* **Pass Criteria:** The screen scrolls smoothly without any yellow-and-black stripes.
* **Why it works:** Both `WelcomeScreen` and `DashboardScreen` are wrapped in `SingleChildScrollView`.

### Check 2: Empty Input Guard
* **Test:** Leave the text box blank and tap the "Add" button.
* **Pass Criteria:** The app does not add an empty blank card. A SnackBar message appears saying "Please enter a valid [itemNoun] name!".
* **Why it works:** The template includes an explicit empty check:
```dart
if (title.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Please enter a valid $itemNoun name!')),
  );
  return;
}
```

---

## 6. How to Tag Your Version Beta in Git (60 Seconds)

Once your app runs smoothly, open your terminal in VS Code and run these three commands:

```bash
git add .
git commit -m "feat(sprint-3): finalize week 16-17 combined packages and beta polish"
git tag v0.3.0-beta
git push origin --tags
```

You will see `v0.3.0-beta` appear on your GitHub repository releases and tags page!

---

## 7. Team Customization Reference

Remember: KantinKu is strictly Meldi's teacher demo. Find your team below and use these values in your Customization Zone:

| Team App | `appTitle` | `itemNoun` | Suggested `itemIcon` | Suggested Categories |
|---|---|---|---|---|
| **Tasky** | Tasky | Task | `Icons.check_circle_outline` | `['General', 'Priority', 'Review']` |
| **PocketWise** | PocketWise | Expense | `Icons.attach_money` | `['Food', 'Transport', 'Study']` |
| **ResQ** | ResQ | Contact | `Icons.phone_in_talk` | `['Family', 'Medical', 'Security']` |
| **HabitHero** | HabitHero | Habit | `Icons.fitness_center` | `['Morning', 'Afternoon', 'Evening']` |
| **BullsEye** | BullsEye | Goal | `Icons.flag` | `['Academic', 'Personal', 'Fitness']` |
| **FocusArc** | FocusArc | Session | `Icons.timer` | `['Deep Work', 'Reading', 'Coding']` |
| **CreatorHub** | CreatorHub | Video Idea | `Icons.videocam` | `['Shorts', 'Tutorial', 'Review']` |
| **BreakTimer** | BreakTimer | Break | `Icons.coffee` | `['Eye Rest', 'Stretch', 'Walk']` |
| **OpenApp** | OpenApp | Question | `Icons.help_outline` | `['Dart', 'Flutter', 'State']` |
| **NextStep** | NextStep | Milestone | `Icons.trending_up` | `['Portfolios', 'Essays', 'Deadlines']` |

---

## 8. Combined Assignment Submission Checklist (100 Points)

Submit the following 2 items to Google Classroom under `[Sprint 3] Week 16 & 17 Combined: Packages & Beta Polish`:
1. **Screenshot:** Your team app running, showing your custom title, custom category chips, and formatted dates.
2. **GitHub URL:** The link to your team's repository with the `v0.3.0-beta` tag visible.

Full credit (100/100) is awarded when both items are submitted!
