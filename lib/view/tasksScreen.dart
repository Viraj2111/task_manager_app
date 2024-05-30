// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/common/widget/common_derop_down.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/constant/app_style.dart';
import 'package:task_manager/constant/static_decoration.dart';
import 'package:task_manager/controller/add_note_controller.dart';
import 'package:task_manager/helper/time_ago.dart';
import 'package:task_manager/model/data_model/task_model.dart';
import 'task_view.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return const TaskView();
  }
}

///common widget for task item tile to display task overview
class TaskTile extends StatefulWidget {
  final DataModel data;

  final int itemId;

  const TaskTile({
    super.key,
    required this.itemId,
    required this.data,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  AddTaskController addTaskController = Get.put(AddTaskController());
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return commonDillog(
              context,
              addTaskController,
              formGlobalKey,
              widget.data,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            SvgPicture.asset("assets/icon/svg/assignment.svg"),
            width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.data.title ?? "",
                        style: AppTextStyle.normalRegularBold15,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      width10,
                      Text(
                        '${widget.data.createdAt?.timeAgo()} ago',
                        style: AppTextStyle.normalRegularBold10.copyWith(
                          color: hintTextColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.description ?? "",
                    style: AppTextStyle.normalRegularBold12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormat.yMMMd().format( widget.data.dueDate!),
                    
                    style: AppTextStyle.normalRegularBold12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            width10,
            popupMenuButton(),
          ],
        ),
      ),
    );
  }

  PopupMenuButton<TaskStatus> popupMenuButton() {
    return PopupMenuButton<TaskStatus>(
      onSelected: (TaskStatus item) {
        addTaskController.selectedValue = item;
      },
      icon: SvgPicture.asset("assets/icon/svg/more_vert.svg"),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TaskStatus>>[
        PopupMenuItem<TaskStatus>(
          value: TaskStatus.todo,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return commonDillog(
                  context,
                  addTaskController,
                  formGlobalKey,
                  widget.data,
                );
              },
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Edit'), Icon(Icons.edit)],
          ),
        ),
        PopupMenuItem<TaskStatus>(
          value: TaskStatus.inProcess,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Delete'), Icon(Icons.delete)],
          ),
          onTap: () async {
            var index =
                addTaskController.todoBox.values.toList().indexOf(widget.data);
            await addTaskController.todoBox.deleteAt(index);

            addTaskController.getItems();
            setState(() {});
          },
        ),
        // PopupMenuItem<TaskStatus>(
        //   value: TaskStatus.finished,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Text("Status"),
        //       PopupMenuButton<TaskStatus>(
        //         padding: EdgeInsets.zero,
        //         offset: const Offset(20, 50),
        //         itemBuilder: (context) => [
        //           PopupMenuItem<TaskStatus>(
        //             value: TaskStatus.todo,
        //             onTap: () {
        //               widget.data.status = TaskStatus.todo;
        //               widget.data.save();
        //               addTaskController.getItems();
        //               setState(() {});
        //               Get.back();
        //             },
        //             child: const Text('Todo'),
        //           ),
        //           PopupMenuItem<TaskStatus>(
        //             value: TaskStatus.inProcess,
        //             child: const Text('In progress'),
        //             onTap: () {
        //               widget.data.status = TaskStatus.inProcess;
        //               widget.data.save();
        //               addTaskController.getItems();
        //               setState(() {});
        //               Get.back();
        //             },
        //           ),
        //           PopupMenuItem<TaskStatus>(
        //             value: TaskStatus.finished,
        //             child: const Text('Finish'),
        //             onTap: () {
        //               widget.data.status = TaskStatus.finished;
        //               widget.data.save();
        //               setState(() {});
        //               addTaskController.getItems();
        //               // Get.back();
        //             },
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
