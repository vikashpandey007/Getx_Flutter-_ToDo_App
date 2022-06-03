import 'package:app/app/modules/home/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var isDataProcessing = false.obs;

  List lstTask = [].obs;
  var isProcessing = false.obs;

  TextEditingController task = TextEditingController();
  TextEditingController edit = TextEditingController();

  @override
  void onInit() {
    getdata();
    super.onInit();
  }

  void getdata() {
    try {
      isDataProcessing(true);
      TaskProvider().getTask().then((resp) {
        print("res $resp");
        isDataProcessing(false);
        lstTask = resp as List;
        print("last $lstTask");
      }, onError: (err) {
        isDataProcessing(false);
        Get.snackbar("Error", err.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      });
    } catch (exception) {
      isDataProcessing(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void saveTask(data) {
    try {
      isProcessing(true);
      TaskProvider().addTask(data).then((resp) {
        if (resp["status"] == "Success") {
          clearTextEditingControllers();
          isProcessing(false);

          Get.snackbar("Add Task", "Task Added", backgroundColor: Colors.green);
          lstTask.clear();
          refreshList();
        } else {
          Get.snackbar("Add Task", "Failed to Add Task",
              backgroundColor: Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        Get.snackbar("Error", err.toString(), backgroundColor: Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red);
    }
  }

  void updateTask(subjectid, subjectname) {
    try {
      isProcessing(true);
      TaskProvider().updateTask(subjectid, subjectname).then((resp) {
        if (resp["status"] == "Success") {
          clearTextEditingControllers();
          isProcessing(false);

          Get.snackbar("update Task", "Task updated",
              backgroundColor: Colors.green);
          lstTask.clear();
          refreshList();
        } else {
          Get.snackbar("update Task", "Failed to update Task",
              backgroundColor: Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        Get.snackbar("Error", err.toString(), backgroundColor: Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red);
    }
  }

  void deleteTask(taskid) {
    try {
      print(taskid);
      isProcessing(true);
      TaskProvider().deleteTask(taskid).then((resp) {
        print("res $resp");
        if (resp["status"] == "Success") {
          isProcessing(false);

          Get.snackbar("delete Task", "Task delete",
              backgroundColor: Colors.green);
          lstTask.clear();
          refreshList();
        } else {
          Get.snackbar("delete Task", "Failed to delete Task",
              backgroundColor: Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        Get.snackbar("Error", err.toString(), backgroundColor: Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red);
    }
  }

  void clearTextEditingControllers() {
    task.clear();
  }

  void refreshList() async {
    getdata();
  }
}
