# Poop Pal

Poop Pal is a Flutter app for simple daily poop tracking. It presents a month calendar, lets the user mark whether they pooped on a selected day, and stores logs locally so the history persists between app launches.

## What It Does

- Shows a calendar-first tracking screen for the current month.
- Lets the user select days, jump back to today, and move between months.
- Creates one primary poop log per day and allows removing an existing log.
- Blocks new logs for future dates.
- Persists logs in a local SQLite database through Drift.
- Includes optional placeholder sections for future health details such as Bristol type, mood, hydration, fiber, notes, streaks, and navigation tabs.

## Project Structure

- `lib/main.dart` starts the Flutter app.
- `lib/app/` contains app-level setup, feature flags, and theme configuration.
- `lib/features/calendar/screens/` contains the main calendar screen.
- `lib/features/calendar/widgets/` contains reusable calendar, log, navigation, and placeholder UI widgets.
- `lib/features/calendar/data/` contains the Drift database and repository.
- `lib/features/calendar/models/` contains the domain model for a poop log.
- `lib/shared/` contains shared assets and date helpers.
- `test/` contains repository and widget tests.

## Data Model

Logs are stored in `poop_pal.sqlite` using Drift. Each log records:

- occurrence date and time
- normalized unique log date
- optional Bristol type, mood, notes, hydration cups, and fiber grams
- created and updated timestamps

The repository keeps one log per calendar day and validates that logs cannot be created or moved to future dates.

## Development

Install dependencies:

```sh
flutter pub get
```

Run the app:

```sh
flutter run
```

Run tests:

```sh
flutter test
```

Run static analysis:

```sh
flutter analyze
```

Regenerate Drift code after changing the database schema:

```sh
dart run build_runner build
```

## Notes

The project currently focuses on the core calendar logging workflow. Several health-tracking sections are present behind feature flags as UI placeholders for future expansion.
