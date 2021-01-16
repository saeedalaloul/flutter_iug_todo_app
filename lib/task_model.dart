import 'package:todoapp/db_helper.dart';

class Task {
  int id;
  String taskName;
  bool isComplete;
  Task(this.taskName, this.isComplete);
  Task.withId(this.id, this.taskName, this.isComplete);

  toJson() {
    return {
      DBHelper.taskIdColumnName: this.id,
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskIsCompleteColumnName: this.isComplete ? 1 : 0
    };
  }

// Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['taskName'] = taskName;
    map['isComplete'] = isComplete;

    return map;
  }

  // Extract a Note object from a Map object
  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.taskName = map['taskName'];
    if (map['isComplete'] == 1) {
      this.isComplete = true;
    } else {
      this.isComplete = false;
    }
  }
}
