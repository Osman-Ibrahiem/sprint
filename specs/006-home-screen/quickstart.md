# Quickstart: validating the Home screen

Prerequisites: Flutter SDK per `pubspec.yaml`; `flutter pub get`; `dart run build_runner build --delete-conflicting-outputs`; `flutter gen-l10n`.

## Automated
```bash
dart format --set-exit-if-changed lib test
flutter analyze
flutter test test/features/home
flutter test
```
Expected: no issues; all tests pass (domain pricing/use case, guest and booker widget tests, widths 320–1400 dp).

## Manual — web
```bash
flutter build web --release && (cd build/web && python3 -m http.server 8098)
```
- `http://localhost:8098/#/home` → guest: brand bar with sign-in, pitch, full prices, no navigation; every button leads to login.
- `http://localhost:8098/#/home?session=booker` → greeting, next booking, discounted prices (struck-through full price), navigation.
- Resize: 375 dp → one column + bottom bar; ≥ 600 dp → rail and more columns.

## Manual — iOS simulator
```bash
flutter run -d <simulator-id> --route "/home?session=booker"
```
Expected: same as web; Apple look for the spinner and filled button. Repeat with the platform override to check the Material look.

See [data-model.md](data-model.md) and [contracts/widget-contracts.md](contracts/widget-contracts.md).
