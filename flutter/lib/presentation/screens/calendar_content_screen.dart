import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/day_slot_widget.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';
import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';
import '../schedule_mapper/column_schedule_widget.dart';
import '../schedule_mapper/time_column_widget.dart';
import '../schedule_mapper/slots/vertical_divider_widget.dart';

class CalendarContentScreen extends StatefulWidget {
  final Schedule schedule;

  const CalendarContentScreen({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  _HorizontalSwipeScreenState createState() => _HorizontalSwipeScreenState();
}

class _HorizontalSwipeScreenState extends State<CalendarContentScreen> {
  late final PageController controller;
  double currentPage = 0;
  int num = 5; // Set default value for num
  bool showAllDays = true;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onPageChanged);
    controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      currentPage = controller.page ?? 0;
    });
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
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && currentPage > 0) {
            controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          } else if (details.delta.dx < 0 && currentPage < (5 - num).toDouble()) {
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
                if (!showAllDays)
                  DotsIndicator(
                    dotsCount: 5 - num + 1,
                    position: currentPage,
                    decorator: const DotsDecorator(
                      color: Colors.grey,
                      activeColor: Colors.blueAccent,
                    ),
                    onTap: _onDotTapped,
                  ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAllDays = !showAllDays;
                      num = showAllDays ? 5 : 1;
                      if (showAllDays) {
                        controller.jumpToPage(0);
                        currentPage = 0;
                      }
                    });
                  },
                  child: Text(
                    showAllDays ? 'Show One Day' : 'Show All Days',
                    style: const TextStyle(color: Colors.black),
                  ),
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

    for (int i = 0; i < 5 - num + 1; i++) {
      days.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getDaysLabels(i, i + num),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeColumnWidget(
                    startTimeHour: 8,
                    endTimeHour: 20,
                    dayBool: false, 
                    allDays: showAllDays,
                  ),
                  VerticalDividerWidget(
                    numCells: 12,
                    color: Colors.grey.shade300,
                  ),
                  ...getDays(i, i + num, list)
                ],
              ),
            ),
          ),
        ],
      ));
    }

    return days;
  }

  List<Widget> getDays(int fromIndex, int toIndex, List<List<LectureSlot>> list) {
    List<Widget> widgets = [];
    for (int i = fromIndex; i < 5 && i < toIndex; i++) {
      widgets.add(ColumnScheduleWidget(
        lectures: list[i],
        day: i,
        schedule: widget.schedule,
        dayBool: false, allDays: showAllDays,
      ));
      if (i < toIndex - 1) {
        widgets.add(VerticalDividerWidget(
          numCells: 12,
          color: Colors.grey.shade300,
        ));
      }
    }
    return widgets;
  }

  List<Widget> getDaysLabels(int fromIndex, int toIndex) {
    List<Widget> widgets = [];
    widgets.add(TransparentTimeSlotWidget(allDays: showAllDays,));
    widgets.add(const VerticalDividerWidget(
      numCells: 1,
      color: Colors.transparent,
    ));
    for (int i = fromIndex; i < 5 && i < toIndex; i++) {
      widgets.add(DayWidget(day: i, allDays: showAllDays,));
      if (i < toIndex - 1) {
        widgets.add(const VerticalDividerWidget(
          numCells: 1,
          color: Colors.transparent,
        ));
      }
    }
    return widgets;
  }
}
