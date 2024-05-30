import 'package:get/get.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';
// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class DataModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime? createdAt;
  @HiveField(3)
  TaskStatus? status;
  @HiveField(4)
  int? itemId;
  @HiveField(5)
  DateTime? dueDate;

  DataModel(
      {this.title,
      this.description,
      this.createdAt,
      this.status,
      this.itemId,
      this.dueDate});
  DataModel copyWith({
    String? title,
    String? description,
    DateTime? createdAt,
    TaskStatus? status,
    int? itemId,
    DateTime? dueDate,
  }) {
    return DataModel(
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        itemId: itemId ?? this.itemId,
        dueDate: dueDate ?? this.dueDate);
  }
}

class TaskDragItem extends HiveObject {
  @HiveField(0)
  final String? header;
  @HiveField(1)
  final RxList<DataModel>? taskItems;
  @HiveField(2)
  final TaskStatus? status;

  TaskDragItem({this.header, this.taskItems, this.status});
}

/// Enum representing the status of a task.
@HiveType(typeId: 1)
enum TaskStatus {
  /// The task is pending.
  @HiveField(0)
  todo("Todo"),

  /// The task is in-progress.
  @HiveField(1)
  inProcess("In Process"),

  /// The task is completed.
  @HiveField(2)
  finished("Done");

  final String to;
  const TaskStatus(this.to);
}
