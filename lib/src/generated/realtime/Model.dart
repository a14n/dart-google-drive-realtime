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
  static Model cast(js.JsObject jsObject) => jsObject == null ? null : new Model.fromJsObject(jsObject);
  SubscribeStreamProvider<UndoRedoStateChangedEvent> _onUndoRedoStateChanged;

  Model.fromJsObject(js.JsObject jsObject) : super.fromJsObject(jsObject) {
    _onUndoRedoStateChanged = _getStreamProviderFor(EventType.UNDO_REDO_STATE_CHANGED, UndoRedoStateChangedEvent.cast);
  }

  bool get isReadOnly => $unsafe['isReadOnly'];
  bool get canUndo => $unsafe['canUndo'];
  bool get canRedo => $unsafe['canRedo'];

  void beginCreationCompoundOperation() {
    $unsafe.callMethod('beginCreationCompoundOperation');
  }
  void endCompoundOperation() {
    $unsafe.callMethod('endCompoundOperation');
  }
  CollaborativeMap get root => CollaborativeMap.cast($unsafe.callMethod('getRoot'));
  bool get isInitialized => $unsafe.callMethod('isInitialized');

  void beginCompoundOperation([String name]) {
    $unsafe.callMethod('beginCompoundOperation', [name]);
  }
  CollaborativeObject create(dynamic /*function(*)|string*/ ref, [List args = const []]) {
    final params = [ref]..addAll(args);
    return CollaborativeObject.cast($unsafe['create'].apply($unsafe, js.jsify(params)));
  }
  CollaborativeList createList([List initialValue]) => CollaborativeList.cast($unsafe.callMethod('createList', [initialValue == null ? null : initialValue is js.Serializable ? initialValue : js.jsify(initialValue)]));
  CollaborativeMap createMap([Map initialValue]) => CollaborativeMap.cast($unsafe.callMethod('createMap', [initialValue == null ? null : initialValue is js.Serializable ? initialValue : js.jsify(initialValue)]));
  CollaborativeString createString([String initialValue]) => CollaborativeString.cast($unsafe.callMethod('createString', [initialValue]));

  void undo() {
    $unsafe.callMethod('undo');
  }
  void redo() {
    $unsafe.callMethod('redo');
  }

  Stream<UndoRedoStateChangedEvent> get onUndoRedoStateChanged => _onUndoRedoStateChanged.stream;
}
