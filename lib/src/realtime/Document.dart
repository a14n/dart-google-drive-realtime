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

class Document extends EventTarget {
  static Document cast(js.Proxy proxy) => proxy == null ? null : new Document.fromProxy(proxy);

  SubscribeStreamProvider<CollaboratorLeftEvent> _onCollaboratorLeft;
  SubscribeStreamProvider<CollaboratorJoinedEvent> _onCollaboratorJoined;
  SubscribeStreamProvider<DocumentSaveStateChangedEvent> _onDocumentSaveStateChanged;

  Document.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onCollaboratorLeft = _getStreamProviderFor(EventType.COLLABORATOR_LEFT, CollaboratorLeftEvent.cast);
    _onCollaboratorJoined = _getStreamProviderFor(EventType.COLLABORATOR_JOINED, CollaboratorJoinedEvent.cast);
    _onDocumentSaveStateChanged = _getStreamProviderFor(EventType.DOCUMENT_SAVE_STATE_CHANGED, DocumentSaveStateChangedEvent.cast);
  }

  void close() { $unsafe.close(); }
  List<Collaborator> get collaborators => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe.getCollaborators(), Collaborator.cast);
  Model get model => Model.cast($unsafe.getModel());

  Stream<CollaboratorLeftEvent> get onCollaboratorLeft => _onCollaboratorLeft.stream;
  Stream<CollaboratorJoinedEvent> get onCollaboratorJoined => _onCollaboratorJoined.stream;
  Stream<DocumentSaveStateChangedEvent> get onDocumentSaveStateChanged => _onDocumentSaveStateChanged.stream;
}
