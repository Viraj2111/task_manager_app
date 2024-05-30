import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/constant/app_style.dart';
import 'package:task_manager/controller/add_note_controller.dart';
import 'package:task_manager/model/data_model/task_model.dart';
import '../../constant/static_decoration.dart';
import '../../helper/responsive.dart';
import 'common_ button.dart';

StatefulWidget commonDillog(
    BuildContext context,
    AddTaskController addTaskController,
    GlobalKey<FormState>? formGlobalKey,
    DataModel? data) {
  if (data != null) {
    addTaskController.itemController.text = data.title!;
    addTaskController.descriptionController.text = data.description!;
    addTaskController.selectedValue = data.status!;
  } else {
    addTaskController.itemController.clear();
    addTaskController.descriptionController.clear();
    addTaskController.selectedValue = null;
  }
  return StatefulBuilder(
    builder: (context, setState) => AlertDialog(
      actionsPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: appWhiteColor,
      content: Form(
        key: formGlobalKey,
        child: Container(
            margin: EdgeInsets.zero,
            width: Responsive.isMobile(context) ? Get.width : Get.width * 0.5,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Responsive.isMobile(context) ? 10 : 20),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Responsive.isMobile(context)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                color: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                disabledColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.transparent,
                                )),
                            Text(
                              data != null ? "Update Task" : "Add Task",
                              style: AppTextStyle.regularBold20
                                  .copyWith(color: appBlackColor),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.close))
                          ],
                        )
                      : Center(
                          child: Text(
                            "Add Task",
                            style: AppTextStyle.regularBold30
                                .copyWith(color: appBlackColor),
                          ),
                        ),
                  Text(
                    "Title",
                    style:
                        AppTextStyle.regularBold20.copyWith(color: appBlackColor),
                  ),
                  TextFormField(
                    controller: addTaskController.itemController,
                    validator: (value) {
                      if (value!.isEmpty) return "Required Field";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Title',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        contentPadding: Responsive.isMobile(context)
                            ? const EdgeInsets.all(12)
                            : null),
                  ),
                  Responsive.isMobile(context) ? height10 : height20,
                  Text(
                    "Description",
                    style:
                        AppTextStyle.regularBold20.copyWith(color: appBlackColor),
                  ),
                  TextFormField(
                    controller: addTaskController.descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) return "Required Field";
                      return null;
                    },
                    maxLines: Responsive.isMobile(context) ? 2 : 3,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        contentPadding: Responsive.isMobile(context)
                            ? const EdgeInsets.all(12)
                            : null),
                  ),
                  Responsive.isMobile(context) ? height10 : height20,
                  Text(
                    "To-Do Status",
                    style:
                        AppTextStyle.regularBold20.copyWith(color: appBlackColor),
                  ),
                  DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                          ),
                          contentPadding: Responsive.isMobile(context)
                              ? const EdgeInsets.all(12)
                              : null),
                      hint: const Text("Select To-Do Status"),
                      value: addTaskController.selectedValue,
                      onChanged: (newValue) {
                        setState(
                          () {
                            addTaskController.selectedValue = newValue;
                          },
                        );
                      },
                      validator: (newValue) {
                        if (addTaskController.selectedValue == null) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      focusColor: appWhiteColor,
                      dropdownColor: appWhiteColor,
                      items: TaskStatus.values.map((TaskStatus e) {
                        return DropdownMenuItem<TaskStatus>(
                          value: e,
                          child: Text(
                            e.to.toString(),
                          ),
                        );
                      }).toList()),
                  Responsive.isMobile(context) ? height10 : height20,
                  Text(
                    "Due Date",
                    style:
                        AppTextStyle.regularBold20.copyWith(color: appBlackColor),
                  ),
                  CalendarDatePicker2(
                    config: CalendarDatePicker2Config(daySplashColor: buttonColor, selectedDayHighlightColor: buttonColor, currentDate: addTaskController.dueDate.value ),

                    value: [DateTime.now()],
                    onValueChanged: (dates) => addTaskController.dueDate.value = dates.first ?? DateTime.now()),
                  
                  Responsive.isMobile(context) ? height20 : customHeight(30),
                  Row(
                    children: [
                      Responsive.isMobile(context)
                          ? const SizedBox()
                          : Expanded(
                              child: CommonButton(
                                title: "Cancel",
                                color: appWhiteColor,
                                textColor: appBlackColor,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                      Responsive.isMobile(context) ? width10 : customWidth(50),
                      Expanded(
                        child: CommonButton(
                          title: data != null ? "Update" : 'Create New',
                          onTap: () async {
                            if (data != null) {
                              if (formGlobalKey!.currentState!.validate()) {
                                DataModel dataModel = DataModel(
                                    itemId: data.itemId,

                                    title: addTaskController.itemController.text,
                                    description: addTaskController
                                        .descriptionController.text,
                                    status: addTaskController.selectedValue,
                                    createdAt: data.createdAt, dueDate: addTaskController.dueDate.value);
                                var index = addTaskController.todoBox.values
                                    .toList()
                                    .indexOf(data);
                                addTaskController.todoBox.putAt(index, dataModel);
              
                                Navigator.of(context).pop();
              
                                addTaskController.itemController.clear();
                                addTaskController.descriptionController.clear();
                                addTaskController.selectedValue = null;
              
                                addTaskController.getItems();
                              }
                            } else {
                              addTaskController.generateRandomNumber();
                              if (formGlobalKey!.currentState!.validate()) {
                                DataModel dataModel = DataModel(
                                    itemId: addTaskController.randomNumber.value,
                                    title: addTaskController.itemController.text,
                                    description: addTaskController
                                        .descriptionController.text,
                                    status: addTaskController.selectedValue,
                                    dueDate: addTaskController.dueDate.value,
                                    createdAt: DateTime.now());
                                addTaskController.todoBox.add(dataModel);
                                Navigator.of(context).pop();
              
                                addTaskController.itemController.clear();
                                addTaskController.descriptionController.clear();
                                addTaskController.selectedValue = null;
              
                                addTaskController.getItems();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}
