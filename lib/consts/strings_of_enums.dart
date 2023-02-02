import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/consts/lang.dart';

String taskStatusString(TaskStatus taskStatus) {
  if (taskStatus == TaskStatus.toDo) {
    return Lang.toDo;
  } else if (taskStatus == TaskStatus.inProgress) {
    return Lang.inProgress;
  } else {
    return Lang.done;
  }
}
