# Alta Global School: Mobile Application Bug Report Template
# Sprint 3 Quality Assurance Milestone (Week 17)

This template is the official bug report specification for Alta Global School IT SHS (Grades 10 & 11). Use this template to document defects discovered during peer cross-testing sessions.

---

## 1. Defect Header

| Field | Value |
|---|---|
| Bug ID | BUG-001 (Sequential: BUG-001, BUG-002, etc.) |
| Target Application | [Name of Peer App, e.g., Tasky, PocketWise, ResQ, HabitHero, BullsEye] |
| Target Repository | [GitHub URL of Peer Team Repository] |
| Target Version / Commit | [Commit Hash or Branch, e.g., commit 7a8b9c1] |
| Testing Team | [Your Team Name] |
| Tester Name(s) | [Student Names] |
| Date Reported | YYYY-MM-DD |
| Defect Severity | [P1 Blocker / P2 Major / P3 Minor] |
| Defect Status | [Open / In Progress / Verified Fixed] |

---

## 2. Bug Summary
Provide a single, clear, descriptive sentence explaining the failure.
Example: "Tapping 'Add Task' with empty input causes Red Screen RangeError crash."

**Summary:**
[Write your one-sentence summary here]

---

## 3. Severity Classification

Select ONE severity level based on the criteria below:

- [ ] **P1: Blocker (Crash / Fatal Data Loss)**
  - The application terminates unexpectedly, freezes indefinitely, shows the Red Screen of Death, or corrupts stored data.
  - Core progression is blocked with zero available workaround.
  - Must be resolved immediately before Version Beta release.

- [ ] **P2: Major (Feature Failure / Broken Flow)**
  - A primary user story fails to complete as designed.
  - Examples: Delete button fails to remove an item, filter chips do not update the displayed list, or local storage does not save user preferences across restarts.
  - The app remains interactive, but a core feature is inoperable.

- [ ] **P3: Minor (Cosmetic / Layout Glitch)**
  - Visual or experiential defects that do not prevent feature completion.
  - Examples: Unintended text wrapping, minor padding inconsistency, typo in hint text, or missing placeholder icon.

---

## 4. Test Environment Details

| Environment Parameter | Specification |
|---|---|
| Testing Device / Emulator | [e.g., Pixel 7 API 34 Emulator, iPhone 15 Simulator, Physical Android Device] |
| Screen Resolution / Density | [e.g., 1080x2400, xxhdpi] |
| Flutter SDK Version | [Output of `flutter --version`, e.g., Flutter 3.24.x / Dart 3.5.x] |
| Host Operating System | [e.g., macOS Sonoma, Windows 11, Linux Ubuntu] |

---

## 5. Preconditions
List any setup required before triggering the defect.
- Example 1: Fresh application installation with no pre-existing SharedPreferences data.
- Example 2: At least 3 items present in the active list.

**Preconditions:**
1. [Precondition 1]
2. [Precondition 2]

---

## 6. Step-by-Step Reproduction Steps
Provide numbered, deterministic steps that allow the development team to reproduce the defect every single time. Do not skip steps.

1. Launch the application on the test device or emulator.
2. Navigate to [Screen Name, e.g., DashboardScreen].
3. Tap on [Input Field Name] without typing any characters.
4. Tap the [Button Name, e.g., 'Add Item'] button.
5. Observe the application behavior.

---

## 7. Expected vs Actual Outcome

### Expected Behavior
Describe what the application should do according to the specification or standard user experience.
- Example: "The input field should display a red helper validation text 'Please enter a valid item title', and no item should be added to the list."

**Expected:**
[Describe expected behavior here]

### Actual Behavior
Describe what actually occurred during the test.
- Example: "The application froze for one second, followed by a red screen with exception: 'RangeError (index): Invalid value: Valid value range is empty: 0'."

**Actual:**
[Describe actual behavior here]

---

## 8. Evidence & Diagnostic Artifacts

### Visual Evidence
Attach or link screenshots or screen recording showing the defect in action:
- Screenshot / Video Link: [Insert URL or local path]

### Stack Trace / Debug Console Logs
Paste the relevant error message from the VS Code Debug Console or terminal:

```text
[Paste stack trace here, highlighting the top exception message and the offending line number]
```

---

## 9. Resolution & Verification (To be completed by Receiving Team)

| Field | Value |
|---|---|
| Assigned Developer | [Team Member who fixed the bug] |
| Root Cause Analysis | [Explanation of why the defect occurred in the source code] |
| Solution Applied | [Explanation of defensive code or architectural fix implemented] |
| Resolving Commit Hash | [Git commit hash, e.g., fix(dashboard): add guard clause for empty input (commit abc1234)] |
| Regression Test Passed | [Yes / No - Verified by tester] |
| Closure Date | YYYY-MM-DD |
