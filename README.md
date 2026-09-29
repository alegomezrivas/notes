# notas

An application to save notes on your phone.

## Running

Requires Flutter 3.x (Dart 3) and, for Android, the Android SDK (Java 17).

```bash
flutter pub get
flutter run        # with a device or emulator connected
flutter test
```

`android/local.properties` is machine-specific and ignored; `flutter pub get` / `flutter run` creates it.

If you change `lib/features/notes/domain/entities/note.dart`, regenerate the Hive adapter:

```bash
dart run build_runner build --delete-conflicting-outputs
```
