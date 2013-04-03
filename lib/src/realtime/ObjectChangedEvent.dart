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

class ObjectChangedEvent extends BaseModelEvent {
  static ObjectChangedEvent cast(js.Proxy proxy) => proxy == null ? null : new ObjectChangedEvent.fromProxy(proxy);

  ObjectChangedEvent.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  List<BaseModelEvent> get events => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe.events, BaseModelEvent.cast);

  set events(List<BaseModelEvent> events) => $unsafe.events = events is js.Serializable<js.Proxy> ? events : js.array(events);
}
