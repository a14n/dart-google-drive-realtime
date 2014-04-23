import 'dart:html';
import 'dart:js' as js;

import 'package:google_drive_realtime/google_drive_realtime.dart' as rt;
import 'package:js_wrapping/js_wrapping.dart' as jsw;

initializeModel(js.JsObject modelJsObject) {
  var model = rt.Model.$wrap(modelJsObject);
  var string = model.createString('Hello Realtime World!');
  model.root['text'] = string;
}

/**
 * This function is called when the Realtime file has been loaded. It should
 * be used to initialize any user interface components and event handlers
 * depending on the Realtime model. In this case, create a text control binder
 * and bind it to our string model that we created in initializeModel.
 * @param doc {gapi.drive.realtime.Document} the Realtime document.
 */
onFileLoaded(docJsObject) {
  var doc = rt.Document.$wrap(docJsObject);
  var string = rt.CollaborativeString.$wrap(doc.model.root['text']);

  doc.onCollaboratorJoined.listen((rt.CollaboratorJoinedEvent e){
    print("user joined : ${e.collaborator.displayName}");
  });
  doc.onCollaboratorLeft.listen((rt.CollaboratorLeftEvent e){
    print("user left : ${e.collaborator.displayName}");
  });

  // Keeping one box updated with a String binder.
  final TextAreaElement textArea1 = document.getElementById('editor1');
  js.context['gapi']['drive']['realtime']['databinding'].callMethod('bindString', [string, textArea1]);

  // Keeping one box updated with a custom EventListener.
  final TextAreaElement textArea2 = document.getElementById('editor2');
  var updateTextArea2 = (e) {
    textArea2.value = string.text;
  };
  string.onObjectChanged.listen((rt.ObjectChangedEvent e){
    print("ObjectChanged : ${e.type}");
  });
  string.onTextInserted.listen(updateTextArea2);
  string.onTextDeleted.listen(updateTextArea2);
  textArea2.onKeyUp.listen((e) {
    string.text = textArea2.value;
  });
  updateTextArea2(null);

  // Enabling UI Elements.
  textArea1.disabled = false;
  textArea2.disabled = false;
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

/**
 * Start the Realtime loader with the options.
 */
startRealtime() {
  var realtimeLoader = new js.JsObject(js.context['rtclient']['RealtimeLoader'], [realtimeOptions]);
  realtimeLoader.callMethod('start');
}

main() {
  startRealtime();
}
