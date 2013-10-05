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

// TODO(aa) make this class mixin ListMixin
@wrapper @skipCast @skipConstructor class CollaborativeList<E> extends CollaborativeObject /* with ListMixin<E> */ {
  static CollaborativeList cast(js.JsObject jsObject, [jsw.Translator translator]) => jsObject == null ? null : new CollaborativeList.fromJsObject(jsObject, translator);

  static CollaborativeList castListOfSerializables(js.JsObject jsObject, jsw.Mapper<dynamic, js.Serializable> fromJs, {mapOnlyNotNull: false}) => jsObject == null ? null : new CollaborativeList.fromJsObject(jsObject, new jsw.TranslatorForSerializable(fromJs, mapOnlyNotNull: mapOnlyNotNull));

  final jsw.Translator<E> _translator;

  jsw.SubscribeStreamProvider<ValuesAddedEvent> _onValuesAdded;
  jsw.SubscribeStreamProvider<ValuesRemovedEvent> _onValuesRemoved;
  jsw.SubscribeStreamProvider<ValuesSetEvent> _onValuesSet;

  CollaborativeList.fromJsObject(js.JsObject jsObject, [jsw.Translator<E> translator]) : this._translator = translator, super.fromJsObject(jsObject) {
    _onValuesAdded = _getStreamProviderFor(EventType.VALUES_ADDED, ValuesAddedEvent.cast);
    _onValuesRemoved = _getStreamProviderFor(EventType.VALUES_REMOVED, ValuesRemovedEvent.cast);
    _onValuesSet = _getStreamProviderFor(EventType.VALUES_SET, ValuesSetEvent.cast);
  }

  dynamic _toJs(E e) => _translator == null ? e : _translator.toJs(e);
  E _fromJs(dynamic value) => _translator == null ? value : _translator.fromJs(value);

  @generate /*@override*/ int get length => null;

  /*@override*/ E operator [](int index) {
    if (index < 0 || index >= this.length) throw new RangeError.value(index);
    return _fromJs($unsafe.callMethod('get', [index]));
  }
  /*@override*/ void operator []=(int index, E value) {
    if (index < 0 || index >= this.length) throw new RangeError.value(index);
    $unsafe.callMethod('set', [index, _toJs(value)]);
  }

  @generate void clear() {}
  /// Deprecated : use `xxx[index]` instead
  @deprecated E get(int index) => this[index];
  void insert(int index, E value) { $unsafe.callMethod('insert', [index, _toJs(value)]); }
  int push(E value) => $unsafe.callMethod('push', [_toJs(value)]);
  @generate IndexReference registerReference(int index, bool canBeDeleted) {}
  @generate void remove(int index) {}
  @generate void removeRange(int startIndex, int endIndex) {}
  bool removeValue(E value) => $unsafe.callMethod('removeValue', [_toJs(value)]);
  /// Deprecated : use `xxx[index] = value` instead
  @deprecated void set(int index, E value) { $unsafe.callMethod('set', [index, _toJs(value)]); }

  List<E> asArray() => jsw.TypedJsArray.cast($unsafe.callMethod('asArray'), _translator);
  int indexOf(E value, [Comparator<E> comparator]) {
    if (comparator != null) {
      return $unsafe.callMethod('indexOf', [_toJs(value), (a, b) => comparator(_fromJs(a), _fromJs(b))]);
    } else {
      return $unsafe.callMethod('indexOf', [_toJs(value)]);
    }
  }
  void insertAll(int index, List<E> values) { $unsafe.callMethod('insertAll', [index, values is js.Serializable<js.JsObject> ? values : js.jsify(values.map(_toJs))]); }
  int lastIndexOf(E value, [Comparator comparator]) {
    if (comparator != null) {
      return $unsafe.callMethod('lastIndexOf', [_toJs(value), (a, b) => comparator(_fromJs(a), _fromJs(b))]);
    } else {
      return $unsafe.callMethod('lastIndexOf', [_toJs(value)]);
    }
  }
  void pushAll(List<E> values) { $unsafe.callMethod('pushAll', [values is js.Serializable<js.JsObject> ? values : js.jsify(values.map(_toJs))]); }
  void replaceRange(int index, List<E> values) { $unsafe.callMethod('replaceRange', [index, values is js.Serializable<js.JsObject> ? values : js.jsify(values.map(_toJs))]); }

  Stream<ValuesAddedEvent> get onValuesAdded => _onValuesAdded.stream;
  Stream<ValuesRemovedEvent> get onValuesRemoved => _onValuesRemoved.stream;
  Stream<ValuesSetEvent> get onValuesSet => _onValuesSet.stream;
}
