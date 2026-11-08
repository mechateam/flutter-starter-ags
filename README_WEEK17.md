# Week 17: Sprint 3 - Packages & Beta Polish (Roadmap to Demo Day)

Welcome to Sprint 3 of our Mobile App Development Bootcamp at Alta Global School!  
* Teacher: Meldi  
* Target Classes: Grades 10 & 11 (IT-10B, IT-10E, IT-10C, IT-11A, IT-10F)  
* Delivery Mode: 100% Online via Google Meet  
* Assignment: `[Sprint 3] Week 16 & 17 Combined: Packages & Beta Polish` (100 Points)  

---

## 1. The Big Picture: You Are 70% of the Way to Demo Day!

Look at how far your team has come since Week 1:

```
Sprint 0 (Weeks 1-2): Problem Discovery & Team Setup (Done!)
Sprint 1 (Weeks 3-5): Planning, Wireframing & Home UI (Done!)
Sprint 2 (Weeks 6-9): Navigation, Forms & Lists (Done!)
Sprint 3 (Weeks 14-17): The Working App Core Engine
  * Weeks 14-15: Local Storage + Dynamic CRUD (Done!)
  * Weeks 16-17 Combined: Packages + Beta Polish (You are here!)
Sprint 4 (Weeks 18-19): The Polished App
  * Week 18: Responsive Layout (Phones & Tablets)
  * Week 19: Final Polish & Release Candidate
Week 21: DEMO DAY! (Final Showcase to Teachers & Friends!)
```

Every week builds directly on your existing project. You are not starting from scratch: you are simply adding one layer of polish each week until your app is ready for the Demo Day stage!

---

## 2. What Does "Version Beta" Mean for High Schoolers?

You do not need to build a complex banking system. In our bootcamp, **Version Beta (`v0.3.0-beta`)** simply means:
1. **It remembers who you are:** You can log in on `WelcomeScreen` and see your name on `DashboardScreen` (Week 14).
2. **It adds and removes items:** You can type a new item, see it in the list, and delete it (Week 15).
3. **It looks sharp:** It uses dates and clean icons with `intl` (Week 16).
4. **It does not crash:** Typing a blank text or rotating the screen does not show yellow-and-black stripes (Week 17).

That is all it takes to have a verified Beta release!

---

## 3. Two Quick Fixes for Common Flutter Glitches

### Glitch 1: Yellow-and-Black Stripes (`RenderFlex Overflow`)
* **Why it happens:** The mobile keyboard pops up, or you enter a long sentence, and the screen runs out of room.
* **The 10-second fix:** Wrap your column in a `SingleChildScrollView`:
```dart
SingleChildScrollView(
  child: Column(
    children: [
      // Your input boxes and buttons here!
    ],
  ),
)
```

### Glitch 2: Blank Input Adding Empty Cards
* **Why it happens:** A user taps the Add button without typing anything.
* **The 10-second fix:** Check if text is empty before adding:
```dart
void _addItem() {
  final text = _controller.text.trim();
  if (text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter an item name!')),
    );
    return; // Stop right here, don't add blank items!
  }
  // Proceed to add item...
}
```

---

## 4. How to Tag Your Version Beta in Git (60 Seconds)

Once your app runs smoothly, open your terminal in VS Code and run these three commands:

```bash
git add .
git commit -m "feat(sprint-3): finalize week 16-17 combined packages and beta polish"
git tag v0.3.0-beta
git push origin --tags
```

You will see `v0.3.0-beta` appear on your GitHub repository releases page!

---

## 5. Team Customization Reference

Remember: KantinKu is strictly Meldi's teacher demo. Your team builds your own application:

| Team App | `appTitle` | `itemNoun` | Suggested `itemIcon` | Sample Item to Add |
|---|---|---|---|---|
| **Tasky** | Tasky | Task | `Icons.check_circle_outline` | "Review Flutter sprint slides" |
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

## 6. Combined Assignment Submission (100 Points)

Submit the following 3 items to Google Classroom:
1. **Screenshot 1:** Your app with formatted dates, icons, or category chips.
2. **Screenshot 2:** Your app scrolling smoothly without overflow warnings.
3. **GitHub URL:** Direct link to your repository showing your `v0.3.0-beta` tag.

Full credit (100/100) is guaranteed for every team that completes this straightforward checklist!
