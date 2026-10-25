# Week 15: Sprint 3 - Dynamic CRUD & Local Storage (Combined Guide)

Welcome to Sprint 3 of our Mobile App Development Bootcamp at Alta Global School!  
* Teacher: Meldi  
* Target: Grades 10 & 11 (IT-10B, IT-10E, IT-10C, IT-11A, IT-10F)  
* Delivery Mode: 100% Online via Google Meet  

---

## The Big Idea: Whiteboard + Slip Rail = Full App Power!

In Sprint 3, we combine two fundamental app superpowers:

1. **Week 14 Superpower: The Persistent Notebook (Local Storage)**  
   Solves **App Amnesia**. Writing data to `SharedPreferences` ensures your app remembers who the user is even after restarting the phone emulator.
2. **Week 15 Superpower: The Kitchen Order Rail (Dynamic CRUD)**  
   Brings your screens to life.
   * **C (Create):** Pin a new slip to the rail (`_items.add(text)`).
   * **R (Read):** Scan all active slips (`ListView.builder`).
   * **D (Delete):** Rip a completed slip off the rail (`_items.removeAt(index)`).

---

## 60-Second Setup: How to Use `team_crud_template.dart`

We have created a complete, working template in `lib/team_crud_template.dart`. You only need to customize 6 lines of code to turn it into your team's custom feature!

### Step 1: Install Storage Package (1 Command)
In your VS Code terminal, run:
```bash
flutter pub add shared_preferences
```

### Step 2: Drop the Template into your Project
Copy `team_crud_template.dart` into your project's `lib/` folder.

### Step 3: Customize for Your Team App (Top of the File)
Open `lib/team_crud_template.dart`. Right at the top, find the **CUSTOMIZATION ZONE**:

```dart
// ============================================================================
// CUSTOMIZATION ZONE: CHANGE THESE 6 VARIABLES FOR YOUR TEAM APP!
// ============================================================================

// 1. App Title (Appears in top AppBar)
const String appTitle = 'Tasky'; // Change to: 'PocketWise', 'ResQ', 'HabitHero', etc.

// 2. What noun does your app manage?
const String itemNoun = 'Task'; // Change to: 'Expense', 'Contact', 'Habit', etc.

// 3. Hint text inside the input box
const String inputHintText = 'Enter a new task...';

// 4. Icon displayed beside each item in your list
const IconData itemIcon = Icons.check_circle_outline;

// 5. Your team theme accent color
const Color themeColor = Color(0xFF0E7C86);

// 6. Default starter items for your team app
final List<String> defaultStarterItems = [
  'Review Flutter sprint slides',
  'Prepare team project demo',
];
```

That is it! When you save, your entire screen automatically adapts:
* The AppBar displays your team's app name.
* The greeting card lets you save and load your name using Week 14 Local Storage.
* The input box and button say "Add [Your Item]".
* The dynamic list displays your team's icon and items with instant delete buttons!

---

## How CRUD Works Under the Hood

### 1. Create (Add 1 Item)
```dart
void _addItem() {
  final text = _itemInputController.text.trim();
  if (text.isNotEmpty) {
    setState(() {
      _items.add(text); // 1. Add to in-memory list
    });
    _itemInputController.clear(); // 2. Clear input box
  }
}
```

### 2. Read (Display Items with `ListView.builder`)
```dart
ListView.builder(
  itemCount: _items.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(itemIcon),
      title: Text(_items[index]),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () => _deleteItem(index),
      ),
    );
  },
)
```

### 3. Delete (Remove 1 Item)
```dart
void _deleteItem(int index) {
  setState(() {
    _items.removeAt(index); // Removes the item at that specific row number!
  });
}
```

---

## Team App Cheat Sheet

KantinKu is strictly Meldi's teacher demo. Map your app using this reference:

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

## Combined Assignment Submission (100 Points)

Submit the following to Google Classroom:
1. **Screenshot 1 (Week 14 Local Storage):** Greeting card showing your saved profile name.
2. **Screenshot 2 (Week 15 Create):** Customized list showing your newly added item.
3. **Screenshot 3 (Week 15 Delete):** Customized list showing the item removed after tapping the trash can.
4. **GitHub Commit URL:** Direct link to your commit on GitHub.

**100-Point Rubric:**
* Team Customization (25 pts)
* Week 14 Local Storage (25 pts)
* Week 15 Create & Delete (25 pts)
* GitHub Commit (25 pts)

Full credit (100/100) is guaranteed for every team that completes this straightforward checklist!
