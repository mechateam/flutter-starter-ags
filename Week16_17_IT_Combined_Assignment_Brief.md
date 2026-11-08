# Alta Global School: IT SHS (Grades 10 & 11)
# Sprint 3 Concluding Assignment Brief (Week 16 & 17 Combined)
# Google Classroom Posting Specification

* Teacher: Meldi  
* Target Classes: IT-10 [B], IT-10 [E], IT-10 [C], IT-11 [A], IT-10 [F]  
* Delivery Mode: 100% Online via Google Meet  
* Assignment Title: `[Sprint 3] Week 16 & 17 Combined: Packages & Beta Polish`  
* Total Points: 100 Points  
* Due Date: Before each class's scheduled session in Week 17:  
  - IT-10 [B]: Monday, November 9, 2026 at 23:59 WIB (Before Tuesday 08:40 class)  
  - IT-10 [E]: Tuesday, November 10, 2026 at 23:59 WIB (Before Wednesday 07:30 class)  
  - IT-10 [C]: Thursday, November 12, 2026 at 23:59 WIB (Before Friday 07:30 class)  
  - IT-11 [A]: Thursday, November 12, 2026 at 23:59 WIB (Before Friday 08:40 class)  
  - IT-10 [F]: Thursday, November 12, 2026 at 23:59 WIB (Before Friday 09:50 class)  

---

## 1. Assignment Purpose & Context

Welcome to the Sprint 3 milestone! We are combining Weeks 16 and 17 into a single, straightforward assignment: **Packages & Beta Polish**. 

Your goal is to turn your team's working CRUD app into a clean, crash-free **Version Beta (`v0.3.0-beta`)**. You are already 70% of the way to our end-of-semester Demo Day (Week 21). You do not need to build complex new features or create multiple new files. Using our prepared two-tier template (`lib/team_crud_template.dart`), your team will install two official Flutter packages, customize the top 6 variables for your team app, test two defensive stability checks, and publish your Git tag.

---

## 2. The 4-Step Action Plan

### Step 1: Install Required Packages (30 Seconds)
Open the VS Code terminal in your project directory and run:
```bash
flutter pub add shared_preferences intl
```
This adds local storage persistence (`shared_preferences`) and date formatting (`intl`).

### Step 2: Open `lib/team_crud_template.dart`
Open the template file in your `lib/` directory. It uses Strategy 2 (Two-Tier Architecture):
* **Tier 1 (WelcomeScreen):** Login gate that remembers the user's name with `SharedPreferences`.
* **Tier 2 (DashboardScreen):** Dynamic CRUD list with dates (`intl`), Material 3 category chips (`ChoiceChip`), counter badge, and instant delete.

### Step 3: Edit the Customization Zone (60 Seconds)
At the very top of `lib/team_crud_template.dart` (lines 29 to 68), customize the 6 variables for your team:
* `appTitle`: Your app name (e.g., Tasky, PocketWise, ResQ).
* `itemNoun`: What your app manages (e.g., Task, Expense, Contact).
* `inputHintText`: Hint shown in the text field.
* `itemIcon`: Icon beside each item.
* `themeColor`: Your team accent color.
* `itemCategories`: 3 custom category tags.

### Step 4: Run Defensive Checks & Tag Git (60 Seconds)
1. **Keyboard Scroll Check:** Tap the text field to open the soft keyboard. Confirm the screen scrolls smoothly with no yellow-and-black stripes (`SingleChildScrollView`).
2. **Empty Input Check:** Tap Add with a blank text field. Confirm the app displays a SnackBar warning instead of adding an empty item.
3. **Tag Git Release:** In your terminal, run:
```bash
git add .
git commit -m "feat(sprint-3): finalize week 16-17 combined packages and beta polish"
git tag v0.3.0-beta
git push origin --tags
```

---

## 3. Team Customization Reference

KantinKu is strictly Meldi's teacher demo. Each team customizes their own app:

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

## 4. Assessment Rubric (100 Points Total)

| Evaluation Criterion | Exemplary (25 Points) | Proficient (15 Points) | Incomplete (0 Points) |
|---|---|---|---|
| **1. Package Installation & Setup (25 pts)** | `shared_preferences` and `intl` correctly installed in `pubspec.yaml` with zero dependency conflicts. | Packages installed but with minor configuration warnings. | Packages not installed or app fails to build. |
| **2. Team Customization Zone (25 pts)** | All 6 variables customized to team domain; app displays unique title, item noun, icon, and categories. | Partially customized (uses default Tasky labels for a different team app). | No customization applied. |
| **3. Defensive UI Stability (25 pts)** | Zero yellow-and-black stripes on keyboard popup; blank input rejected with friendly SnackBar alert. | One defensive check passes, but keyboard overflow or empty cards still occur. | Both defensive checks fail. |
| **4. GitHub Tagged Release v0.3.0-beta (25 pts)** | Annotated or lightweight git tag `v0.3.0-beta` pushed to GitHub repository with clean commit. | Code pushed to main branch but missing `v0.3.0-beta` git tag. | No code or tags pushed to GitHub. |

---

## 5. Google Classroom Submission Specification

Submit the following 3 items to Google Classroom before your scheduled session:

1. **Screenshot 1:** Your app running on emulator or phone, showing your customized team title, chips, and formatted dates.
2. **Screenshot 2:** Your app scrolling smoothly with the soft keyboard open (no overflow warnings).
3. **GitHub URL:** Direct link to your team repository showing the `v0.3.0-beta` release tag.

All questions can be asked during our live Google Meet sessions or posted in the Classroom stream.

Signed,  
Meldi  
IT Master Teacher  
Alta Global School
