import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:yasmina/tasks/task_provider.dart';
import '../models/task.dart';
import 'uploadFile.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem(this.task);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isSubmitted = false;
  bool isFileSelected = false;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime deadline = widget.task.dueDate;
    int remainingDays = deadline.difference(now).inDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return UploadFileScreen(
                onAssignmentSubmitted: (submitted) {
                  setState(() {
                    isSubmitted = submitted;
                    isFileSelected = submitted;
                  });
                },
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.assignee,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            children: [
                              ListTile(

                                onTap: () {
                                  Provider.of<TaskProvider>(context, listen: false)
                                      .deleteTask(widget.task.id);
                                  Navigator.of(context).pop();
                                },

                                title: const Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                leading: Icon(Icons.delete,color: Colors.green,),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _showUpdateTaskDialog();
                                },
                                title: const Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                leading: Icon(Icons.update,color: Colors.green,),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                title: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                leading: Icon(Icons.cancel,color: Colors.green,),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert_outlined,
                        color: Colors.black, size: 20),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.task.title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(widget.task.id),
              const SizedBox(height: 2),
              ReadMoreText(
                widget.task.description,
                trimLines: 1,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                trimExpandedText: 'Show less',
                trimCollapsedText: 'Read More',
                lessStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                moreStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              isSubmitted
                  ? const Text(
                'Assignment submitted',
                style: TextStyle(color: Colors.green),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Remaining days: $remainingDays',
                    style: const TextStyle(color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () {
                      if (isFileSelected) { // Check if a file has been selected
                        setState(() {
                          isSubmitted = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Please select a file first.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit Assignment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateTaskDialog() {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: widget.task.title);
    final _descriptionController = TextEditingController(text: widget.task.description);
    final _assigneeController = TextEditingController(text: widget.task.assignee);
    final _dueDateController = TextEditingController(text: widget.task.dueDate.toIso8601String());
    final _statusController = TextEditingController(text: widget.task.status);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_dueDateController.text),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );

                    if (picked != null && picked != DateTime.now()) {
                      setState(() {
                        _dueDateController.text = picked.toString();
                      });
                    }
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final updatedTask = Task(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    assignee: _assigneeController.text,
                    dueDate: DateTime.parse(_dueDateController.text),
                    status: _statusController.text,
                  );
                  Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}


//ListTile(
//       title: Text(task.title),
//       subtitle: Text(task.description),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () {
//               // Implement status update functionality if needed
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               // Implement delete functionality
//             },
//           ),
//         ],
//       ),
//     );