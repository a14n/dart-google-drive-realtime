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

@wrapper @skipConstructor class CollaborativeObject extends EventTarget {
  static CollaborativeObject $wrap(js.JsObject proxy) => null;

  jsw.SubscribeStreamProvider<ObjectChangedEvent> _onObjectChanged;
  jsw.SubscribeStreamProvider<ValueChangedEvent> _onValueChanged;

  CollaborativeObject.fromJsObject(js.JsObject jsObject) : super.fromJsObject(jsObject) {
    _onObjectChanged = _getStreamProviderFor(EventType.OBJECT_CHANGED, ObjectChangedEvent.$wrap);
    _onValueChanged = _getStreamProviderFor(EventType.VALUE_CHANGED, ValueChangedEvent.$wrap);
  }

  @generate String get id => null;

  @generate String toString() => null;

  Stream<ObjectChangedEvent> get onObjectChanged => _onObjectChanged.stream;
  Stream<ValueChangedEvent> get onValueChanged => _onValueChanged.stream;
}
