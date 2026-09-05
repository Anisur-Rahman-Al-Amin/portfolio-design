Anisur Rahman Portfolio

A responsive Flutter portfolio for web, Android, iOS, desktop, and Linux.

## Architecture

- `lib/app.dart`: theme, shell, page switching, and shared navigation
- `lib/core/`: constants, theme, responsive helpers, and reusable widgets
- `lib/data/`: typed portfolio models and the local repository
- `lib/features/`: independently replaceable feature pages and widgets
- `lib/routing/`: application route names for future Navigator or GetX routing
- `assets/`: images, icons, animations, documents, and font locations

## Run

```bash
flutter pub get
flutter run -d chrome
```

## Verify

```bash
flutter analyze
flutter test
flutter build web
```

Add real profile images, project screenshots, certificates, fonts, and a resume under `assets/` when they are available. The repository currently uses a local typed data source so content can be replaced without changing the UI layer.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
