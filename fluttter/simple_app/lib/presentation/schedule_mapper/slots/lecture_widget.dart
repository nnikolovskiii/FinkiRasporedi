
import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';
import 'package:simple_app/presentation/screens/add/add_lecture_slot_screen.dart';
import 'package:simple_app/service/lecture_slot_service.dart';

import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../../service/schedule_service.dart';
import '../../screens/calendar_screen.dart';


class LectureWidget extends StatelessWidget {
  int num;
  final ScheduleService scheduleService = ScheduleService();
  final LectureSlotService lectureSlotService = LectureSlotService();
  final Schedule schedule;
  final bool segmented;

  List<TransparentTimeSlotWidget> getEmptyTimeSlots(LectureSlot lecture) {
    int interval = lecture.timeTo - lecture.timeFrom;
    List<TransparentTimeSlotWidget> emptyWidgets = [];

    for (double i = 0; i < interval; i++) {
      emptyWidgets.add(TransparentTimeSlotWidget(num: num,));
    }

    return emptyWidgets;
  }

  final LectureSlot lecture;

  LectureWidget({
    super.key,
    required this.lecture,
    required this.segmented, required this.schedule, this.num = 6,
  });

  double getHeight(LectureSlot lecture) {
    int interval = lecture.timeTo - lecture.timeFrom;
    return 50 * interval + 8*(interval-1);
  }

  Color hexStringToColor(String? hexString) {
    if (hexString == null) {
      return Colors.green;
    }
    hexString = hexString.replaceAll("#", "");
    int hexValue = int.parse(hexString, radix: 16);
    return Color(hexValue | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
          onLongPress: () {
        // Show a dialog or perform any action for deleting the lecture
        showDialog(
          context: context,
          builder: (context) => AlertDialog(

            title: Text(lecture.name ?? lecture.lecture!.course.subject.name),
            content: const Text('What actions do you want to perform?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await scheduleService.removeLecture(schedule.id ?? 0, lecture.id ?? -1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CalendarScreen(schedule.id ?? 0),
                    ),
                  ); // Close the dialog
                },
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FieldScreen(schedule: schedule, lectureSlot: lecture),
                    ),
                  ); // Close the dialog
                },
                child: const Text('Update'),
              ),
              TextButton(
                onPressed: () async {
                  await lectureSlotService.resetLectureSlot(lecture.id ?? -1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CalendarScreen(schedule.id ?? 0),
                    ),
                  ); // Close the dialog
                },
                child: const Text('Reset'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              // border: Border(
              //   top: BorderSide(
              //     color: Colors.grey,
              //     width: 2.0,
              //   ),
              //
              // ),
            ),
            child: Container(
              height: getHeight(lecture),
              width:  (width-90)/num,
              decoration: BoxDecoration(
                color: hexToColor(lecture.hexColor ?? "#888888"),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildConditionalWidget()
                  ,
                ),
              ),
            ),
          ),
          if (segmented)
            Positioned(
              top: 0,
              left: 0,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...getEmptyTimeSlots(lecture),
                ],
              ),
            ),
        ],
      )
    );
  }

  List<Widget> _buildConditionalWidget() {
    List<Widget> widgets = [];

    if (lecture.lecture != null) {
      widgets.add(Text(
        lecture.lecture!.room.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Lato',
        ),
      ));

      widgets.add(Text(
        lecture.lecture!.course.subject.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
          color: Colors.black,
        ),
      ));

      widgets.add(Text(
        lecture.lecture!.professor.name,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Lato',
        ),
      ));
    } else {
      widgets.add(Text(
        lecture.name ?? "",
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Lato',
        ),
      ));
    }

    return widgets;
  }



  Color hexToColor(String hexColor) {
    // Remove the # character if present
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }
    // Parse the hex color string to an integer
    int hexValue = int.parse(hexColor, radix: 16);
    // Create a color object from the hex value
    return Color(hexValue).withOpacity(1.0);
  }

}
