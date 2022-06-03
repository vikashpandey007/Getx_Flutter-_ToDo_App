import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addTask();
              },
              icon: Icon(Icons.add_box)),
        ],
      ),
      body: Obx(() {
        if (controller.isDataProcessing.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: controller.lstTask.length,
              itemBuilder: (context, indx) {
                print(controller.lstTask.length);

                if (controller.isDataProcessing.value == true) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListTile(
                  onLongPress: (() {
                    displayDeleteDialog(controller.lstTask[indx]["id"]);
                  }),
                  title: Text(controller.lstTask[indx]["name"]),
                  // subtitle: Text(controller.lstTask[indx]["name"].toString()),
                  trailing: IconButton(
                      onPressed: () {
                        updateTask(
                            controller.lstTask[indx]["id"],
                            controller.edit.text =
                                controller.lstTask[indx]["name"]);
                      },
                      icon: Icon(Icons.edit)),
                );
              });
        }
      }),
      
    );
  }

  void addTask() {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.grey,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Task',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.task,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            print("fisttext ${controller.task.text}");
                            controller.saveTask(
                              controller.task.text,
                            );

                            Get.back();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void updateTask(taskId, taskname) {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Task',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.edit,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            print("fisttext ${controller.task.text}");
                            controller.updateTask(taskId, controller.edit.text);

                            Get.back();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  displayDeleteDialog(int id) {
    Get.defaultDialog(
      title: "Delete Task",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete task ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        controller.deleteTask(id);
        Get.back();
      },
    );
  }
}
