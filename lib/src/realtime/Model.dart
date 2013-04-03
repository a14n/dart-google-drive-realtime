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

class Model extends jsw.TypedProxy {
  static Model cast(js.Proxy proxy) => proxy == null ? null : new Model.fromProxy(proxy);

  Model.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  bool get isReadOnly => $unsafe.isReadOnly;

  set isReadOnly(bool isReadOnly) => $unsafe.isReadOnly = isReadOnly;

  void beginCreationCompoundOperation() { $unsafe.beginCreationCompoundOperation(); }
  void endCompoundOperation() { $unsafe.endCompoundOperation(); }
  CollaborativeMap getRoot() => CollaborativeMap.cast($unsafe.getRoot());
  bool isInitialized() => $unsafe.isInitialized();

  void beginCompoundOperation([String name]) => $unsafe.beginCompoundOperation(name);
  CollaborativeObject create(dynamic/*function(*)|string*/ ref, List args) {
    final params = [ref]..addAll(args);
    $unsafe.create.apply($unsafe, js.array(params));
  }
  CollaborativeList createList([List initialValue]) => $unsafe.createList(initialValue is js.Serializable<js.Proxy> ? initialValue : js.array(initialValue));
  CollaborativeMap createMap([Map initialValue]) => $unsafe.createMap(initialValue is js.Serializable<js.Proxy> ? initialValue : js.map(initialValue));
  CollaborativeString createString([String initialValue]) => $unsafe.createString(initialValue);
}
