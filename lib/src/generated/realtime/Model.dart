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
  static Model $wrap(js.JsObject jsObject) => jsObject == null ? null : new Model.fromJsObject(jsObject);
  jsw.SubscribeStreamProvider<UndoRedoStateChangedEvent> _onUndoRedoStateChanged;

  Model.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject) {
    _onUndoRedoStateChanged = _getStreamProviderFor(EventType.UNDO_REDO_STATE_CHANGED, UndoRedoStateChangedEvent.$wrap);
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
  CollaborativeMap get root => CollaborativeMap.$wrap($unsafe.callMethod('getRoot'), unwrap: jsw.mayUnwrap);
  bool get isInitialized => $unsafe.callMethod('isInitialized');

  void beginCompoundOperation([String name]) {
    $unsafe.callMethod('beginCompoundOperation', [name]);
  }
  CollaborativeObject create(dynamic /*function(*)|string*/ ref, [List args = const []]) {
    final params = [ref]..addAll(args);
    return CollaborativeObject.$wrap($unsafe['create'].apply($unsafe, jsw.jsify(params)));
  }
  CollaborativeList createList([List initialValue]) => CollaborativeList.$wrap($unsafe.callMethod('createList', [jsw.jsify(initialValue)]));
  CollaborativeMap createMap([Map initialValue]) => CollaborativeMap.$wrap($unsafe.callMethod('createMap', [jsw.jsify(initialValue)]), unwrap: jsw.mayUnwrap);
  CollaborativeString createString([String initialValue]) => CollaborativeString.$wrap($unsafe.callMethod('createString', [initialValue]));

  void undo() {
    $unsafe.callMethod('undo');
  }
  void redo() {
    $unsafe.callMethod('redo');
  }

  Stream<UndoRedoStateChangedEvent> get onUndoRedoStateChanged => _onUndoRedoStateChanged.stream;
}
