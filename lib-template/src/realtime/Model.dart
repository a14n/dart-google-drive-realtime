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

@wrapper @skipConstructor abstract class Model extends EventTarget {
  static Model $wrap(js.JsObject jsObject) => null;

  jsw.SubscribeStreamProvider<UndoRedoStateChangedEvent> _onUndoRedoStateChanged;

  Model.fromJsObject(js.JsObject jsObject) : super.fromJsObject(jsObject) {
    _onUndoRedoStateChanged = _getStreamProviderFor(EventType.UNDO_REDO_STATE_CHANGED, UndoRedoStateChangedEvent.$wrap);
  }

  bool get isReadOnly;
  bool get canUndo;
  bool get canRedo;

  void beginCreationCompoundOperation();
  void endCompoundOperation();
  CollaborativeMap get root => CollaborativeMap.$wrap($unsafe.callMethod('getRoot'), unwrap: jsw.mayUnwrap);
  bool get isInitialized => $unsafe.callMethod('isInitialized');

  void beginCompoundOperation([String name]);
  CollaborativeObject create(dynamic/*function(*)|string*/ ref, [List args = const []]) {
    final params = [ref]..addAll(args);
    return CollaborativeObject.$wrap($unsafe['create'].apply($unsafe, jsw.jsify(params)));
  }
  CollaborativeList createList([List initialValue]);
  CollaborativeMap createMap([Map initialValue]) => CollaborativeMap.$wrap($unsafe.callMethod('createMap', [jsw.jsify(initialValue)]), unwrap: jsw.mayUnwrap);
  CollaborativeString createString([String initialValue]);

  void undo();
  void redo();

  Stream<UndoRedoStateChangedEvent> get onUndoRedoStateChanged => _onUndoRedoStateChanged.stream;
}
