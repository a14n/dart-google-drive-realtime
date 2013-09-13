import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

import 'package:google_drive_realtime/google_drive_realtime.dart' as rt;
import 'package:google_drive_realtime/google_drive_realtime_custom.dart' as rtc;

class Task extends rt.CollaborativeObject {
  static const NAME = 'Task';

  /**
   * Register type as described in https://developers.google.com/drive/realtime/build-model#registering_and_creating_custom_objects
   * This method must be call only one time before the document is load.
   */
  static void registerType() {
    js.context['Task'] = (){};
    rtc.registerType(js.context['Task'], NAME);
    js.context['Task']['prototype']['title'] = rtc.collaborativeField('title');
    js.context['Task']['prototype']['done'] = rtc.collaborativeField('done');
  }

  static Task cast(js.JsObject proxy) => proxy == null ? null : new Task.fromJsObject(proxy);

  /// create new collaborative object from model
  Task(rt.Model model) : this.fromJsObject(model.create(NAME).$unsafe);
  Task.fromJsObject(js.JsObject proxy) : super.fromJsObject(proxy) {
    done = false;
  }

  String get title => $unsafe['title'];
  bool get done => $unsafe['done'];
  set title(String title) => $unsafe['title'] = title;
  set done(bool done) => $unsafe['done'] = done;
}

initializeModel(js.JsObject modelJsObject) {
  var model = rt.Model.cast(modelJsObject);
  var tasks = model.createList();
  model.root['tasks'] = tasks;
}

/**
 * This function is called when the Realtime file has been loaded. It should
 * be used to initialize any user interface components and event handlers
 * depending on the Realtime model. In this case, create a text control binder
 * and bind it to our string model that we created in initializeModel.
 * @param doc {gapi.drive.realtime.Document} the Realtime document.
 */
onFileLoaded(docJsObject) {
  final doc = rt.Document.cast(docJsObject);
  final rt.CollaborativeList<Task> tasks = rt.CollaborativeList.castListOfSerializables(doc.model.root['tasks'], Task.cast);

  // collaborators listener
  doc.onCollaboratorJoined.listen((rt.CollaboratorJoinedEvent e){
    print("user joined : ${e.collaborator.displayName}");
  });
  doc.onCollaboratorLeft.listen((rt.CollaboratorLeftEvent e){
    print("user left : ${e.collaborator.displayName}");
  });

  final ulTasks = document.getElementById('tasks') as UListElement;
  final task = document.getElementById('task') as TextInputElement;
  final add = document.getElementById('add') as ButtonElement;

  final updateTasksList = (){
    ulTasks.children.clear();
    for(int i = 0; i < tasks.length; i++) {
      ulTasks.children.add(new LIElement()..text = tasks[i].title);
    }
  };

  document.getElementById('add').onClick.listen((_){
    tasks.push(new Task(doc.model)
      ..title = task.value
    );
    task.value = "";
    task.focus();
  });

  // update input on changes
  tasks.onObjectChanged.listen((rt.ObjectChangedEvent e){
    updateTasksList();
  });

  // Enabling UI Elements.
  task.disabled = false;
  add.disabled = false;

  // init list
  updateTasksList();
}

/**
 * Options for the Realtime loader.
 */
get realtimeOptions => js.jsify({
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
  realtimeLoader.callMethod('start', [Task.registerType]);
}
