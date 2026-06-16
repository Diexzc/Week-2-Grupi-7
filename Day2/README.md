# Day 2 - Student Profile List with Registration Form

**Internal Internship - Day 2: Layout, forma dhe validim**

Author: Nils Shehu
Branch: Nils-Shehu

## Description

A Flutter app that displays a scrollable list of student profiles and allows adding new students through a validated registration form.

## Features

- Student list with Cards (name, email, role badge, avatar initials)
- "Shto Student" modal bottom sheet with validated form
- Three validated fields: Emri, Email, Fjalekalimi
- Validation: empty checks, email format regex, password minimum length
- Swipe-to-delete with undo option
- Student counter badge in AppBar
- Empty state screen when no students exist
- Dark theme with custom ThemeData (colors, typography, input styles)
- Responsive layout with SingleChildScrollView and ListView.builder

## Flutter Concepts Covered

| Concept | Usage |
|---------|-------|
| StatefulWidget | StudentListScreen (manages student list state) |
| StatelessWidget | StudentCard (displays a single student) |
| TextEditingController | Name, email, password input fields |
| Form + TextFormField | Validation with error messages |
| ListView.builder | Efficiently renders student list |
| Card / Container | Student card layout |
| Padding, SizedBox, Expanded | Layout spacing and responsiveness |
| ThemeData | Dark theme, input decoration, button styles |
| showModalBottomSheet | Add-student form overlay |
| Dismissible | Swipe-to-delete gesture |

## How to Test

1. Open [DartPad](https://dartpad.dev/?channel=stable)
2. Click the **Flutter** toggle (top right) to enable Flutter mode
3. Select ALL existing code (Ctrl+A) and DELETE it
4. Copy the contents of `main.dart` and paste into DartPad
5. Click **Run**

## Git Commits

```bash
git add .
git commit -m "day2 student list ui"
git commit -m "day2 registration form validation"
git push origin Nils-Shehu
```
