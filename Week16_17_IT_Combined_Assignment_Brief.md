# Alta Global School: IT SHS (Grades 10 & 11)
# Sprint 3 Combined Assignment Brief (Week 16 & Week 17)
# Google Classroom Posting Specification

* Teacher: Meldi  
* Target Classes: IT-10 [B], IT-10 [E], IT-10 [C], IT-11 [A], IT-10 [F]  
* Delivery Mode: 100% Online via Google Meet  
* Assignment Title: `[Sprint 3] Week 16 & 17 Combined: Packages & Beta Polish (Roadmap to Demo Day)`  
* Total Points: 100 Points  
* Assessment Weighting: Targets 10% Testing & Debugging and 15% Team Collaboration  
* Due Date: Sunday before Sprint 4 begins (23:59 WIB)  

---

## 1. The Big Picture: Our Roadmap to Demo Day!

Every single line of code you write connects directly to your final showcase at the end of the semester:

```
[Sprint 3: Weeks 14-15] -> [Sprint 3: Weeks 16-17] -> [Sprint 4: Week 18] -> [Sprint 4: Week 19] -> [Week 21]
Storage & CRUD (Done!)  -> Packages & Beta (Current) -> Responsive Layout -> Final Polish      -> DEMO DAY!
```

* **Weeks 14-15 (Done!):** You gave your app memory with Local Storage and dynamic CRUD lists.
* **Weeks 16-17 Combined (Current Milestone):** You add simple packages (`intl` for dates, custom icons) and polish out little visual bugs so your app reaches **Version Beta**!
* **Week 18 (Next Sprint):** Responsive design: making your app look sharp on both phones and tablets.
* **Week 19:** Final user feedback and Release Candidate.
* **Week 21:** **Demo Day!** Presenting your team mobile app to teachers and classmates.

---

## 2. Super Simple 3-Step Mission

We have already updated `team_crud_template.dart` so it supports everything out-of-the-box. You only need to complete three simple steps:

### Step 1: Add a Package Feature (Week 16)
In your terminal, add the official internationalization package:
```bash
flutter pub add intl
```
In `team_crud_template.dart`, your items already display clean dates and category tags using `intl`. Make sure your team has picked an icon and color that fits your brand!

### Step 2: Quick Bug Check & Polish (Week 17)
Run your app and test two simple things:
1. Tap **Add** with a blank input box: Verify your app does not crash and prompts you to enter text.
2. Enter a longer sentence: Verify the card expands cleanly and scrolls smoothly without yellow-and-black overflow bars.

If you see an overflow warning, simply make sure your list or column is wrapped in a `SingleChildScrollView` or `ListView.builder`.

### Step 3: Tag Version Beta & Push to GitHub
When your app runs cleanly, push your commit and create your official Beta tag in your VS Code terminal:
```bash
git add .
git commit -m "feat(sprint-3): complete week 16-17 packages and beta polish"
git tag v0.3.0-beta
git push origin --tags
```

---

## 3. Team Customization Reference

KantinKu is strictly Meldi's teacher classroom demo. Each team personalizes their own product:

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

## 4. Google Classroom Submission Checklist (100 Points)

Submit only 3 items to Google Classroom:

1. **Screenshot 1 (Week 16 Packages):**  
   A screenshot showing your app with dates, badges, or category chips active.
2. **Screenshot 2 (Week 17 Beta Stability):**  
   A screenshot of your customized list scrolling smoothly without any error banners.
3. **GitHub URL & Tag:**  
   The direct URL to your GitHub repository showing your `v0.3.0-beta` tag.

---

## 5. Straightforward 100-Point Grading Rubric

| Criteria | Points | Description |
|---|---|---|
| **Week 16 Packages & Styling** | **35 pts** | App features clean dates, team theme color, and custom icons. |
| **Week 17 Beta Stability** | **35 pts** | App handles inputs smoothly without crashes or overflow bars. |
| **GitHub Commit & Beta Tag** | **30 pts** | Clean commit with `v0.3.0-beta` tag pushed to your team repository. |
| **Total** | **100 pts** | **Full Credit guaranteed for every team that completes the checklist.** |
