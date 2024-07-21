import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasmina/settings/Settings.dart';
import 'package:yasmina/tasks/addTask.dart';
import '../loading/file_load.dart';
import '../models/task.dart';
import '../tasks/TaskItem.dart';
import '../tasks/task_provider.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController contor = TextEditingController();
  String selectedClass = 'Class 1'; // Initial selected value
  List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  List<Task> _results = [];

  @override
  void initState() {
    super.initState();
    _results = Provider.of<TaskProvider>(context, listen: false).tasks;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Assignment",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Settingss()));
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/image/image3.png"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextField(
                        onChanged: _handleSearch,
                        controller: contor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search Assignment",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedClass,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: Colors.green,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedClass = newValue!;
                          });
                        },
                        items: classes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (ctx, i) => TaskItem(_results[i]),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch(String input) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final tasks = taskProvider.tasks;

    setState(() {
      _results = tasks.where((task) {
        final titleLower = task.title.toLowerCase();
        final descriptionLower = task.description.toLowerCase();
        final assigneeLower = task.assignee.toLowerCase();
        final searchLower = input.toLowerCase();

        return titleLower.contains(searchLower) ||
            descriptionLower.contains(searchLower) ||
            assigneeLower.contains(searchLower);
      }).toList();
    });
  }
}


