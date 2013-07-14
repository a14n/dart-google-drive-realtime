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

class BaseModelEvent extends jsw.TypedProxy {
  static BaseModelEvent cast(js.Proxy proxy) => proxy == null ? null : new BaseModelEvent.fromProxy(proxy);
  BaseModelEvent.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);
  bool get bubbles => $unsafe['bubbles'];
  bool get isLocal => $unsafe['isLocal'];
  String get sessionId => $unsafe['sessionId'];
  String get type => $unsafe['type'];
  String get userId => $unsafe['userId'];
}
