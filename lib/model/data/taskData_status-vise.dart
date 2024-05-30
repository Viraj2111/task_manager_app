// ignore_for_file: file_names

import 'package:get/get.dart';

import '../data_model/task_model.dart';
import 'task_data.dart';

/// List of tasks that are in the "To-Do" stage.
RxList<DataModel> todos =
    taskList.where((element) => element.status == TaskStatus.todo).toList().obs;

/// List of tasks that are in progress.
RxList<DataModel> inProcess = taskList
    .where((element) => element.status == TaskStatus.inProcess)
    .toList()
    .obs;

/// List of tasks that are finished.
RxList<DataModel> finished = taskList
    .where((element) => element.status == TaskStatus.finished)
    .toList()
    .obs;

/// List of categorized tasks for different stages.
RxList<TaskDragItem> taskLists = [
  TaskDragItem(header: "ToDo", taskItems: todos, status: TaskStatus.todo),
  TaskDragItem(
      header: "On Progress",
      taskItems: inProcess,
      status: TaskStatus.inProcess),
  TaskDragItem(
      header: "Finished", taskItems: finished, status: TaskStatus.finished),
].obs;
