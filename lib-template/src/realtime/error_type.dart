// Copyright (c) 2012, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of google_drive_realtime;

class ErrorType extends jsw.IsEnum<String> {
  static final _FINDER = new jsw.EnumFinder<String, ErrorType>([CLIENT_ERROR, CONCURRENT_CREATION, FORBIDDEN, INVALID_COMPOUND_OPERATION, NOT_FOUND, SERVER_ERROR, TOKEN_REFRESH_REQUIRED]);
  static ErrorType $wrap(o) => _FINDER.find(o);

  static final CLIENT_ERROR = new ErrorType._(realtime['ErrorType']['CLIENT_ERROR']);
  static final CONCURRENT_CREATION = new ErrorType._(realtime['ErrorType']['CONCURRENT_CREATION']);
  static final FORBIDDEN = new ErrorType._(realtime['ErrorType']['FORBIDDEN']);
  static final INVALID_COMPOUND_OPERATION = new ErrorType._(realtime['ErrorType']['INVALID_COMPOUND_OPERATION']);
  static final NOT_FOUND = new ErrorType._(realtime['ErrorType']['NOT_FOUND']);
  static final SERVER_ERROR = new ErrorType._(realtime['ErrorType']['SERVER_ERROR']);
  static final TOKEN_REFRESH_REQUIRED = new ErrorType._(realtime['ErrorType']['TOKEN_REFRESH_REQUIRED']);

  ErrorType._(String value) : super(value);
}
