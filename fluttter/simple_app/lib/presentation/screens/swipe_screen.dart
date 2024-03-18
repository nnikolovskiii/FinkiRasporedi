import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/day_slot_widget.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';
import '../schedule_mapper/column_schedule_widget.dart';
import '../schedule_mapper/slots/time_slot_widget.dart';
import '../schedule_mapper/slots/vertical_divider_widget.dart';

/// This is the stateful widget that the main application instantiates.
class HorizontalSwipeScreen extends StatefulWidget {
  final Schedule schedule;
  final bool segmented;

  const HorizontalSwipeScreen(
      {super.key, required this.schedule, required this.segmented});

  @override
  _HorizontalSwipeScreenState createState() => _HorizontalSwipeScreenState();
}

class _HorizontalSwipeScreenState extends State<HorizontalSwipeScreen> {
  late final PageController controller;
  double currentPage = 0;
  late int num;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    controller.addListener(_onPageChanged);
    num = 1;
  }

  @override
  void dispose() {
    controller.removeListener(_onPageChanged);
    controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    if (currentPage < (5 - num)) {
      setState(() {
        currentPage = controller.page ?? 0;
      });
    }
  }

  void _onDotTapped(double position) {
    int index = position.round();
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            // Detect both touch and mouse events
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0 && currentPage > 0) {
                // Swiping right
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              } else if (details.delta.dx < 0 && currentPage < (5 - num)) {
                // Swiping left
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      dotsCount: 5 - num + 1, // Assuming you have 5 pages
                      position: currentPage.toDouble(),
                      decorator: const DotsDecorator(
                        color: Colors.grey, // Inactive color
                        activeColor: Colors.blueAccent,
                      ),
                      onTap: _onDotTapped, // Handle dot tap
                    ),
                    const SizedBox(width: 20),
                    // Adjust spacing between dropdown and dots
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              num = (num % 5) + 1; // Increment num and reset to 1 when it reaches 5
                              if (currentPage != 0) {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                                currentPage -= 1;
                              }
                            });
                          },
                          child: Text(
                            '$num',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: getColumns(),
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index.toDouble();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
  }




  List<List<LectureSlot>> getListLectureSlots() {
    List<List<LectureSlot>> list = [];

    for (int i = 0; i < 5; i++) {
      List<LectureSlot> lecture = [];
      list.add(lecture);
    }

    List<LectureSlot> lectures = widget.schedule.lectures!;

    for (int i = 0; i < lectures.length; i++) {
      int idx = lectures[i].day;
      list[idx].add(lectures[i]);
    }

    return list;
  }

  List<Widget> getColumns() {
    List<Widget> days = [];
    List<List<LectureSlot>> list = getListLectureSlots();

    for (int i = 0; i < 5 - num+1; i += 1) {
      days.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getDaysLabels(i, i + num),
          ), // This cell won't be affected by vertical scroll
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // Center the row horizontally
                children: [
                  TimeSlotWidget(
                    startTimeHour: 8,
                    endTimeHour: 20,
                    dayBool: false,
                    num: num +1,
                  ),
                  VerticalDividerWidget(numCells: 12, color: Colors.grey.shade300,),
                  ...getDays(i, i + num, list)
                ],
              ),
            ),
          ),
        ],
      ));
      // if (i != 4) days.add(VerticalDividerWidget());
    }

    return days;
  }

  List<Widget> getDays(
      int fromIndex, int toIndex, List<List<LectureSlot>> list) {
    List<Widget> widgets = [];
    for (int i = fromIndex; i < 5 && i < toIndex; i++) {
      if (i == 4 || i == toIndex-1){
        widgets.add(ColumnScheduleWidget(
          lectures: list[i],
          day: i,
          segmented: false,
          schedule: widget.schedule,
          dayBool: false,
          num: num +1,
        ));
      }else {
        widgets.add(ColumnScheduleWidget(
          lectures: list[i],
          day: i,
          segmented: false,
          schedule: widget.schedule,
          dayBool: false,
          num: num +1,
        ));
        widgets.add(
            VerticalDividerWidget(numCells: 12, color: Colors.grey.shade300,)
        );
      }
    }

    return widgets;
  }

  List<Widget> getDaysLabels(int fromIndex, int toIndex) {
    List<Widget> widgets = [];
    widgets.add(TransparentTimeSlotWidget( num: num +1,));
    widgets.add(const VerticalDividerWidget(numCells: 1, color: Colors.transparent,));
    for (int i = fromIndex; i < 5 && i < toIndex; i++) {
      if (i == 4 || i == toIndex-1){
        widgets.add(DayWidget(
          day: i,
          num: num +1,
        ));
      }else {
        widgets.add(DayWidget(
          day: i,
          num: num +1,
        ));
        widgets.add(
            const VerticalDividerWidget(numCells: 1, color: Colors.transparent,)
        );
      }
    }

    return widgets;
  }
}

