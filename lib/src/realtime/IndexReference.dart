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

class IndexReference extends CollaborativeObject {
  static IndexReference cast(js.Proxy proxy) => proxy == null ? null : new IndexReference.fromProxy(proxy);

  Stream<ReferenceShiftedEvent> _onReferenceShifted;

  IndexReference.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) {
    _onReferenceShifted = _getStreamFor(EventType.REFERENCE_SHIFTED, ReferenceShiftedEvent.cast);
  }

  bool get canBeDeleted => $unsafe['canBeDeleted'];
  int get index => $unsafe['index'];
  CollaborativeObject get referencedObject => CollaborativeObject.cast($unsafe['referencedObject']);

  Stream<ReferenceShiftedEvent> get onReferenceShifted => _onReferenceShifted;
}
