import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/model/data_model/task_model.dart';

import 'app/app.dart';
 
final storage = GetStorage(); 
Future<void> main() async {
   await GetStorage.init();

  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  Hive.registerAdapter(TaskStatusAdapter());
  runApp(const MyApp());
}
