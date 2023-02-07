import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/consts/lang.dart';

String taskStatusString(String? taskStatus) {
  if (taskStatus == TaskStatus.toDo.toString()) {
    return Lang.toDo;
  } else if (taskStatus == TaskStatus.inProgress.toString()) {
    return Lang.inProgress;
  } else {
    return Lang.done;
  }
}
