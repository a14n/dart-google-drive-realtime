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

class CollaborativeMap<V> extends CollaborativeObject implements Map<String, V> {
  static CollaborativeMap $wrap(js.JsObject jsObject, {wrap(js), unwrap(dart)}) => jsObject == null ? null : new CollaborativeMap.fromJsObject(jsObject, wrap: wrap, unwrap: unwrap);

  static CollaborativeMap $wrapSerializables(js.JsObject jsObject, wrap(js)) => jsObject == null ? null : new CollaborativeMap.fromJsObject(jsObject, wrap: wrap, unwrap: jsw.Serializable.$unwrap);

  final jsw.Mapper<V, dynamic> _unwrap;
  final jsw.Mapper<dynamic, V> _wrap;

  jsw.SubscribeStreamProvider<ValueChangedEvent> _onValueChanged;

  CollaborativeMap.fromJsObject(js.JsObject jsObject, {jsw.Mapper<dynamic, V> wrap, jsw.Mapper<V, dynamic> unwrap})
      : _wrap = ((e) => wrap == null ? e : wrap(e)),
        _unwrap = ((e) => unwrap == null ? e : unwrap(e)),
        super.fromJsObject(jsObject) {
    _onValueChanged = _getStreamProviderFor(EventType.VALUE_CHANGED, ValueChangedEvent.$wrap);
  }

  @override int get length => $unsafe['size'];
  /// deprecated : use `xxx.length`
  @deprecated int get size => length;

  @override V operator [](String key) => _wrap($unsafe.callMethod('get', [key]));
  @override void operator []=(String key, V value) {
    $unsafe.callMethod('set', [key, _unwrap(value)]);
  }

  void clear() { $unsafe.callMethod('clear'); }
  @override V remove(String key) => _wrap($unsafe.callMethod('delete', [key]));
  /// deprecated : use `xxx.remove(key)`
  @deprecated V delete(String key) => remove(key);
  /// deprecated : use `xxx[key]`
  @deprecated V get(String key) => this[key];
  @override bool containsKey(String key) => $unsafe.callMethod('has', [key]);
  /// deprecated : use `xxx.containsKey(key)`
  @deprecated bool has(String key) => containsKey(key);
  @override bool get isEmpty => $unsafe.callMethod('isEmpty');
  List<Pair<V>> get items => jsw.TypedJsArray.$wrapSerializables($unsafe.callMethod('items'), (e) => Pair.$wrap(e, wrap: _wrap, unwrap: _unwrap));
  @override List<String> get keys => jsw.TypedJsArray.$wrap($unsafe.callMethod('keys'));
  /// deprecated : use `xxx[key] = value`
  @deprecated V set(String key, V value) => _wrap($unsafe.callMethod('set', [key, _unwrap(value)]));
  @override List<V> get values => jsw.TypedJsArray.$wrap($unsafe.callMethod('values'), wrap: _wrap, unwrap: _unwrap);
  @override bool get isNotEmpty => !isEmpty;
  @override void addAll(Map<String, V> other) {
    if (other != null) {
      other.forEach((k,v) => this[k] = v);
    }
  }

  // use Maps to implement functions
  @override bool containsValue(V value) => Maps.containsValue(this, value);
  @override V putIfAbsent(String key, V ifAbsent()) => Maps.putIfAbsent(this, key, ifAbsent);
  @override void forEach(void f(String key, V value)) => Maps.forEach(this, f);

  Stream<ValueChangedEvent> get onValueChanged => _onValueChanged.stream;
}

class Pair<V> extends jsw.TypedJsObject {
  static Pair $wrap(js.JsObject jsObject, {wrap(js), unwrap(dart)}) => jsObject == null ? null : new Pair.fromJsObject(jsObject, wrap: wrap, unwrap: unwrap);

  final jsw.Mapper<V, dynamic> _unwrap;
  final jsw.Mapper<dynamic, V> _wrap;

  Pair.fromJsObject(js.JsObject jsObject, {jsw.Mapper<dynamic, V> wrap, jsw.Mapper<V, dynamic> unwrap})
      : _wrap = ((e) => wrap == null ? e : wrap(e)),
        _unwrap = ((e) => unwrap == null ? e : unwrap(e)),
        super.fromJsObject(jsObject);

  set key(String key) => $unsafe[0] = key;
  String get key => $unsafe[0];
  set value(V value) => $unsafe[1] = _unwrap(value);
  V get value => _wrap($unsafe[1]);
}