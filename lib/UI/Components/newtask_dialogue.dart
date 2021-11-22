import 'package:flutter/material.dart';
import 'package:todo_app/Data/todolistclass.dart';
import 'package:todo_app/Services/localdatabase.dart';
import 'package:todo_app/UI/Utils/theme.dart';

import '../home.dart';

class NewTaskDialogue extends StatefulWidget {
  //const NewTaskDialogue({Key? key}) : super(key: key);
  NewTaskDialogue({Key? key,}) : super(key: key);

  @override
  _NewTaskDialogueState createState() => _NewTaskDialogueState();
}

class _NewTaskDialogueState extends State<NewTaskDialogue> {
  var db= DBProvider.db;
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleTextController=TextEditingController();
  TextEditingController descTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width*.9,
        child:Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add Task",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: blue,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleTextController,
                    decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descTextController,
                    decoration: InputDecoration(
                      labelText:"Description",
                    ),
                  ),
                ),
                SizedBox(height:30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(blue),
                              foregroundColor: MaterialStateProperty.all(white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              ),
                              elevation: MaterialStateProperty.all(5)
                          ),
                          child: Icon(Icons.done_rounded),
                          //label:Text("Add Task"),
                          onPressed: () {
                            String title= titleTextController.text;
                            String description= descTextController.text;
                            createTask(title,description);

                            if (_formKey.currentState!.validate()) {
                              // _formKey.currentState!.save();
                             
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(white),
                              foregroundColor: MaterialStateProperty.all(Colors.black45),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.black45)
                                  )
                              ),
                              elevation: MaterialStateProperty.all(5)
                          ),
                          child: Icon(Icons.cancel),
                          //label:Text("Cancel"),
                          onPressed: () {
                            DBProvider.db.deleteAll();
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

      ),
    );
  }
  createTask(String title,String description){
      TodoEntry entry=TodoEntry(title: title,description: description,done: 0);
      db.newTodoTask(entry);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>Home()), (route) => false) ;
   // Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.done_rounded, color: white,),
              SizedBox(width: 10,),
              Text("New Task Added"),
            ],
          ),
        )
    );
  }
}
