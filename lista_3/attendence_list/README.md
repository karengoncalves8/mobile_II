# Attendance List

Simple Flutter app to register people and mark attendance with checkboxes.

## Features

- Add person names to an attendance list.
- Mark each person as present or absent.
- Remove people from the list.
- Persist all data in a SQLite database.
- Restore saved data automatically when the app restarts.
- Responsive UI for desktop and mobile layouts.

## Architecture

The app follows a small layered architecture focused on SOLID and KISS:

- `domain/`: business entities and repository contracts.
- `data/`: SQLite data source and repository implementation.
- `presentation/`: controller + reusable UI components.
- `core/`: infrastructure helpers (database initialization).

## Tech Stack

- Flutter + Material 3 components.
- `sqflite` for mobile SQLite access.
- `sqflite_common_ffi` for desktop SQLite access.

## Run

```bash
flutter pub get
flutter run
```
