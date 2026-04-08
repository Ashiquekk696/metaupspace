# Metaupspace

Metaupspace is a Flutter app for employee login and dashboard viewing.

## Run The App

1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. Open this project folder in terminal.
3. Run:

```bash
flutter pub get
flutter run
```

## Build APK

Run from project root:

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`.

## Coding Architecture

- The code is organized by feature:
  - `auth` for login flow
  - `dashboard` for dashboard flow
- Each feature is split into:
  - `pages` (screen entry files)
  - `widgets` (UI parts)
  - `bloc` (screen logic)
- Shared reusable widgets are in `lib/shared/widgets`.
- Data request and response handling is inside repository implementation files.

## Folder Structure

```text
metaupspace/
├── assets/
│   └── fonts/
├── lib/
│   ├── core/
│   │   ├── di/
│   │   ├── network/
│   │   ├── theme/
│   │   └── ui/
│   ├── data/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   └── repositories/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── bloc/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── dashboard/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── shared/
│   │   └── widgets/
│   ├── app.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## State Management

- This app uses **BLoC** for screen state.
- `LoginBloc` handles login states (idle, loading, success, error).
- `DashboardBloc` handles dashboard states (initial, loading, ready, empty, error).
- UI listens to bloc state and updates automatically.

## Development Assumptions

- Backend APIs are mocked for now.
- Any valid email format + non-empty password is accepted in mock login.
- Dashboard data is kept in memory during app usage (no local database persistence yet).
