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

class CollaborativeList<E> extends CollaborativeObject {
  static CollaborativeList cast(js.Proxy proxy, [jsw.Translator translator]) => proxy == null ? null : new CollaborativeList.fromProxy(proxy, translator);

  static CollaborativeList castListOfSerializables(js.Proxy proxy, jsw.Mapper<dynamic, js.Serializable> fromJs, {mapOnlyNotNull: false}) => proxy == null ? null : new CollaborativeList.fromProxy(proxy, new jsw.TranslatorForSerializable(fromJs, mapOnlyNotNull: mapOnlyNotNull));

  final jsw.Translator<E> _translator;

  Stream<ValuesAddedEvent> _onValuesAdded;
  Stream<ValuesRemovedEvent> _onValuesRemoved;
  Stream<ValuesSetEvent> _onValuesSet;

  CollaborativeList.fromProxy(js.Proxy proxy, [jsw.Translator<E> translator]) : this._translator = translator, super.fromProxy(proxy) {
    _onValuesAdded = _getStreamFor(EventType.VALUES_ADDED, ValuesAddedEvent.cast);
    _onValuesRemoved = _getStreamFor(EventType.VALUES_REMOVED, ValuesRemovedEvent.cast);
    _onValuesSet = _getStreamFor(EventType.VALUES_SET, ValuesSetEvent.cast);
  }

  dynamic _toJs(E e) => _translator == null ? e : _translator.toJs(e);
  E _fromJs(dynamic value) => _translator == null ? value : _translator.fromJs(value);

  int get length => $unsafe['length'];

  void clear() { $unsafe.clear(); }
  E get(int index) => _fromJs($unsafe.get(index));
  void insert(int index, E value) { $unsafe.insert(index, _toJs(value)); }
  int push(E value) => $unsafe.push(_toJs(value));
  IndexReference registerReference(int index, bool canBeDeleted) => IndexReference.cast($unsafe.registerReference(index, canBeDeleted));
  void remove(int index) { $unsafe.remove(index); }
  void removeRange(int startIndex, int endIndex) { $unsafe.removeRange(startIndex, endIndex); }
  bool removeValue(E value) => $unsafe.removeValue(_toJs(value));
  void set(int index, E value) { $unsafe.set(index, _toJs(value)); }

  List<E> asArray() => jsw.JsArrayToListAdapter.cast($unsafe.asArray(), _translator);
  int indexOf(E value, [Comparator comparator]) {
    js.Callback comparatorCallback = null;
    if (comparator != null) {
      comparatorCallback = new js.Callback.many(comparator);
    }
    try {
      return $unsafe.indexOf(_toJs(value), comparatorCallback);
    } finally {
      if (comparatorCallback != null) {
        comparatorCallback.dispose();
      }
    }
  }
  void insertAll(int index, List<E> values) { $unsafe.insertAll(index, values is js.Serializable<js.Proxy> ? values : js.array(values.map(_toJs))); }
  int lastIndexOf(E value, [Comparator comparator]) {
    js.Callback comparatorCallback = null;
    if (comparator != null) {
      comparatorCallback = new js.Callback.many(comparator);
    }
    try {
      return $unsafe.lastIndexOf(_toJs(value), comparatorCallback);
    } finally {
      if (comparatorCallback != null) {
        comparatorCallback.dispose();
      }
    }
  }
  void pushAll(List<E> values) { $unsafe.pushAll(values is js.Serializable<js.Proxy> ? values : js.array(values.map(_toJs))); }
  void replaceRange(int index, List<E> values) { $unsafe.replaceRange(index, values is js.Serializable<js.Proxy> ? values : js.array(values.map(_toJs))); }

  Stream<ValuesAddedEvent> get onValuesAdded => _onValuesAdded;
  Stream<ValuesRemovedEvent> get onValuesRemoved => _onValuesRemoved;
  Stream<ValuesSetEvent> get onValuesSet => _onValuesSet;
}
