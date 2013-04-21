library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main() {

  addTask('docs', createDartDocTask(_getLibs(), linkApi: true));

  addTask('analyze', createDartAnalyzerTask(_getLibs()));
  
  runHop();
  
}

void _assertKnownPath() {
  // since there is no way to determine the path of 'this' file
  // assume that Directory.current() is the root of the project.
  // So check for existance of /bin/hop_runner.dart
  final thisFile = new File('tool/hop_runner.dart');
  assert(thisFile.existsSync());
}

Future<List<String>> _getLibs() {
  return new Directory('lib').list()
      .where((FileSystemEntity fse) => fse is File && fse.path.endsWith("client.dart"))
      .map((File file) => file.path)
      .toList();
}

