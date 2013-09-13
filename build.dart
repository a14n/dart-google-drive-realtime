import 'dart:io';
import 'package:js_wrapping/generator.dart';
import 'package:editor_build/editor_build.dart';
import 'package:path/path.dart' as path;

main() {
  final arguments = new Options().arguments;
  final buildOptions = BuildOptions.parse(arguments.isEmpty ? ['--clean', '--full'] : arguments);
  final template = new Directory('lib-template/src');
  final target = new Directory('lib/src/generated');
  if (buildOptions.clean && target.existsSync()) target.deleteSync(recursive: true);
  if (buildOptions.full) {
    transformDirectory(template, target..createSync(recursive: true));
  }
  buildOptions.removed
    .where((file) => file.startsWith(template.path))
    .forEach((file) {
      new File(target.path + '/' + path.relative(file, from: template.path)).deleteSync();
    });
  buildOptions.changed
    .where((file) => file.startsWith(template.path))
    .forEach((file) {
      transformFile(new File(file), new File(target.path + '/' + path.relative(file, from: template.path))..createSync());
    });
}