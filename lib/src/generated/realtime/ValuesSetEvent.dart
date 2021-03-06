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

part of google_drive_realtime;

class ValuesSetEvent extends BaseModelEvent {
  static ValuesSetEvent $wrap(js.JsObject jsObject) => jsObject == null ? null : new ValuesSetEvent.fromJsObject(jsObject);
  ValuesSetEvent.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject);
  int get index => $unsafe['index'];
  List<dynamic> get newValues => jsw.TypedJsArray.$wrap($unsafe['newValues']);
  List<dynamic> get oldValues => jsw.TypedJsArray.$wrap($unsafe['oldValues']);
}
