# AGS Flutter Week 12: Git Collaboration & Team Development Workflow

Welcome to the **Week 12 IT Mobile App Development Bootcamp (Alta Global School)**!

In Week 12, we transition from solo development to **professional team collaboration**. Instead of emailing zip files or copying code over WhatsApp, your team will use **Git and GitHub** to build your **KantinKu** mobile app together on a shared codebase.

If you have never used Git or GitHub before, do not worry. This guide assumes you know **nothing** about version control. Follow each step in order.

---

## 1. The Big Picture: What is Git and GitHub?

### Everyday Analogy: Minecraft Save Points & Google Drive
* **Git** is like the **Save Game / Checkpoint engine** on your laptop. Every time you make progress, you create a "commit" (a timestamped snapshot of your project). If you accidentally delete a file or introduce a bug, Git lets you rewind time to an earlier working snapshot.
* **GitHub** is like **Google Drive for code**. It lives in the cloud. It is a shared website where your whole team uploads and downloads those snapshots so everyone works on the exact same project.

### Why We Never Email Zip Files Again
| The Old Way (Solo Zip Files) | The Professional Way (Git & GitHub) |
|---|---|
| `kantinku_v1.zip`, `kantinku_v2_final.zip`, `kantinku_v2_final_fix_beneran.zip` | One single clean repository: `kantinku-team` |
| Dev A copies code into Dev B's folder and accidentally overwrites 3 hours of work. | Git automatically merges changes from both developers safely. |
| Zero history: nobody knows who changed what line of code or why it broke. | Every commit records the exact author, date, and description. |
| Only one person can test at a time. | Every teammate works on their own laptop in parallel. |

---

## 2. Phase 1: Verify & Install Git on Your Laptop (10 Minutes)

Every student must do this on their own laptop once.

### Step 1.1: Open Your Terminal
* **Windows users:** Press `Windows Key + S`, type `cmd` (Command Prompt) or `Git Bash`, and press Enter.
* **Mac users:** Press `Command + Space`, type `Terminal`, and press Enter.

### Step 1.2: Check If Git Is Installed
In your terminal window, type this command and press Enter:
```bash
git --version
```

