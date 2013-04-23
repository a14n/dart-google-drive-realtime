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

class CollaborativeList extends CollaborativeObject {
  static CollaborativeList cast(js.Proxy proxy) => proxy == null ? null : new CollaborativeList.fromProxy(proxy);

  Stream<ValuesAddedEvent> _onValuesAdded;
  Stream<ValuesRemovedEvent> _onValuesRemoved;
  Stream<ValuesSetEvent> _onValuesSet;

  CollaborativeList.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onValuesAdded = _getStreamFor(EventType.VALUES_ADDED, ValuesAddedEvent.cast);
    _onValuesRemoved = _getStreamFor(EventType.VALUES_REMOVED, ValuesRemovedEvent.cast);
    _onValuesSet = _getStreamFor(EventType.VALUES_SET, ValuesSetEvent.cast);
  }

  int get length => $unsafe['length'];

  void clear() { $unsafe.clear(); }
  dynamic get(int index) => $unsafe.get(index);
  void insert(int index, dynamic value) { $unsafe.insert(index, value); }
  int push(dynamic value) => $unsafe.push(value);
  IndexReference registerReference(int index, bool canBeDeleted) => IndexReference.cast($unsafe.registerReference(index, canBeDeleted));
  void remove(int index) { $unsafe.remove(index); }
  void removeRange(int startIndex, int endIndex) { $unsafe.removeRange(startIndex, endIndex); }
  bool removeValue(dynamic value) => $unsafe.removeValue(value);
  void set(int index, dynamic value) { $unsafe.set(index, value); }

  List asArray() => jsw.JsArrayToListAdapter.cast($unsafe.asArray());
  int indexOf(dynamic value, [Comparator comparator]) {
    js.Callback comparatorCallback = null;
    if (comparator != null) {
      comparatorCallback = new js.Callback.many(comparator);
    }
    try {
      return $unsafe.indexOf(value, comparatorCallback);
    } finally {
      if (comparatorCallback != null) {
        comparatorCallback.dispose();
      }
    }
  }
  void insertAll(int index, List values) { $unsafe.insertAll(index, values is js.Serializable<js.Proxy> ? values : js.array(values)); }
  int lastIndexOf(dynamic value, [Comparator comparator]) {
    js.Callback comparatorCallback = null;
    if (comparator != null) {
      comparatorCallback = new js.Callback.many(comparator);
    }
    try {
      return $unsafe.lastIndexOf(value, comparatorCallback);
    } finally {
      if (comparatorCallback != null) {
        comparatorCallback.dispose();
      }
    }
  }
  void pushAll(List values) { $unsafe.pushAll(values is js.Serializable<js.Proxy> ? values : js.array(values)); }
  void replaceRange(int index, List values) { $unsafe.replaceRange(index, values is js.Serializable<js.Proxy> ? values : js.array(values)); }

  Stream<ValuesAddedEvent> get onValuesAdded => _onValuesAdded;
  Stream<ValuesRemovedEvent> get onValuesRemoved => _onValuesRemoved;
  Stream<ValuesSetEvent> get onValuesSet => _onValuesSet;
}
