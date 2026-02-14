# BMI Calculator

A Flutter app to track BMI (Body Mass Index) with user accounts, multiple profiles, and cloud sync via Firebase.

---

## Table of Contents

- [Assets Used](#assets-used)
- [Fonts Used](#fonts-used)
- [Packages Used](#packages-used)
- [Installation Instructions](#installation-instructions)
- [Firebase & Role / Security Rules](#firebase--role--security-rules)
- [Implemented Features](#implemented-features)

---

## Assets Used

| Asset | Path | Usage |
|-------|------|--------|
| Environment config | `.env` | Loaded by `flutter_dotenv`; must contain `CLIENT_KEY` (Google Sign-In Web Client ID / server client ID). |
| Google icon | `assets/icons/google.png` | Used on the "Sign in with Google" button on Login and Register screens. |
| App icon source | `assets/icons/bmi.png` | Source image for launcher icons (Android & iOS) via `flutter_launcher_icons`. |

**Note:** `.env` is listed in `.gitignore`. Create a `.env` file in the project root with `CLIENT_KEY=your_google_web_client_id` for Google Sign-In to work.

---

## Fonts Used

Fonts are provided by the **Google Fonts** package (no custom font files in the project). The following families are used in the app:

| Font Family | Usage |
|-------------|--------|
| **Poppins** | Primary UI: headers, labels, buttons, body text, table text, profile names, app bar titles. |
| **Playball** | Decorative / accent: splash tagline ("Track Your Fitness Journey"), welcome app bar, profile BMI value display, splash/logo area. |
| **ABeeZee** | Used for the "Forgot password?" link on the login page. |

All are loaded at runtime via `google_fonts`; no `fonts:` section is defined in `pubspec.yaml`.

---

## Packages Used

### Dependencies

| Package | Version | Purpose |
|---------|---------|--------|
| `flutter` | SDK | Core framework. |
| `cupertino_icons` | ^1.0.8 | iOS-style icons. |
| `get` | ^4.7.3 | State management, routing, dependency injection, snackbars. |
| `hive` | ^2.2.3 | Local NoSQL storage for user and profile data. |
| `hive_flutter` | ^1.1.0 | Flutter bindings for Hive. |
| `google_fonts` | ^8.0.1 | Runtime font loading (Poppins, Playball, ABeeZee). |
| `animate_do` | ^4.2.0 | Splash and UI animations (e.g. FadeInLeft, HeartBeat). |
| `google_sign_in` | ^7.2.0 | Google Sign-In. |
| `syncfusion_flutter_charts` | ^32.2.4 | BMI history charts (column chart for weight, height, BMI over last 7 days). |
| `iconsax` | ^0.0.8 | Icons (e.g. add, activity). |
| `loading_animation_widget` | ^1.3.0 | Loading indicator (hexagon dots). |
| `firebase_core` | ^4.4.0 | Firebase initialization. |
| `firebase_auth` | ^6.1.4 | Email/password and Google Sign-In authentication. |
| `flutter_secure_storage` | ^10.0.0 | Secure storage for ID token and server client ID. |
| `shared_preferences` | ^2.5.4 | Login state and preferred profile ID. |
| `flutter_dotenv` | ^6.0.0 | Load `.env` (e.g. `CLIENT_KEY`). |
| `cloud_firestore` | ^6.1.2 | Cloud storage for user profiles and BMI history. |
| `flutter_launcher_icons` | ^0.13.1 | Generate app launcher icons from `assets/icons/bmi.png`. |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|--------|
| `hive_generator` | ^2.0.1 | Generate Hive adapters for models. |
| `build_runner` | ^2.0.3 | Run code generators (e.g. for Hive). |
| `flutter_test` | SDK | Testing. |
| `flutter_lints` | ^6.0.0 | Recommended Dart/Flutter lints. |

---

## Installation Instructions

### Prerequisites

- Flutter SDK (compatible with Dart `^3.10.4`)
- Firebase project (Android and/or iOS apps registered)
- For Google Sign-In: Web Client ID (or server client ID) for the project

### Steps

1. **Clone and install dependencies**

   ```bash
   git clone <repository-url>
   cd bmi
   flutter pub get
   ```

2. **Firebase setup**

   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com).
   - Add Android and/or iOS apps; download `google-services.json` (Android) and/or add `GoogleService-Info.plist` (iOS).
   - Place `google-services.json` in `android/app/`.
   - (Optional) Regenerate Flutter Firebase config:
     ```bash
     flutterfire configure
     ```
     This updates `lib/firebase_options.dart` and Firebase config files.

3. **Environment variables**

   - Create a `.env` file in the project root (see [Assets Used](#assets-used)).
   - Add your Google Sign-In Web Client ID:
     ```
     CLIENT_KEY=your_google_web_client_id_here
     ```
   - Do not commit `.env`; it is already in `.gitignore`.

4. **Generate Hive adapters**

   ```bash
   dart run build_runner build
   ```

5. **Generate launcher icons (optional)**

   ```bash
   dart run flutter_launcher_icons
   ```

6. **Run the app**

   ```bash
   flutter run
   ```

   For release builds:

   ```bash
   flutter build apk        # Android
   flutter build ios        # iOS
   ```

### Firebase / Firestore

- Enable **Authentication** (Email/Password and Google sign-in methods).
- Enable **Cloud Firestore** and create a database.
- Configure Firestore security rules as described in [Firebase & Role / Security Rules](#firebase--role--security-rules).

---

## Firebase & Role / Security Rules

The app does not ship with Firestore rules in the repo. Data is organized as:

- **Collection:** `users/{userId}/profiles/{profileId}`
- Each document under `profiles` holds a profile (name, gender, `historyMap` of BMI entries keyed by date).

**Role handling / recommended Firestore rules:** Access should be restricted so each user can read and write only their own data. Use `request.auth != null` and `request.auth.uid == userId`:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

This ensures:

- Only authenticated users can access Firestore.
- A user can access only documents under `users/{their-uid}/...`.

There are no separate “roles” in the app (e.g. admin vs user); all logged-in users are treated the same and can only manage their own profiles and BMI history.

---

## Implemented Features

- **Splash screen**  
  Animated logo, app name, tagline, and loading indicator; then redirects to login or home/profile based on auth and preferred profile.

- **Authentication**  
  - Email/password login and registration.  
  - Google Sign-In (requires `CLIENT_KEY` in `.env`).  
  - Password reset via email.  
  - Logout clears local data and navigates to login.

- **User state & storage**  
  - **Hive:** Current user (`Operator`), profiles, and BMI history (with 7-day cap per profile).  
  - **SharedPreferences:** Login flag and preferred profile ID.  
  - **Flutter Secure Storage:** Firebase ID token and server/client ID for Google Sign-In.

- **Profiles**  
  - Multiple profiles per user (name + gender).  
  - Create, edit, and delete profiles; data synced to Firestore and Hive.  
  - Preferred profile: last opened profile can be remembered and opened from splash.

- **BMI calculation & history**  
  - Per-profile BMI from weight and height (kg/lb, cm/inch).  
  - Status: Underweight / Normal / Overweight / Obese.  
  - Up to last 7 days of history per profile; add and edit entries by date.  
  - History stored in Firestore and Hive.

- **Profile page**  
  - Current status (latest BMI status).  
  - “Past 7 DATA”: expandable **graph** (Syncfusion column chart for weight, height, BMI) and **table** (date, weight, height, BMI, status; tap row to edit).  
  - Add/Edit record via bottom sheet (height/weight units and selectors).

- **Home page**  
  - List of profiles with latest BMI; tap to open profile page.  
  - Add/Edit/Delete profile (sheet and popup menu).  
  - FAB to add a new profile.

- **UI/UX**  
  - GetX for routing and bindings (splash, login, register, home, profile).  
  - Themed colors and gradients (splash, app bar, buttons).  
  - Google Fonts (Poppins, Playball, ABeeZee), Iconsax and Material icons.  
  - Animated splash and loading indicators.

- **Validation**  
  - Email format; password length (6–14); confirm password match; name and profile name (no duplicates).

- **Platform support**  
  - Android and iOS (Firebase config present); web/macOS/windows/linux not configured in `firebase_options.dart`.

---

## Project structure (high level)

- `lib/main.dart` – App entry, Firebase/Hive/dotenv/TokenStore init, GetMaterialApp and routes.  
- `lib/navigation/` – Routes and GetX pages.  
- `lib/core/` – Colors, validators, auth service, global variables.  
- `lib/data/` – Models (Operator, Profile, BMI), Hive/Preferences/Token stores, Firestore profile repository.  
- `lib/features/screens/` – Splash, login, register, home, profile (views, controllers, bindings, widgets).  
- `lib/features/widgets/` – Shared UI (headers, labels, app bar, loading animation).  

---

For more on Flutter, see [Flutter documentation](https://docs.flutter.dev/).
