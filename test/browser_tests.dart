import 'dart:async';
import 'dart:js' as js;

import 'package:google_drive_realtime/google_drive_realtime.dart' as rt;
import 'package:js_wrapping/js_wrapping.dart' as jsw;
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
var a;
initializeModel(js.JsObject modelJsObject) {
  var model = rt.Model.$wrap(modelJsObject);
  model.root['text'] = model.createString('Hello Realtime World!');
  model.root['list'] = model.createList();
  model.root['map'] = model.createMap();
}

onFileLoaded(docJsObject) {
  var doc = rt.Document.$wrap(docJsObject);

  useHtmlConfiguration();

  test("initial value", () {
    expect(rt.CollaborativeString.$wrap(doc.model.root['text']).text, 'Hello Realtime World!');
  });

  group('Undo', () {
    test("start undo state", () {
      expect(doc.model.canUndo, false);
      expect(doc.model.canRedo, false);
    });
    test('undo state after change', () {
      rt.CollaborativeString.$wrap(doc.model.root['text']).text = 'redid';
      expect(doc.model.canUndo, true);
      expect(doc.model.canRedo, false);
    });
    test('undo state after undo', () {
      doc.model.undo();
      expect(doc.model.canUndo, false);
      expect(doc.model.canRedo, true);
    });
    test('string state after undo', () {
      expect(rt.CollaborativeString.$wrap(doc.model.root['text']).text, 'Hello Realtime World!');
    });
    test('string state after redo and event/model state matching', () {
      StreamSubscription ssUndo;
      ssUndo = doc.model.onUndoRedoStateChanged.listen(expectAsync1((event) {
        // test that event properties match model
        expect(doc.model.canUndo, event.canUndo);
        expect(doc.model.canRedo, event.canRedo);
        // test that undo/redo state is what we expect
        expect(doc.model.canUndo, true);
        expect(doc.model.canRedo, false);
        ssUndo.cancel();
      }));
      doc.model.redo();
      expect(rt.CollaborativeString.$wrap(doc.model.root['text']).text, 'redid');
      doc.model.undo();
    });
  });

  group('CollaborativeString', () {
    var string = rt.CollaborativeString.$wrap(doc.model.root['text']);
    setUp((){
      string.text = 'unittest';
    });
    test('get length', () {
      expect(string.length, 8);
    });
    test('append(String text)', () {
      string.append(' append');
      expect(string.text, 'unittest append');
    });
    test('get text', () {
      expect(string.text, 'unittest');
    });
    test('insertString(int index, String text)', () {
      string.insertString(4, ' append ');
      expect(string.text, 'unit append test');
    });
    test('removeRange(int startIndex, int endIndex)', () {
      string.removeRange(4, 6);
      expect(string.text, 'unitst');
    });
    test('set text(String text)', () {
      string.text = 'newValue';
      expect(string.text, 'newValue');
    });
    test('onTextInserted', () {
      StreamSubscription ssInsert;
      StreamSubscription ssDelete;
      ssInsert = string.onTextInserted.listen(expectAsync1((rt.TextInsertedEvent e) {
        expect(e.index, 4);
        expect(e.text, ' append ');
        ssInsert.cancel();
        ssDelete.cancel();
      }));
      ssDelete = string.onTextDeleted.listen(expectAsync1((rt.TextDeletedEvent e) {
        fail("delete should not be call");
      }, count: 0));
      string.insertString(4, ' append ');
    });
    test('onTextDeleted', () {
      StreamSubscription ssInsert;
      StreamSubscription ssDelete;
      ssInsert = string.onTextInserted.listen(expectAsync1((rt.TextInsertedEvent e) {
        fail("insert should not be call");
      }, count: 0));
      ssDelete = string.onTextDeleted.listen(expectAsync1((rt.TextDeletedEvent e) {
        expect(e.index, 4);
        expect(e.text, 'te');
        ssInsert.cancel();
        ssDelete.cancel();
      }));
      string.removeRange(4, 6);
    });
  });

  group('CollaborativeList', () {
    var list = rt.CollaborativeList.$wrap(doc.model.root['list']);
    setUp((){
      list.clear();
      list.push('s1');
    });
    test('get length', () {
      expect(list.length, 1);
    });
    test('operator [](int index)', () {
      expect(list[0], 's1');
      expect(() => list[-1], throws);
      expect(() => list[1], throws);
    });
    test('operator []=(int index, E value)', () {
      list[0] = 'new s1';
      expect(list[0], 'new s1');
    });
    test('clear()', () {
      list.clear();
      expect(list.length, 0);
    });
    test('insert(int index, E value)', () {
      list.insert(0, 's0');
      expect(list.length, 2);
      expect(list[0], 's0');
      expect(list[1], 's1');
    });
    test('push(E value)', () {
      expect(list.push('s2'), 2);
      expect(list.length, 2);
      expect(list[0], 's1');
      expect(list[1], 's2');
    });
    test('onValuesAdded', () {
      StreamSubscription ss;
      ss = list.onValuesAdded.listen(expectAsync1((rt.ValuesAddedEvent e) {
        expect(e.index, 1);
        expect(e.values, ['s2']);
        ss.cancel();
      }));
      list.push('s2');
    });
    test('onValuesRemoved', () {
      StreamSubscription ss;
      ss = list.onValuesRemoved.listen(expectAsync1((rt.ValuesRemovedEvent e) {
        expect(e.index, 0);
        expect(e.values, ['s1']);
        ss.cancel();
      }));
      list.clear();
    });
    test('onValuesSet', () {
      StreamSubscription ss;
      ss = list.onValuesSet.listen(expectAsync1((rt.ValuesSetEvent e) {
        expect(e.index, 0);
        expect(e.oldValues, ['s1']);
        expect(e.newValues, ['s2']);
        ss.cancel();
      }));
      list[0] = 's2';
    });
  });
}

/**
 * Options for the Realtime loader.
 */
get realtimeOptions => jsw.jsify({
   /**
  * Client ID from the APIs Console.
  */
  'clientId': 'INSERT YOUR CLIENT ID HERE',

   /**
  * The ID of the button to click to authorize. Must be a DOM element ID.
  */
   'authButtonElementId': 'authorizeButton',

   /**
  * Function to be called when a Realtime model is first created.
  */
   'initializeModel': initializeModel,

   /**
  * Autocreate files right after auth automatically.
  */
   'autoCreate': true,

   /**
  * Autocreate files right after auth automatically.
  */
   'defaultTitle': "New Realtime Quickstart File",

   /**
  * Function to be called every time a Realtime file is loaded.
  */
   'onFileLoaded': onFileLoaded
});


main() {
  var realtimeLoader = new js.JsObject(js.context['rtclient']['RealtimeLoader'], [realtimeOptions]);
  realtimeLoader.callMethod('start');
}
