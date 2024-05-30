import 'dart:async';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';
import 'package:task_manager/common/widget/common_appBar.dart';
import 'package:task_manager/common/widget/common_derop_down.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/controller/add_note_controller.dart';
import 'package:task_manager/helper/responsive.dart';

import '../../common/widget/common_ button.dart';
import '../../constant/app_style.dart';
import '../model/data/taskData_status-vise.dart';
import '../model/data_model/task_model.dart';
import 'tasksScreen.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  AddTaskController addTaskController = Get.put(AddTaskController());
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startTimer();
    addTaskController.getItems().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return commonDillog(
                  context, addTaskController, formGlobalKey, null);
            },
          );
        },
        child: const PulseIcon(
          icon: Icons.add,
          pulseColor: buttonColor,
          iconColor: Colors.white,
          iconSize: 30,
          innerSize: 30,
          pulseSize: 90,
          pulseCount: 4,
          pulseDuration: Duration(seconds: 4),
        ),
      ),
      appBar: const BaseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return DragAndDropLists(
            listWidth: Responsive.isMobile(context)
                ? double.infinity
                : MediaQuery.of(context).size.width / 3 - 20,
            listDraggingWidth: Responsive.isMobile(context)
                ? double.infinity
                : MediaQuery.of(context).size.width / 3 - 20,
            listPadding: const EdgeInsets.all(8.0),
            axis:
                Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
            children: taskLists.map((e) {
              return DragAndDropList(
                  header: Text(
                    e.header ?? "",
                    style: AppTextStyle.normalSemiBold25,
                  ),
                  children: [
                    ...e.taskItems!
                        .map((e) => DragAndDropItem(
                                child: TaskTile(
                              data: e,
                              itemId: e.itemId!,
                            )))
                        .toList(),
                    if (e.status == TaskStatus.todo)
                      DragAndDropItem(
                          canDrag: false,
                          child: CommonButton(
                            title: "Add Task",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return commonDillog(
                                    context,
                                    addTaskController,
                                    formGlobalKey,
                                    null,
                                  );
                                },
                              );
                            },
                          ))
                  ]);
            }).toList(),
            onItemReorder:
                (oldItemIndex, oldListIndex, newItemIndex, newListIndex) async {
              DataModel itemTask =
                  taskLists[oldListIndex].taskItems!.removeAt(oldItemIndex);

              taskLists[newListIndex].taskItems?.insert(newItemIndex, itemTask);
              itemTask.status = taskLists[newListIndex].status;
              itemTask.save();
              addTaskController.getItems();
            },
            onListReorder: (oldListIndex, newListIndex) {},
          );
        }),
      ),
    );
  }
}
