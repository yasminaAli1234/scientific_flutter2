import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasmina/tasks/task_provider.dart';

import '../models/task.dart';


class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _assigneeController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _assigneeController.dispose();
    _dueDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        assignee: _assigneeController.text,
        dueDate: DateTime.parse(_dueDateController.text),
        status: _statusController.text,
      );
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dueDateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: _descriptionController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assignee'),
                controller: _assigneeController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Due Date (YYYY-MM-DD)',
                  hintText: 'YYYY-MM-DD',
                ),
                controller: _dueDateController,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDueDate(context);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a due date.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status'),
                controller: _statusController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

