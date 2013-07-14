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

class CollaborativeString extends CollaborativeObject {
  static CollaborativeString cast(js.Proxy proxy) => proxy == null ? null : new CollaborativeString.fromProxy(proxy);
  SubscribeStreamProvider<TextInsertedEvent> _onTextInserted;
  SubscribeStreamProvider<TextDeletedEvent> _onTextDeleted;

  CollaborativeString.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onTextInserted = _getStreamProviderFor(EventType.TEXT_INSERTED, TextInsertedEvent.cast);
    _onTextDeleted = _getStreamProviderFor(EventType.TEXT_DELETED, TextDeletedEvent.cast);
  }

  int get length => $unsafe['length'];

  void append(String text) { $unsafe.append(text); }
  String get text => $unsafe.getText();
  void insertString(int index, String text) { $unsafe.insertString(index, text); }
  IndexReference registerReference(int index, bool canBeDeleted) => IndexReference.cast($unsafe.registerReference(index, canBeDeleted));
  void removeRange(int startIndex, int endIndex) { $unsafe.removeRange(startIndex, endIndex); }
  void set text(String text) { $unsafe.setText(text); }

  Stream<TextInsertedEvent> get onTextInserted => _onTextInserted.stream;
  Stream<TextDeletedEvent> get onTextDeleted => _onTextDeleted.stream;
}