* **If you see:** `git version 2.43.0` (or any version number), Git is already installed! Skip to Step 1.3.
* **If you see:** `'git' is not recognized` or `command not found`:
  * **On Windows:** Go to [git-scm.com/downloads](https://git-scm.com/downloads). Download the Windows installer. Run the installer and click **Next** on all default settings until finished. Restart your terminal.
  * **On Mac:** In Terminal, type `xcode-select --install` and press Enter. Click **Install** on the pop-up window.

### Step 1.3: Set Your Name and Email (One-Time Setup)
Tell Git who you are. This information attaches to every commit you make. Run these two commands (replace with your real name and the email you will use for GitHub):

```bash
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"
```

Verify it saved correctly:
```bash
git config --global user.name
git config --global user.email
```
If both commands print your name and email, your laptop is ready!

---

## 3. Phase 2: Create Your GitHub Account & Connect VS Code (5 Minutes)

### Step 2.1: Create a GitHub Account
1. Open your web browser and go to [github.com](https://github.com).
2. Click **Sign up**.
3. Use your school or personal email and choose a professional username (for example, `meldi-hafizh` or `kevin-ags`).
4. Complete the verification puzzle and confirm your email from your inbox.

### Step 2.2: Sign In via VS Code (Easiest Method)
GitHub no longer accepts typing regular passwords in the command line. The easiest way to authenticate is through Visual Studio Code:
1. Open **Visual Studio Code**.
2. Look at the bottom-left corner of the window. Click the **Accounts icon** (the small circle with a person icon).
3. Click **Sign in with GitHub**.
4. Your browser will open. Click the green button: **Authorize Visual Studio Code**.
5. When prompted by your browser, click **Open Visual Studio Code**.
Now VS Code and Git are linked to your account. You will never need to type passwords in the terminal.

---

## 4. Phase 3: Set Up the Team Repository (Team Lead Only!)

In your team of 3 or 4 students, choose **ONE person to be the Team Lead**. Only the Team Lead performs this section. (Teammates move to Step 4.3).

### Step 4.1: Team Lead Creates the Repository on GitHub
1. Log in to [github.com](https://github.com).
2. In the top-right corner, click the **+** (plus) icon and select **New repository** (or go to [github.com/new](https://github.com/new)).
3. Fill in the form:
   * **Repository name:** `kantinku-<team-name>` (e.g. `kantinku-team-alpha` or `kantinku-group2-10b`).
   * **Description:** `KantinKu Mobile App - Alta Global School Week 12 Sprint 2`.
   * **Public / Private:** Choose **Public** (or **Private**).
   * **Add a README file:** Check this box!
   * **Add .gitignore:** Click the dropdown, type `Dart` or `Flutter`, and select it.
     *(Why? This prevents huge temporary folders like `build/` and `.dart_tool/` from uploading to GitHub!).*
4. Click the green button: **Create repository**.

### Step 4.2: Team Lead Invites Teammates as Collaborators
Your teammates cannot push code until you invite them:
1. On your newly created GitHub repository page, click the **Settings** tab (gear icon at the top right of the repo).
2. In the left sidebar, click **Collaborators** (under "Access").
3. Click the green button **Add people**.
4. Type each teammate's GitHub username or email address.
5. Click **Add [username] to this repository**.

### Step 4.3: Teammates Accept the Invitation
Each teammate must now:
1. Check their email for an invitation from GitHub, OR
2. Visit `https://github.com/<team-lead-username>/<repo-name>/invitations` directly while logged in.
3. Click **Accept invitation**.
*You now have full access to push code to the shared project!*

---

## 5. Phase 4: Clone the Repository to Everyone's Laptop (5 Minutes)

Every team member (including the Team Lead) must now clone the repository to their laptop.

### Step 5.1: Copy the Repository URL
1. Go to your team repository page on GitHub.
2. Click the green **<> Code** button.
3. Under the **HTTPS** tab, click the copy icon next to the URL (it looks like `https://github.com/lead-user/kantinku-team-alpha.git`).

### Step 5.2: Clone Using Terminal
1. Open your Terminal (Mac) or Command Prompt / Git Bash (Windows).
2. Navigate to your school projects folder (for example, Documents):
   ```bash
   cd ~/Documents
   ```
   *(Windows equivalent: `cd %USERPROFILE%\Documents`)*
3. Run `git clone` followed by the URL you copied:
   ```bash
   git clone https://github.com/<team-lead-username>/kantinku-<team-name>.git
   ```
4. Move into the newly created folder:
   ```bash
   cd kantinku-<team-name>
   ```
5. Open the folder in Visual Studio Code:
   ```bash
   code .
   ```
   *(If `code .` does not open VS Code, open VS Code manually, click File > Open Folder, and choose the `kantinku-<team-name>` folder).*

---

## 6. Phase 5: Adding the KantinKu Starter Code (Team Lead Only, Once)

Right now, your repository only has `README.md` and `.gitignore`. The Team Lead needs to add the initial Flutter app code once so everyone can start working.

1. Download or copy the **AGS Flutter Starter** project files (`lib/`, `pubspec.yaml`, `assets/`, `android/`, `ios/`, `web/`, etc.) into your local `kantinku-<team-name>` folder.
2. Open terminal inside `kantinku-<team-name>`:
   ```bash
   # 1. Check which files were added
   git status

   # 2. Add all files to staging
   git add .

   # 3. Save the initial commit
   git commit -m "feat: initial commit of KantinKu Flutter starter codebase"

   # 4. Push to GitHub
   git push origin main
   ```
3. Once pushed, all other teammates run:
   ```bash
   git pull origin main
   ```
   Now everyone has the exact same Flutter codebase!
4. Verify by running:
   ```bash
   flutter pub get
   flutter run
   ```

---

## 7. Phase 6: Mental Model: The 3 Zones of Git

Before typing commands, understand how Git moves files between 3 zones on your computer:

```
[ 1. Working Directory ]    --> You edit files in VS Code (e.g. cart_screen.dart)
         |
    ( git add . )
         v
[ 2. Staging Area ]         --> Box packed with files ready to be saved
         |
    ( git commit -m "..." )
         v
[ 3. Local Repository ]     --> Permanent sealed snapshot saved on your laptop
         |
    ( git push origin main )
         v
[ 4. GitHub (Cloud) ]       --> Synced online for your teammates to pull
```

* **Working Directory:** Where you write code. Git watches these files.
* **Staging Area (`git add`):** Like putting items into a shipping box before taping it shut.
* **Local Repository (`git commit`):** Taping the box shut and stamping it with a label and date. It is permanently saved on your laptop.
* **Remote Repository (`git push`):** Shipping the box to GitHub so teammates can open it.

---

## 8. Phase 7: The Daily 4-Step Team Workflow

Whenever you sit down to work on your app, follow this exact 4-step routine:

### The Golden Rule: Always PULL First!
Before typing any new code, download what your teammates finished:
```bash
git pull origin main
```
If you do this every time, you will almost never see a merge conflict.

---

### Step 1: Check What You Changed
After editing code in VS Code (e.g., building your cart screen), check your changes:
```bash
git status
```
*Modified files appear in red.*

---

### Step 2: Stage Your Changes
Put your changed files into the staging box:
```bash
git add .
```
*(Tip: `git add .` stages all changed files. If you only want to stage one file, use `git add lib/screens/cart_screen.dart`).*

Check status again:
```bash
git status
```
*Your staged files now appear in green.*

---

### Step 3: Commit Your Snapshot (With a Meaningful Message)
Save the snapshot to your computer history:
```bash
git commit -m "feat: add total price calculator and checkout button in CartScreen"
```

**Good vs Bad Commit Messages:**
* Bad: `git commit -m "update"`
* Bad: `git commit -m "fix bug"`
* Bad: `git commit -m "asdfasdf"`
* Good: `git commit -m "feat: implement item counter badge on HomeScreen"`
* Good: `git commit -m "fix: resolve null error when cart is empty"`
* Good: `git commit -m "style: update canteen header color to teal"`

---

### Step 4: Push to GitHub Cloud
Send your commit to GitHub so your teammates can download it:
```bash
git push origin main
```
Open your repository on [github.com](https://github.com) in your browser. You will see your commit message and your username right at the top!

---

## 9. Phase 8: Team Rules to Avoid Code Collisions

To keep team development smooth and stress-free, follow these four rules:

1. **Rule 1: Divide Responsibilities by File:**
   * Dev A: Works on `lib/screens/cart_screen.dart`
   * Dev B: Works on `lib/screens/menu_screen.dart`
   * Dev C: Works on `lib/screens/home_screen.dart` and shared models
   * *If two developers never edit the exact same lines of code at the same time, Git will merge your work automatically 100% of the time!*
2. **Rule 2: Pull Before You Start:** Always run `git pull origin main` every morning or at the start of every class.
3. **Rule 3: Commit Small, Commit Often:** Do not write code for 6 hours and make one massive commit at midnight. Commit every time you finish one button, one function, or one screen layout.
4. **Rule 4: Never Push Broken Code:** Always run your app (`flutter run`) to verify there are no syntax errors before running `git push`. If you push broken code, your teammates cannot run their apps either!

---

## 10. Phase 9: Beginner Troubleshooting FAQ

### Problem 1: "fatal: not a git repository (or any of the parent directories): .git"
* **What happened:** You are running Git commands from the wrong folder (e.g. `C:\Users\Name` instead of `C:\Users\Name\Documents\kantinku-team`).
* **The fix:**
  1. Type `pwd` on Mac or `cd` on Windows to see what folder you are currently in.
  2. Use `cd` to enter your project folder:
     ```bash
     cd Documents/kantinku-<team-name>
     ```

---

### Problem 2: "error: failed to push some refs... Updates were rejected because the remote contains work that you do not have locally"
* **What happened:** Your teammate pushed their code to GitHub 5 minutes ago! GitHub is refusing your push because you do not have your teammate's latest code yet.
* **The fix:**
  1. Pull your teammate's changes first:
     ```bash
     git pull origin main
     ```
  2. Now push your code:
     ```bash
     git push origin main
     ```

---

### Problem 3: "CONFLICT (content): Merge conflict in lib/screens/home_screen.dart"
* **What happened:** You and your teammate edited the exact same line of the exact same file, and Git does not know which version you want to keep.
* **The fix (Do not panic! VS Code makes this easy):**
  1. Open the file (`lib/screens/home_screen.dart`) in VS Code.
  2. You will see highlighted blocks with markers like this:
     ```
     <<<<<<< HEAD (Current Change - What is on your laptop)
     final canteenTitle = "Kantin SMAN 1 Alta";
     =======
     final canteenTitle = "KantinKu Alta Global School";
     >>>>>>> main (Incoming Change - What your teammate pushed)
     ```
  3. Above that block, VS Code shows 4 clickable buttons:
     * **Accept Current Change:** Keep your code and discard teammate's.
     * **Accept Incoming Change:** Discard your code and keep teammate's.
     * **Accept Both Changes:** Keep both.
  4. Click the option your team agrees on (or manually edit the text to combine them).
  5. Save the file (`Ctrl + S` or `Cmd + S`).
  6. In terminal, finish the merge:
     ```bash
     git add .
     git commit -m "fix: resolve merge conflict in home_screen title"
     git push origin main
     ```

---

### Problem 4: How to View Everyone's Commits
Want to see who worked on what? Run this command:
```bash
git log --oneline --graph --decorate
```
Or view the **Commits** tab on your GitHub repository page in your browser. Every single contribution from every team member is listed chronologically!

---

## 11. Sprint Review Checklist & Assessment Rubric

At the end of Sprint 2 (Week 13), every team will present a live **5-minute Sprint Review demo**. Here is how your team is graded:

| Category | Points | What the Teacher Checks |
|---|---|---|
| **1. Working Application** | 25 pts | `flutter run` launches the app successfully. Navigation between Home, Menu, and Cart works without crashing. |
| **2. Git Log Contribution** | 25 pts | `git log --oneline` shows commits from **EVERY** member of the team. No "ghost members" where only one person did all the commits! |
| **3. Repository Hygiene** | 25 pts | Clean repository on GitHub. Proper `.gitignore` is present (no `build/` or `.dart_tool/` folders uploaded). Commit messages are descriptive (`feat:`, `fix:`), not random keystrokes. |
| **4. Team Pitch & Demo** | 25 pts | 5-minute live demo. Every member speaks for at least 1 minute explaining the feature screen they personally built and committed. |
| **Total** | **100 pts** | Full Sprint Review Grade |

---

## 12. Quick Reference Command Cheat Sheet

Print or screenshot this table for quick reference during class:

```bash
# 1. Download teammates' latest code (Do this every morning)
git pull origin main

# 2. Check which files you changed
git status

# 3. Stage all your changes
git add .

# 4. Save your snapshot with a message
git commit -m "feat: short description of your change"

# 5. Upload your snapshot to GitHub
git push origin main

# 6. View team commit history
git log --oneline
```
