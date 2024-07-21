import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MaterialPage1 extends StatefulWidget {
  @override
  State<MaterialPage1> createState() => _MaterialPage1State();
}

class _MaterialPage1State extends State<MaterialPage1> {
  bool materialVisible = false;
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _fileName;
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  List<File> selectedFiles = [];

  final List<Materials> mat = [
    Materials(
      title: 'Session 1',
      subject: 'Maths',
      description: 'Rational Numbers assignment, Very important for your next exam...',
      dueDate: '18 Sep',
      submitted: true,
      daysLeft: null,
    ),
    Materials(
      title: 'Session 2',
      subject: 'Maths',
      description: 'Whole Numbers, Fraction, Decimals, Percentage, Ratio, Time, Measurement, Geometry, Data Analysis, Algebra, Speed ...',
      dueDate: '18 Sep',
      submitted: false,
      daysLeft: 1,
    ),
    Materials(
      title: 'Session 3',
      subject: 'Science',
      description: 'Crop Production & Mgt. Very important for your next exam...',
      dueDate: '20 Sep',
      submitted: false,
      daysLeft: 2,
    ),
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _fileName = pickedFile.name;
        selectedFiles.add(_selectedFile!);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _fileName = pickedFile.name;
        selectedFiles.add(_selectedFile!);
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
        selectedFiles.add(_selectedFile!);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showAddMaterialModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage();

                        },
                        child: const SizedBox(
                          child: Column(
                            children: [
                              Icon(Icons.image, size: 50, color: Colors.green),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickVideo();

                        },
                        child: const SizedBox(
                          child: Column(
                            children: [
                              Icon(Icons.video_collection_sharp, size: 50, color: Colors.green),
                              Text("Video"),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickFile();

                        },
                        child: const SizedBox(
                          child: Column(
                            children: [
                              Icon(Icons.file_copy, size: 50, color: Colors.green),
                              Text("File"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          materialVisible = true;
                        });
                        _titleController.clear();
                        Navigator.of(context).pop();


                      }
                    },
                    child: const Text('Add Material'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mat.length,
              itemBuilder: (context, index) {
                return AssignmentCard(materials: mat[index]);
              },
            ),
          ),
          // if (materialVisible)
          //   Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 220,
          //     child: _selectedFile == null ? Placeholder() : Image.file(_selectedFile!),
          //   ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Click this to View Material')),
              );
            },
            onPressed: () {
              _showAddMaterialModal(context);
            },
            child: const Text(
              'Add Material',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentCard extends StatelessWidget {
  final Materials materials;

  AssignmentCard({required this.materials});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(materials.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(materials.subject),
            Text(materials.description),
            Text('Due: ${materials.dueDate}'),
            if (materials.daysLeft != null)
              Text(
                '${materials.daysLeft} Days Left',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (materials.submitted)
              const Text(
                'Submitted',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Materials {
  final String title;
  final String subject;
  final String description;
  final String dueDate;
  final bool submitted;
  final int? daysLeft;

  Materials({
    required this.title,
    required this.subject,
    required this.description,
    required this.dueDate,
    required this.submitted,
    this.daysLeft,
  });
}
