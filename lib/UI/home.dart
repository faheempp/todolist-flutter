import 'package:flutter/material.dart';
import 'package:todo_app/Data/todolistclass.dart';
import 'package:todo_app/Services/localdatabase.dart';
import 'package:todo_app/UI/Components/newtask_dialogue.dart';
import 'package:todo_app/UI/Components/todo_listtile.dart';
import 'package:todo_app/UI/Utils/theme.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tileCount = 0;

  final double diameter = 30;
  var db = DBProvider.db;

  @override
  Widget build(BuildContext context) {
    //db.deleteTodoEntry(3);
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        color: grey,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: grey,
              floating: false,
              pinned: true,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "todolist",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: blue,
                      shadows: [
                        Shadow(
                          color: darkGrey,
                          blurRadius: 5,
                        ),
                      ]),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TodoListView();
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: grey,
        elevation: 40,
        onPressed: () {
          addTaskForm(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: blue,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  customAppBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(0.0), // here the desired height
        child: AppBar(
          backgroundColor: grey,
        ));
  }

  addTaskForm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewTaskDialogue();
        });
  }

  TodoListView() {
    var db = DBProvider.db;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: FutureBuilder<List<TodoEntry>>(
        future: db.getTodoEntries(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TodoEntry>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(snapshot.data!.length);
                  return TodoListTile(
                    entry: snapshot.data![index],
                  );

              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
