# Flutter Notes

## Stateful App

- App has `State` and `Widget`. so whenever a state variable changes, new instance of `Widget` is created with the data that is stored in the `State` class.

## Adding packages
- Run `flutter pub add http`

## Imports
- `import 'package:http/http.dart' show get;` is used to get only the `get` from the package

## Icons
- Use a package called `flutter_launcher_icons` and add the following code to `pubspec.yaml`
```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/random.png"
```
- Make sure that the icon png exists at the `image_path`.
- Now run `flutter pub run flutter_launcher_icons` to automatically create all the icons.

## HapticFeedback
- To provide haptic feedback, we have to use the `HapticFeedback` class to call different functions.