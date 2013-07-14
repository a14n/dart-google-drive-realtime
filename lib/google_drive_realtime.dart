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
import 'dart:collection';

import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as jsw;
import 'package:meta/meta.dart';

import 'src/generated/utils.dart';

part 'src/generated/realtime/BaseModelEvent.dart';
part 'src/generated/realtime/CollaborativeList.dart';
part 'src/generated/realtime/CollaborativeMap.dart';
part 'src/generated/realtime/CollaborativeObject.dart';
part 'src/generated/realtime/CollaborativeString.dart';
part 'src/generated/realtime/Collaborator.dart';
part 'src/generated/realtime/CollaboratorJoinedEvent.dart';
part 'src/generated/realtime/CollaboratorLeftEvent.dart';
part 'src/generated/realtime/Document.dart';
part 'src/generated/realtime/DocumentClosedError.dart';
part 'src/generated/realtime/DocumentSaveStateChangedEvent.dart';
part 'src/generated/realtime/Error.dart';
part 'src/generated/realtime/EventTarget.dart';
part 'src/generated/realtime/IndexReference.dart';
part 'src/generated/realtime/Model.dart';
part 'src/generated/realtime/ObjectChangedEvent.dart';
part 'src/generated/realtime/ReferenceShiftedEvent.dart';
part 'src/generated/realtime/TextDeletedEvent.dart';
part 'src/generated/realtime/TextInsertedEvent.dart';
part 'src/generated/realtime/ValueChangedEvent.dart';
part 'src/generated/realtime/ValuesAddedEvent.dart';
part 'src/generated/realtime/ValuesRemovedEvent.dart';
part 'src/generated/realtime/ValuesSetEvent.dart';
part 'src/generated/realtime/UndoRedoStateChangedEvent.dart';
part 'src/generated/realtime/error_type.dart';
part 'src/generated/realtime/event_type.dart';

// js.Proxy for "gapi.drive.realtime"
final realtime = js.retain(js.context['gapi']['drive']['realtime']);

String get token => realtime['getToken']();

Future<Document> load(String docId, [void initializerFn(Model model), void errorFn(Error error)]) {
  final completer = new Completer();
  realtime.load(docId,
      new js.Callback.once((js.Proxy p) => completer.complete(Document.cast(p))),
      initializerFn == null ? null : new js.Callback.once((js.Proxy p) => initializerFn(Model.cast(p))),
      errorFn == null ? null : new js.Callback.once((js.Proxy p) => errorFn(Error.cast(p)))
  );
  return completer.future;
}




