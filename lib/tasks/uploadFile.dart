import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFileScreen extends StatefulWidget {
  final Function(bool) onAssignmentSubmitted;

  const UploadFileScreen({Key? key, required this.onAssignmentSubmitted}) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  String? _fileName;
  bool _assignmentSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            if (_fileName != null)
              Column(
                children: [
                  Text(
                    'Selected File:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_fileName!),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _assignmentSubmitted ? null : _submitAssignment,
                    child: Text(_assignmentSubmitted ? 'Assignment Submitted' : 'Submit Assignment'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      // Process the selected file, e.g., upload to server, save locally, etc.
      print('File picked: ${file.name}');

      setState(() {
        _fileName = file.name;
        _assignmentSubmitted = false; // Reset submission status
      });

      // Show a dialog with the picked file name
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selected File'),
            content: Text(file.name),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // User canceled the file picker
      print('User canceled file picking.');
    }
  }

  void _submitAssignment() {
    // Placeholder for assignment submission logic
    // Simulate submission process (could include uploading file to server, etc.)
    setState(() {
      _assignmentSubmitted = true;
    });

    // Call the callback to notify parent (TaskItem) of assignment submission
    widget.onAssignmentSubmitted(true);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assignment Submitted'),
          content: Text('Your assignment has been submitted successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
