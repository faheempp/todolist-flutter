import 'package:flutter/material.dart';
import 'package:todo_app/Data/todolistclass.dart';
import 'package:todo_app/Services/localdatabase.dart';
import 'package:todo_app/UI/Utils/theme.dart';
import 'package:todo_app/UI/Utils/global.dart';

import '../home.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile({required this.entry, Key? key}) : super(key: key);
  final TodoEntry entry;

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  double diameter = 30;
  bool done = false;
  var db = DBProvider.db;

  @override
  Widget build(BuildContext context) {
    if (widget.entry.done == 1) {
      done = true;
    } else {
      done = false;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 2, 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: darkGrey, blurRadius: 16, offset: Offset(0, 3))
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AnimatedOpacity(
                opacity: widget.entry.done == 1 ? 0.5 : 1,
                duration: Duration(
                  milliseconds: 20,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.entry.id.toString() + " " + widget.entry.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: blue,
                            fontWeight: FontWeight.w500,
                            decoration: done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        widget.entry.description,
                        style: TextStyle(
                            fontSize: 15,
                            color: black,
                            fontWeight: FontWeight.w400,
                            decoration: widget.entry.done == 1
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ]),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Icon(Icons.clear_sharp),
                  onPressed: () {
                    setState(() {
                      db.deleteTodoEntry(widget.entry.id);
                    });
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.entry.done = widget.entry.done == 1 ? 0 : 1;
                      db.updateTodoEntry(widget.entry);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                    });
                  },
                  child:
                      widget.entry.done == 1 ? circleDone() : circleNotDone(),
                ),
              ],
            ),
          ]),
    );
  }

  circleNotDone() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: diameter,
      width: diameter,
      //child: Icon(Icons.add),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: blue,
            width: 2,
          )),
    );
  }

  circleDone() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: diameter,
      width: diameter,
      child: Center(
        child: Icon(
          Icons.done_rounded,
          color: grey,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: blue,
      ),
    );
  }
}
