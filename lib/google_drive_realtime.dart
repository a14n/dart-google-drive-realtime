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

library google_drive_realtime;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as jsw;
import 'package:meta/meta.dart';

import 'src/utils.dart';

part 'src/realtime/BaseModelEvent.dart';
part 'src/realtime/CollaborativeList.dart';
part 'src/realtime/CollaborativeMap.dart';
part 'src/realtime/CollaborativeObject.dart';
part 'src/realtime/CollaborativeString.dart';
part 'src/realtime/Collaborator.dart';
part 'src/realtime/CollaboratorJoinedEvent.dart';
part 'src/realtime/CollaboratorLeftEvent.dart';
part 'src/realtime/Document.dart';
part 'src/realtime/DocumentClosedError.dart';
part 'src/realtime/DocumentSaveStateChangedEvent.dart';
part 'src/realtime/Error.dart';
part 'src/realtime/EventTarget.dart';
part 'src/realtime/IndexReference.dart';
part 'src/realtime/Model.dart';
part 'src/realtime/ObjectChangedEvent.dart';
part 'src/realtime/ReferenceShiftedEvent.dart';
part 'src/realtime/TextDeletedEvent.dart';
part 'src/realtime/TextInsertedEvent.dart';
part 'src/realtime/ValueChangedEvent.dart';
part 'src/realtime/ValuesAddedEvent.dart';
part 'src/realtime/ValuesRemovedEvent.dart';
part 'src/realtime/ValuesSetEvent.dart';
part 'src/realtime/error_type.dart';
part 'src/realtime/event_type.dart';

// js.Proxy for "gapi.drive.realtime"
final realtime = js.retain(js.context.gapi.drive.realtime);

String get token => realtime.getToken();

Future<Document> load(String docId, [void initializerFn(Model model), void errorFn(Error error)]) {
  final completer = new Completer();
  realtime.load(docId,
      new js.Callback.once((js.Proxy p) => completer.complete(Document.cast(p))),
      initializerFn == null ? null : new js.Callback.once((js.Proxy p) => initializerFn(Model.cast(p))),
      errorFn == null ? null : new js.Callback.once((js.Proxy p) => errorFn(Error.cast(p)))
  );
  return completer.future;
}




