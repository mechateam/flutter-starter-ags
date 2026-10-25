# Alta Global School: IT SHS (Grades 10 & 11)
# Sprint 3 Combined Assignment Brief (Week 14 & Week 15)
# Google Classroom Posting Specification

* Teacher: Meldi  
* Target Classes: IT-10 [B], IT-10 [E], IT-10 [C], IT-11 [A], IT-10 [F]  
* Delivery Mode: 100% Online via Google Meet  
* Assignment Title: `[Sprint 3] Week 14 & 15 Combined: Customized Team CRUD & Local Storage`  
* Total Points: 100 Points  
* Due Date: Sunday, 23:59 WIB  

---

## 1. Assignment Purpose & Context

In Week 14, our teams tackled the **App Amnesia** problem using **Local Storage (`SharedPreferences`)**, learning how to write data to the phone's persistent notebook. In Week 15, we unlocked **Dynamic CRUD Lists**, learning how to add, view, and delete items using Flutter `setState` and `ListView.builder`.

This combined assignment brings both superpowers together into a single, straightforward milestone for your team mobile application:
1. **Week 14 Superpower (Local Storage):** Your app remembers who is logged in and retains state across emulator restarts.
2. **Week 15 Superpower (Dynamic CRUD):** Your app allows users to add new items and remove completed items in real time.

We have provided a ready-to-use, plug-and-play template (`team_crud_template.dart`). You only need to customize 6 lines of code at the top to adapt it to your team project!

---

## 2. Step-by-Step Student Instructions

### Step 1: Install the Storage Package (10 Seconds)
In VS Code, open the integrated terminal (`Ctrl + \`` or `Cmd + \``) and run:
```bash
flutter pub add shared_preferences
```

### Step 2: Open `team_crud_template.dart` and Customize (60 Seconds)
Open `team_crud_template.dart` and find the **CUSTOMIZATION ZONE** at the top. Modify the 6 variables to match your team project:

```dart
// 1. App Title
const String appTitle = 'Tasky'; // e.g., 'PocketWise', 'ResQ', 'HabitHero'

// 2. What noun does your app manage?
const String itemNoun = 'Task'; // e.g., 'Expense', 'Contact', 'Habit'

// 3. Hint text inside the input box
const String inputHintText = 'Enter a new task...';

// 4. Icon for your items
const IconData itemIcon = Icons.check_circle_outline;

// 5. Your team theme accent color
const Color themeColor = Color(0xFF0E7C86);

// 6. Default starter items
final List<String> defaultStarterItems = [
  'Review Flutter sprint slides',
  'Prepare team project demo',
];
```

### Step 3: Run and Test Your App
1. **Test Week 14 Local Storage:** Tap the **Edit** button in the top greeting card. Type your name, then tap **Save to Storage**. Notice your name updates and stays saved even if you hot restart!
2. **Test Week 15 Create (Add):** Type a new item into the input box and tap **Add [itemNoun]**. Notice it instantly appears in the active list.
3. **Test Week 15 Delete (Remove):** Tap the red trash can icon next to any item. Notice it vanishes from the list immediately.

### Step 4: Commit and Push to GitHub
In your terminal, commit and push your customized screen:
```bash
git add .
git commit -m "feat(sprint-3): add customized team CRUD screen with local storage"
git push
```

---

## 3. Team App Customization Guide

KantinKu is strictly Meldi's teacher classroom demo, not the students' app. Every student team customizes the template for their own distinct product:

| Team App | `appTitle` | `itemNoun` | Suggested `itemIcon` | Sample Item to Add |
|---|---|---|---|---|
| **Tasky** | Tasky | Task | `Icons.check_circle_outline` | "Review Flutter slides" |
| **PocketWise** | PocketWise | Expense | `Icons.attach_money` | "Boba Drink 20k" |
| **ResQ** | ResQ | Contact | `Icons.phone_in_talk` | "Emergency Mom Phone" |
| **HabitHero** | HabitHero | Habit | `Icons.fitness_center` | "Drink 2 Liters Water" |
| **BullsEye** | BullsEye | Goal | `Icons.flag` | "Score 90 in Math Exam" |
| **FocusArc** | FocusArc | Session | `Icons.timer` | "45 min Physics Study" |
| **CreatorHub** | CreatorHub | Video Idea | `Icons.videocam` | "Behind The Scenes Reel" |
| **BreakTimer** | BreakTimer | Break | `Icons.coffee` | "10 min Eye Rest Walk" |
| **OpenApp** | OpenApp | Question | `Icons.help_outline` | "How to debug null safety?" |
| **NextStep** | NextStep | Milestone | `Icons.trending_up` | "Submit college portfolio" |

---

## 4. Google Classroom Submission Checklist

Submit the following 4 items to the Google Classroom assignment:

1. **Screenshot 1 (Week 14 Local Storage):**  
   A screenshot showing your saved profile name displayed in the top greeting card (e.g., "Logged In: Alex").
2. **Screenshot 2 (Week 15 Create):**  
   A screenshot showing your newly added item appearing in the customized list.
3. **Screenshot 3 (Week 15 Delete):**  
   A screenshot showing the list after you deleted an item using the trash can icon.
4. **GitHub Commit URL:**  
   The direct URL to your commit on GitHub showing your modified code.

---

## 5. 100-Point Grading Rubric

| Criteria | Points | Description |
|---|---|---|
| **Team App Customization** | **25 pts** | App title, item noun, icon, and starter items are tailored to your team project. |
| **Week 14 Local Storage** | **25 pts** | Profile name is successfully saved to disk and persists across app reloads. |
| **Week 15 Create & Delete** | **25 pts** | Items add dynamically on button press and remove cleanly on trash icon tap. |
| **GitHub Commit & Delivery** | **25 pts** | Clean commit pushed to your team repository with working link before deadline. |
| **Total** | **100 pts** | **Full Credit guaranteed for every team that completes the checklist.** |
