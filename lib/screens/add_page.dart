import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/services/todo_service.dart';
import 'package:todo/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      titleController.text = todo['title'];
      descriptionController.text = todo['description'];
    }
  }

  Future<void> submitData() async {
    // submit data to the server
    final isSuccess = await TodoService.createData(body);

    // show success or fail message based on status
    if (isSuccess) {
      showSuccessMessage(context,
          type: 'success', message: 'Creation Success!');
      Navigator.of(context).pop('String');
    } else {
      showSuccessMessage(context, type: 'fail', message: 'Creation failed!');
    }
  }

  Future<void> updateData() async {
    // get the data from form
    final todo = widget.todo;
    if (todo == null) {
      print("You can not call updated without todo data");
      return;
    }
    final id = todo['_id'];

    // submit updated data to the server
    final isSuccess = await TodoService.updateData(id, body);

    // show success or fail message based on status
    if (isSuccess) {
      showSuccessMessage(context,
          type: 'success', message: 'Updation Success!');
      Navigator.of(context).pop('String');
    } else {
      showSuccessMessage(context, type: 'fail', message: 'Update failed!');
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : 'Submit'),
          )
        ],
      ),
    );
  }
}
