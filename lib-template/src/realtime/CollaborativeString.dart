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

@wrapper @skipConstructor abstract class CollaborativeString extends CollaborativeObject {
  SubscribeStreamProvider<TextInsertedEvent> _onTextInserted;
  SubscribeStreamProvider<TextDeletedEvent> _onTextDeleted;

  CollaborativeString.fromJsObject(js.JsObject jsObject) : super.fromJsObject(jsObject) {
    _onTextInserted = _getStreamProviderFor(EventType.TEXT_INSERTED, TextInsertedEvent.cast);
    _onTextDeleted = _getStreamProviderFor(EventType.TEXT_DELETED, TextDeletedEvent.cast);
  }

  int get length;

  void append(String text);
  @forMethods String get text;
  void insertString(int index, String text);
  IndexReference registerReference(int index, bool canBeDeleted);
  void removeRange(int startIndex, int endIndex);
  @forMethods void set text(String text);

  Stream<TextInsertedEvent> get onTextInserted => _onTextInserted.stream;
  Stream<TextDeletedEvent> get onTextDeleted => _onTextDeleted.stream;
}
