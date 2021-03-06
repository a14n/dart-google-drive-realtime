// Copyright (c) 2013, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library google_drive_realtime_databinding;

import 'dart:html';
import 'dart:js' as js;

import 'package:js_wrapping/js_wrapping.dart' as jsw;
import 'package:js_wrapping_generator/dart_generator.dart';

import 'google_drive_realtime.dart';

part 'src/databinding/already_bound_error.dart';
part 'src/databinding/binding.dart';

final js.JsObject realtimeDatabinding = realtime['databinding'];

Binding bindString(CollaborativeString string, TextInputElement textInputElement) => Binding.$wrap(realtimeDatabinding.callMethod('bindString', [jsw.mayUnwrap(string), textInputElement]));
