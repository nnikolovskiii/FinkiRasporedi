import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/lecture.dart';

class LectureEditScreen extends StatefulWidget {
  final Lecture? lecture;

  const LectureEditScreen({super.key, required this.lecture});

  @override
  _LectureEditScreenState createState() => _LectureEditScreenState();
}

class _LectureEditScreenState extends State<LectureEditScreen> {
  late TextEditingController nameController;
  late TextEditingController dayController;
  late TextEditingController timeFromController;
  late TextEditingController timeToController;
  late TextEditingController professorController;
  late TextEditingController courseController;
  late TextEditingController roomController;
  late TextEditingController typeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.lecture?.name ?? '');
    dayController =
        TextEditingController(text: widget.lecture?.day.toString() ?? '');
    timeFromController =
        TextEditingController(text: widget.lecture?.timeFrom.toString() ?? '');
    timeToController =
        TextEditingController(text: widget.lecture?.timeTo.toString() ?? '');
    professorController =
        TextEditingController(text: widget.lecture?.professor.name ?? '');
    courseController =
        TextEditingController(text: widget.lecture?.course.id ?? '');
    roomController =
        TextEditingController(text: widget.lecture?.room.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lecture == null ? 'Add Lecture' : 'Edit Lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Lecture Name'),
            ),
            TextFormField(
              controller: dayController,
              decoration: const InputDecoration(labelText: 'Day'),
            ),
            TextFormField(
              controller: timeFromController,
              decoration: const InputDecoration(labelText: 'Time From'),
            ),
            TextFormField(
              controller: timeToController,
              decoration: const InputDecoration(labelText: 'Time To'),
            ),
            TextFormField(
              controller: professorController,
              decoration: const InputDecoration(labelText: 'Professor'),
            ),
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            TextFormField(
              controller: roomController,
              decoration: const InputDecoration(labelText: 'Room'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the lecture here
                // You can use the controllers to get the values
                // and create a new Lecture instance or update the existing one.
                // You may want to validate the input before saving.

                // Handle adding or editing logic based on whether lecture is null or not.
                if (widget.lecture == null) {
                  // Add logic here
                } else {
                  // Edit logic here
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: LectureEditScreen(
            lecture: null,
          ),
        ),
      ),
    ),
  );
}
