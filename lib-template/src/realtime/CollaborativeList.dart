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
@wrapper @skipWrap @skipConstructor class CollaborativeList<E> extends CollaborativeObject /* with ListMixin<E> */ {
  static CollaborativeList $wrap(js.JsObject proxy, {wrap(js), unwrap(dart)}) => proxy == null ? null : new CollaborativeList.fromJsObject(proxy, wrap: wrap, unwrap: unwrap);
  static CollaborativeList $wrapSerializables(js.JsObject jsObject, wrap(js)) => jsObject == null ? null : new CollaborativeList.fromJsObject(jsObject, wrap: wrap, unwrap: jsw.Serializable.$unwrap);

  final jsw.Mapper<E, dynamic> _unwrap;
  final jsw.Mapper<dynamic, E> _wrap;

  jsw.SubscribeStreamProvider<ValuesAddedEvent> _onValuesAdded;
  jsw.SubscribeStreamProvider<ValuesRemovedEvent> _onValuesRemoved;
  jsw.SubscribeStreamProvider<ValuesSetEvent> _onValuesSet;

  CollaborativeList.fromJsObject(js.JsObject jsObject, {jsw.Mapper<dynamic, E> wrap, jsw.Mapper<E, dynamic> unwrap})
      : _wrap = ((e) => wrap == null ? e : wrap(e)),
        _unwrap = ((e) => unwrap == null ? e : unwrap(e)),
        super.fromJsObject(jsObject) {
          _initStreams();
        }

  void _initStreams() {
    _onValuesAdded = _getStreamProviderFor(EventType.VALUES_ADDED, ValuesAddedEvent.$wrap);
    _onValuesRemoved = _getStreamProviderFor(EventType.VALUES_REMOVED, ValuesRemovedEvent.$wrap);
    _onValuesSet = _getStreamProviderFor(EventType.VALUES_SET, ValuesSetEvent.$wrap);
  }

  @generate /*@override*/ int get length => null;
  @generate set length(int l) => null;

  /*@override*/ E operator [](int index) {
    if (index < 0 || index >= this.length) throw new RangeError.value(index);
    return _wrap($unsafe.callMethod('get', [index]));
  }
  /*@override*/ void operator []=(int index, E value) {
    if (index < 0 || index >= this.length) throw new RangeError.value(index);
    $unsafe.callMethod('set', [index, _unwrap(value)]);
  }

  @generate void clear() {}
  /// Deprecated : use `xxx[index]` instead
  @deprecated E get(int index) => this[index];
  void insert(int index, E value) { $unsafe.callMethod('insert', [index, _unwrap(value)]); }
  int push(E value) => $unsafe.callMethod('push', [_unwrap(value)]);
  @generate IndexReference registerReference(int index, bool canBeDeleted) => null;
  @generate void remove(int index) {}
  @generate void removeRange(int startIndex, int endIndex) {}
  bool removeValue(E value) => $unsafe.callMethod('removeValue', [_unwrap(value)]);
  /// Deprecated : use `xxx[index] = value` instead
  @deprecated void set(int index, E value) { $unsafe.callMethod('set', [index, _unwrap(value)]); }

  List<E> asArray() => jsw.TypedJsArray.$wrap($unsafe.callMethod('asArray'), wrap: _wrap, unwrap: _unwrap);
  int indexOf(E value, [Comparator<E> comparator]) {
    if (comparator != null) {
      return $unsafe.callMethod('indexOf', [_unwrap(value), (a, b) => comparator(_wrap(a), _wrap(b))]);
    } else {
      return $unsafe.callMethod('indexOf', [_unwrap(value)]);
    }
  }
  void insertAll(int index, List<E> values) { $unsafe.callMethod('insertAll', [index, values == null ? null : (values is jsw.Serializable ? (values as jsw.Serializable).$unsafe : jsw.jsify(values.map(_unwrap)))]); }
  int lastIndexOf(E value, [Comparator comparator]) {
    if (comparator != null) {
      return $unsafe.callMethod('lastIndexOf', [_unwrap(value), (a, b) => comparator(_wrap(a), _wrap(b))]);
    } else {
      return $unsafe.callMethod('lastIndexOf', [_unwrap(value)]);
    }
  }
  void pushAll(List<E> values) { $unsafe.callMethod('pushAll', [values == null ? null : (values is jsw.Serializable ? (values as jsw.Serializable).$unsafe : jsw.jsify(values.map(_unwrap)))]); }
  void replaceRange(int index, List<E> values) { $unsafe.callMethod('replaceRange', [index, values == null ? null : (values is jsw.Serializable ? (values as jsw.Serializable).$unsafe : jsw.jsify(values.map(_unwrap)))]); }

  Stream<ValuesAddedEvent> get onValuesAdded => _onValuesAdded.stream;
  Stream<ValuesRemovedEvent> get onValuesRemoved => _onValuesRemoved.stream;
  Stream<ValuesSetEvent> get onValuesSet => _onValuesSet.stream;
}
