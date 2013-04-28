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

// for databinding part
import 'package:google_drive_realtime/google_drive_realtime_databinding.dart';
```

* Follow the steps described at [Create a Realtime Application](https://developers.google.com/drive/realtime/application).

## How to ##

### Define custom collaborative objects ###

[Build a Collaborative Data Model](https://developers.google.com/drive/realtime/build-model#registering_and_creating_custom_objects) explains how to define custom objects in javascript. With this package, you can do almost the same things.

* Define your own _CollaborativeObject_ : it's mainly a wrapper of a javascript object. The `registerType()` static function allows to define the type.

```dart
class Task extends rt.CollaborativeObject {
  static const NAME = 'Task';

  /**
   * Register type as described in https://developers.google.com/drive/realtime/build-model#registering_and_creating_custom_objects
   * This method must be call only one time before the document is load.
   */
  static void registerType() {
    js.context.Task = new js.Callback.many((){});
    rtc.registerType(js.context.Task, NAME);
    js.context.Task.prototype.title = rtc.collaborativeField('title');
    js.context.Task.prototype.done = rtc.collaborativeField('done');
  }

  /// create new collaborative object from model
  Task(rt.Model model) : this.fromProxy(model.create(NAME).$unsafe);

  String get title => $unsafe.title;
  bool get done => $unsafe.done;
  set title(String title) => $unsafe.title = title;
  set done(bool done) => $unsafe.done = done;
}
```

Have a look on _custom-task_ example for more details.

* Register this type **before the document is loaded** by calling `registerType()`.

## License ##
Apache 2.0
