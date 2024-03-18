import 'package:flutter/material.dart';

import '../../../domain/models/schedule.dart';
import '../add/add_lecture_slot_screen.dart';
import 'course_list_screen.dart';

class ChooseLectureScreen extends StatelessWidget {
  final Schedule schedule;

  const ChooseLectureScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Lecture'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3, // Add elevation for a shadow effect
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseListScreen(schedule: schedule),
                              ),
                            );
                          },
                          child: const Text(
                            'Термин од распоред',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Додади предавање или вежби според термини во распоредот на ФИНКИ.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add space between the two cards
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3, // Add elevation for a shadow effect
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FieldScreen(schedule: schedule),
                              ),
                            );
                          },
                          child: const Text(
                            'Custom термин',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Додади свои предавања, вежби и лабораториски.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
