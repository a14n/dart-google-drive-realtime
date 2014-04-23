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

library google_drive_realtime_custom;

import 'dart:js' as js;

import 'package:js_wrapping/js_wrapping.dart' as jsw;
import 'package:google_drive_realtime/google_drive_realtime.dart';

final realtimeCustom = realtime['custom'];

dynamic collaborativeField(String name) => realtimeCustom.collaborativeField(name);

String getId(dynamic obj) => realtimeCustom.getId(obj);

Model getModel(dynamic obj) => Model.$wrap(realtimeCustom.getModel(obj));

bool isCustomObject(dynamic obj) => realtimeCustom.isCustomObject(obj);

void registerType(jsw.Serializable<js.JsFunction> type, String name) {
  realtimeCustom.registerType(type, name);
}

void setInitializer(jsw.Serializable<js.JsFunction> type, Function initialize) {
  realtimeCustom.setInitializer(type, initialize);
}

void setOnLoaded(jsw.Serializable<js.JsFunction> type, [Function onLoaded]) {
  realtimeCustom.setOnLoaded(type, onLoaded);
}