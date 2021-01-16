import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/db_helper.dart';
import 'package:todoapp/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplete = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
                value: isComplete,
                onChanged: (value) {
                  this.isComplete = value;
                  setState(() {});
                }),
            RaisedButton(
              onPressed: () {
                if (taskName != null && taskName.isNotEmpty) {
                  DBHelper.dbHelper
                      .insertNewTask(Task(this.taskName, this.isComplete));
                  Navigator.pop(context);
                } else {
                  print("Task Name is not empty !");
                }
              },
              child: Text('Add New Task'),
            )
          ],
        ),
      ),
    );
  }
}
