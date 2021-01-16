import 'package:flutter/material.dart';
import 'package:todoapp/db_helper.dart';
import 'package:todoapp/new_task.dart';
import 'package:todoapp/task_model.dart';
import 'package:todoapp/task_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Todo'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'All Tasks',
              ),
              Tab(
                text: 'Complete Tasks',
              ),
              Tab(
                text: 'InComplete Tasks',
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
              children: [AllTasks(), CompleteTasks(), InCompleteTasks()]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewTask();
            }));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  List<Task> tasks;
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchAllTasks();
    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: tasks == null
            ? []
            : tasks.map((e) => TaskWidget(e, myFun())).toList(),
      ),
    ));
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  List<Task> tasks;
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchSpecificTask(true);
    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: tasks == null
              ? []
              : tasks.map((e) => TaskWidget(e, myFun())).toList(),
        ),
      ),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  List<Task> tasks;
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchSpecificTask(false);
    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: tasks == null
              ? []
              : tasks.map((e) => TaskWidget(e, myFun())).toList(),
        ),
      ),
    );
  }
}
