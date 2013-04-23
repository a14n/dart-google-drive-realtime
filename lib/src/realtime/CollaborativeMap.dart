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

class CollaborativeMap extends CollaborativeObject {
  static CollaborativeMap cast(js.Proxy proxy) => proxy == null ? null : new CollaborativeMap.fromProxy(proxy);

  Stream<ValueChangedEvent> _onValueChanged;

  CollaborativeMap.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onValueChanged = _getStreamFor(EventType.VALUE_CHANGED, ValueChangedEvent.cast);
  }

  int get size => $unsafe['size'];

  void clear() { $unsafe.clear(); }
  dynamic delete(String key) => $unsafe.delete(key);
  dynamic get(String key) => $unsafe.get(key);
  bool has(String key) => $unsafe.has(key);
  bool isEmpty() => $unsafe.isEmpty();
  List<List<dynamic>> items() => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe.items(), (e) => jsw.JsArrayToListAdapter.cast(e));
  List<String> keys() => jsw.JsArrayToListAdapter.cast($unsafe.keys());
  dynamic set(String key, dynamic value) => $unsafe.set(key, value);
  List<dynamic> values() => jsw.JsArrayToListAdapter.cast($unsafe.values());

  Stream<ValueChangedEvent> get onValueChanged => _onValueChanged;
}
