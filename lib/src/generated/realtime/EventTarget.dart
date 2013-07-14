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

class EventTarget extends jsw.TypedProxy {
  static EventTarget cast(js.Proxy proxy) => proxy == null ? null : new EventTarget.fromProxy(proxy);
  EventTarget.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  void _addEventListener(EventType type, dynamic/*Function|Object*/ handler, [bool capture]) => $unsafe.addEventListener(type, handler, capture);
  void _removeEventListener(EventType type, dynamic/*Function|Object*/ handler, [bool capture]) => $unsafe.removeEventListener(type, handler, capture);

  SubscribeStreamProvider _getStreamProviderFor(EventType eventType, [transformEvent(e)]) {
    js.Callback handler;
    // TODO remove jsFunction when https://github.com/dart-lang/js-interop/issues/95 is fixed
    js.FunctionProxy jsFunction;
    return new SubscribeStreamProvider(
        subscribe: (EventSink eventSink) {
          handler = new js.Callback.many((e) {
            eventSink.add(transformEvent == null ? e : transformEvent(e));
          });
          js.context['hackForJsInterop95'] = handler;
          jsFunction = js.context['hackForJsInterop95'];
          js.retain(jsFunction);
          js.deleteProperty(js.context, "hackForJsInterop95");
          _addEventListener(eventType, /*handler */ jsFunction);
        },
        unsubscribe: (EventSink eventSink) {
          _removeEventListener(eventType, /*handler */ jsFunction);
          js.release(jsFunction);
          handler.dispose();
        }
    );
  }
}
