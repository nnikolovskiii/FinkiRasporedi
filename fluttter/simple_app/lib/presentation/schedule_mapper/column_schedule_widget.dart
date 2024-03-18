import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/empty_time_slot_widget.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/horizontal_divider_widget.dart';

import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';
import 'slots/day_slot_widget.dart';
import 'slots/lecture_widget.dart';

class ColumnScheduleWidget extends StatelessWidget {
  final int day;
  final List<LectureSlot> lectures;
  final bool segmented;
  final Schedule schedule;
  bool dayBool;
  int num;

  ColumnScheduleWidget({
    super.key,
    required this.lectures,
    required this.day,
    required this.segmented,
    required this.schedule,
    this.dayBool = true,  this.num = 6,
  });

  defineColumn() {
    List<Widget> lectureWidgets = [];
    lectures.sort((a, b) => a.timeFrom.compareTo(b.timeFrom));
    int j = 0;
    if (dayBool) {
      lectureWidgets.add(DayWidget(
        num: num,
        day: day,
      ));
    }
    lectureWidgets.add(HorizontalDividerWidget(hasColor: true,num: num));
    for (int i = 8; i < 20; i++) {
      if (j < lectures.length && i == lectures[j].timeFrom as int) {
        lectureWidgets.add(LectureWidget(
          lecture: lectures[j],
          segmented: segmented, schedule: schedule,
            num: num
        ));

        int interval = lectures[j].timeTo - lectures[j].timeFrom;
        i = i + (interval as int) - 1;
        j++;
      } else {
        lectureWidgets.add(EmptyTimeSlotWidget(segmented: segmented, num: num));
      }
      if (i != 19) {
        lectureWidgets.add(HorizontalDividerWidget(hasColor: true,num: num));
      }
    }
    return lectureWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...defineColumn(),
            ]),
      ),
    );
  }
}
