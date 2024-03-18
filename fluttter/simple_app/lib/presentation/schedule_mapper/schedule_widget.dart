import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/time_slot_widget.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/vertical_divider_widget.dart';

import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';

import 'column_schedule_widget.dart';

class ScheduleWidget extends StatelessWidget {
  final Schedule schedule;
  final bool segmented;

  const ScheduleWidget(
      {super.key, required this.schedule, required this.segmented});

  getDayColumns() {
    List<Widget> days = [];
    List<List<LectureSlot>> list = [];

    days.add(TimeSlotWidget(startTimeHour: 8, endTimeHour: 20));

    for (int i = 0; i < 5; i++) {
      List<LectureSlot> lecture = [];
      list.add(lecture);
    }

    List<LectureSlot> lectures = schedule.lectures!;

    for (int i = 0; i < lectures.length; i++) {
      int idx = lectures[i].day;
      list[idx].add(lectures[i]);
    }

    days.add(VerticalDividerWidget(numCells: 13, color: Colors.grey.shade300,));

    for (int i = 0; i < 5; i++) {
      days.add(ColumnScheduleWidget(
        lectures: list[i],
        day: i,
        segmented: segmented,
        schedule: schedule,
      ));
      if (i != 4) days.add(VerticalDividerWidget(numCells: 13, color: Colors.grey.shade300,));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   TimeSlotWidget(startTimeHour: 8, endTimeHour: 19),
                  ...getDayColumns(),
                ]),
          ),
          //DraggableContainer()
        ]),
      ),
    ));
  }
}
