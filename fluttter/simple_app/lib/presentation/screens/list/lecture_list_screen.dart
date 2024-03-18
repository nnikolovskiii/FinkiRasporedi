import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/lecture.dart';
import 'package:simple_app/service/lecture_service.dart';

import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../../service/schedule_service.dart';
import '../../schedule_mapper/slots/day_slot_widget.dart';

import '../../widgets/color_picker_widget.dart';

bool isOverlapping(Schedule schedule, Lecture lec) {
  List<LectureSlot> lectures = schedule.lectures ?? [];
  for (LectureSlot lec1 in lectures) {
    if (lec1.day == lec.day) {
      bool overlap =
          ((lec1.timeFrom >= lec.timeFrom && lec1.timeFrom < lec.timeTo) ||
              (lec1.timeTo > lec.timeFrom && lec1.timeTo <= lec.timeTo) ||
              (lec1.timeFrom <= lec.timeFrom && lec1.timeTo >= lec.timeTo));

      if (overlap) {
        return true;
      }
    }
  }
  return false;
}

class LectureListScreen extends StatefulWidget {
  final Schedule schedule;
  final String professorId;
  final String professorName;
  final String courseId;
  final LectureService lectureService = LectureService();
  final ScheduleService scheduleService =
      ScheduleService(); // Initialize LectureService

  LectureListScreen({super.key, 
    required this.professorId,
    required this.professorName,
    required this.courseId,
    required this.schedule,
  });

  @override
  _LectureListScreenState createState() => _LectureListScreenState();
}

class _LectureListScreenState extends State<LectureListScreen> {
  List<Lecture> selectedLectures = [];

  @override
  Widget build(BuildContext context) {
    print(widget.courseId);
    print(widget.professorId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Термини кај ${widget.professorName}',
          style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF123499),
        ),),
      elevation: 20,
      ),
      body: FutureBuilder<List<Lecture>>(
        future: widget.lectureService.getLecturesByCourseIdAndProfessorId(
          courseId: widget.courseId,
          professorId: widget.professorId,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Lecture>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No lectures available'),
            );
          } else {
            // Display the list of lecture slots
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                final lecture = snapshot.data![index];

                // Determine background color based on index
                Color backgroundColor = index % 2 == 0 ? Colors.white70 : const Color(0xFFdfe7f2);

                return Container(
                  color: backgroundColor, // Set background color here
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0,2,0,5),
                      //color: const Color(0xFFc4cfe2), // Set background color for the title text
                      child: Text(
                        '${DayWidget.daysMap[lecture.day]}',
                        style: const TextStyle(
                          color: Color(0xFF19448e),
                          //fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        // Room
                        Expanded(
                          child: Container(
                            //margin: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.black, // Choose the color of your border
                              //   width: 1.0, // Choose the width of your border
                              // ),
                              //color: Colors.grey,
                              borderRadius: BorderRadius.circular(5.0), // Optional: Add border radius
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Your Column children here
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                  child: Text('Просторија:', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),

                                Text(lecture.room.name),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                          width: 2,
                          height: 30,
                          color: Colors.grey, // Add color here
                        ),
                        const SizedBox(width: 6,),
                        // From
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(3.0, 0, 6.0, 0),
                            decoration: BoxDecoration(
                            // border: Border.all(
                            // color: Colors.black, // Choose the color of your border
                            // width: 1.0, // Choose the width of your border
                            // ),
                            //color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5.0), // Optional: Add border radius
                            ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                child: Text('Почеток:', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text('${lecture.timeFrom}:00 h'),


                            ],
                          ),
                        ),),
                        // To
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                          width: 1,
                          height: 30,
                          color: Colors.white30, // Add color here
                        ),
                        const SizedBox(width: 6,),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 6.0, 0),
                            decoration: BoxDecoration(
                              // border: Border.all(
                              // color: Colors.black, // Choose the color of your border
                              // width: 1.0, // Choose the width of your border
                              // ),
                              //color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5.0), // Optional: Add border radius
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                  child: Text('Крај:', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),

                                Text('${lecture.timeTo}:00 h'),

                              ],
                            ),
                          ),),
                        // To
                      ],
                    ),
                  onTap: () async {
                    // Access the Provider instance
                    //
                    if (isOverlapping(widget.schedule, lecture)) {
                      // Show pop-up indicating overlap
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Overlap Warning'),
                            content: const Text(
                                'The selected lecture overlaps with an existing one.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ColorPickerScreen(schedule: widget.schedule, lectureSlot: LectureSlot(lecture: lecture, day: lecture.day, timeFrom: lecture.timeFrom, timeTo: lecture.timeTo), update: false,),
                        ),
                      );
                    }
                    // Navigate to AddedLecturesScreen and pass necessary data
                  },
                ),);
              },
            );
          }
        },
      ),
    );
  }
}
