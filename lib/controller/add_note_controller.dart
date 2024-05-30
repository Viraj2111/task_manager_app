import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/model/data/taskData_status-vise.dart';
import 'package:task_manager/model/data_model/task_model.dart';

class AddTaskController extends GetxController {
  TextEditingController itemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<DateTime> dueDate = DateTime.now().obs;
  final Random random = Random();
  RxInt randomNumber = 0.obs;
  late Box<DataModel> todoBox;
  // late Box<DataModel> onProgressBox;
  // late Box<DataModel> finishBox;

  TaskStatus? selectedValue;
  void generateRandomNumber() {
    randomNumber.value = 100000 + random.nextInt(900000);
  }

  Future getItems() async {
    todoBox = await Hive.openBox<DataModel>('hive_box_todo'); // open box
    // onProgressBox =
    //     await Hive.openBox<DataModel>('hive_box_onProgress'); // open box
    // finishBox = await Hive.openBox<DataModel>('hive_box_finish'); // open box
    final List<DataModel> _todos = todoBox.values
        .where((element) => element.status == TaskStatus.todo)
        .toList();
    final List<DataModel> _inProcess = todoBox.values
        .where((element) => element.status == TaskStatus.inProcess)
        .toList();
    final List<DataModel> _finished = todoBox.values
        .where((element) => element.status == TaskStatus.finished)
        .toList();

    todos.clear();
    todos.addAll(_todos);

    //   for (var element in onProgressBox.values) {
    //     _inProcess.add(element);
    //   }
    inProcess.clear();
    inProcess.addAll(_inProcess);
    //   for (var element in finishBox.values) {
    //     _finished.add(element);
    //   }
    finished.clear();
    finished.addAll(_finished);
  }
}
