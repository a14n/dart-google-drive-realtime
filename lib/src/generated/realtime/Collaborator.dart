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

class Collaborator extends jsw.TypedJsObject {
  static Collaborator cast(js.JsObject jsObject) => jsObject == null ? null : new Collaborator.fromJsObject(jsObject);
  Collaborator.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject);
  String get color => $unsafe['color'];
  String get displayName => $unsafe['displayName'];
  bool get isAnonymous => $unsafe['isAnonymous'];
  bool get isMe => $unsafe['isMe'];
  String get photoUrl => $unsafe['photoUrl'];
  String get sessionId => $unsafe['sessionId'];
  String get userId => $unsafe['userId'];
}
