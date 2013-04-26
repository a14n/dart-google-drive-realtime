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

class CollaborativeMap<V> extends CollaborativeObject {
  static CollaborativeMap cast(js.Proxy proxy, [jsw.Translator translator]) => proxy == null ? null : new CollaborativeMap.fromProxy(proxy, translator);

  static CollaborativeMap castMapOfSerializables(js.Proxy proxy, jsw.Mapper<dynamic, js.Serializable> fromJs, {mapOnlyNotNull: false}) => proxy == null ? null : new CollaborativeMap.fromProxy(proxy, new jsw.TranslatorForSerializable(fromJs, mapOnlyNotNull: mapOnlyNotNull));

  final jsw.Translator<V> _translator;

  Stream<ValueChangedEvent> _onValueChanged;

  CollaborativeMap.fromProxy(js.Proxy proxy, [jsw.Translator<V> translator])
      : this._translator = translator,
        super.fromProxy(proxy) {
    _onValueChanged = _getStreamFor(EventType.VALUE_CHANGED, ValueChangedEvent.cast);
  }

  dynamic _toJs(V e) => _translator == null ? e : _translator.toJs(e);
  V _fromJs(dynamic value) => _translator == null ? value :
      _translator.fromJs(value);

  int get size => $unsafe['size'];

  void clear() { $unsafe.clear(); }
  V delete(String key) => _fromJs($unsafe.delete(key));
  V get(String key) => _fromJs($unsafe.get(key));
  bool has(String key) => $unsafe.has(key);
  bool isEmpty() => $unsafe.isEmpty();
  List<List<V>> items() => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe.items(), (e) => jsw.JsArrayToListAdapter.cast(e, _translator));
  List<String> keys() => jsw.JsArrayToListAdapter.cast($unsafe.keys());
  V set(String key, V value) => _fromJs($unsafe.set(key, _toJs(value)));
  List<V> values() => jsw.JsArrayToListAdapter.cast($unsafe.values(), _translator);

  Stream<ValueChangedEvent> get onValueChanged => _onValueChanged;
}
