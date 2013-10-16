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

class EventTarget extends jsw.TypedJsObject {
  static EventTarget cast(js.JsObject jsObject) => jsObject == null ? null : new EventTarget.fromJsObject(jsObject);
  EventTarget.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject);

  void _addEventListener(EventType type, dynamic /*Function|Object*/ handler, [bool capture]) => $unsafe.callMethod('addEventListener', [type, handler, capture]);
  void _removeEventListener(EventType type, dynamic /*Function|Object*/ handler, [bool capture]) => $unsafe.callMethod('removeEventListener', [type, handler, capture]);

  jsw.SubscribeStreamProvider _getStreamProviderFor(EventType eventType, [transformEvent(e)]) {
    js.Callback handler;
    return new jsw.SubscribeStreamProvider(
    subscribe: (EventSink eventSink) {
      handler = new js.Callback((e) {
        eventSink.add(transformEvent == null ? e : transformEvent(e));
      });
      _addEventListener(eventType, handler);
    },
     unsubscribe: (EventSink eventSink) {
      _removeEventListener(eventType, handler);
    }
    );
  }
}
