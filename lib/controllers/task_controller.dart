import 'dart:ffi';

import 'package:get/get.dart';
import 'package:poodle_mobie_application/db/db_helper.dart';

import '../model/task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }
}