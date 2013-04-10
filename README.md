Dart Google Drive Realtime
==========================

This project is a library to use [Google Drive Realtime API](https://developers.google.com/drive/realtime/) from `dart` scripts.
It uses [JS Interop library](https://github.com/dart-lang/js-interop) and its scoped approch to prevent memory leaks. You can have a look at [Js Interop documentation](http://dart-lang.github.com/js-interop/docs/js.html) for more informations.

## Usage ##
To use this library in your code :
* add a dependency in your `pubspec.yaml` :

```yaml
dependencies:
  google_drive_realtime: ">=0.0.1 <1.0.0"
```

* add import in your `dart` code :

```dart
import 'package:google_drive_realtime/google_drive_realtime.dart';
```

* Follow the steps described at [Create a Realtime Application](https://developers.google.com/drive/realtime/application).

## License ##
Apache 2.0
