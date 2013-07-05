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

class Model extends EventTarget {
  static Model cast(js.Proxy proxy) => proxy == null ? null : new Model.fromProxy(proxy);

  SubscribeStreamProvider<UndoRedoStateChangedEvent> _onUndoRedoStateChanged;

  Model.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onUndoRedoStateChanged = _getStreamProviderFor(EventType.UNDO_REDO_STATE_CHANGED, UndoRedoStateChangedEvent.cast);
  }

  bool get isReadOnly => $unsafe['isReadOnly'];

  void beginCreationCompoundOperation() { $unsafe.beginCreationCompoundOperation(); }
  void endCompoundOperation() { $unsafe.endCompoundOperation(); }
  CollaborativeMap get root => CollaborativeMap.cast($unsafe.getRoot());
  bool get isInitialized => $unsafe.isInitialized();

  void beginCompoundOperation([String name]) => $unsafe.beginCompoundOperation(name);
  CollaborativeObject create(dynamic/*function(*)|string*/ ref, [List args = const []]) {
    final params = [ref]..addAll(args);
    return CollaborativeObject.cast($unsafe['create'].apply($unsafe, js.array(params)));
  }
  CollaborativeList createList([List initialValue]) => CollaborativeList.cast($unsafe.createList(initialValue == null ? null : initialValue is js.Serializable<js.Proxy> ? initialValue : js.array(initialValue)));
  CollaborativeMap createMap([Map initialValue]) => CollaborativeMap.cast($unsafe.createMap(initialValue == null ? null : initialValue is js.Serializable<js.Proxy> ? initialValue : js.map(initialValue)));
  CollaborativeString createString([String initialValue]) => CollaborativeString.cast($unsafe.createString(initialValue));

  bool get canUndo => $unsafe.canUndo;
  bool get canRedo => $unsafe.canRedo;
  void undo() { $unsafe.undo(); }
  void redo() { $unsafe.redo(); }

  Stream<UndoRedoStateChangedEvent> get onUndoRedoStateChanged => _onUndoRedoStateChanged.stream;
}
