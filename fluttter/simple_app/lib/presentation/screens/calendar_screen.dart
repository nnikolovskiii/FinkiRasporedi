import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:simple_app/presentation/screens/swipe_screen.dart';
import 'package:simple_app/presentation/theme/app_theme.dart';
import 'package:simple_app/service/schedule_service.dart';

import '../../domain/models/schedule.dart';
import '../widgets/ActionButton.dart';
import '../widgets/ExpandableFab.dart';
import 'add/add_lecture_slot_screen.dart';
import 'list/course_list_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: CalendarScreen(1),
  ));
}

class CalendarScreen extends StatefulWidget {
  final int scheduleId;

  const CalendarScreen(this.scheduleId, {super.key});

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarScreen> {
  final ScheduleService scheduleService = ScheduleService();
  Schedule? scheduleFuture;

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    Schedule schedule = await scheduleService.getSchedule(widget.scheduleId);
    setState(() {
      scheduleFuture = schedule;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: brightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleListScreen(),
                ),
              );
            },
            child: const Text(
              'Распоред',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF123499),
              ),
            ),
          ),
          elevation: 20,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: HorizontalSwipeScreen(schedule: scheduleFuture!, segmented: false),

                // child: ScheduleWidget(
                //   schedule: scheduleFuture!,
                //   segmented: false,
                // ),

              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.prograssiveDots(
                    // leftDotColor: Color(0xFF01579B),
                    // rightDotColor: Colors.orange,
                    size: 80,
                    color: Colors.blue.shade800,
                  ),
                ),
              ), // Loading indicator
            ),
          ],
        ),
        floatingActionButton: ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const ScheduleListScreen(),

                ),
                );
              },
              icon: const Icon(Icons.save),
             // label: "Зачувај",
            ),

            Row(
              children: [
                const Text("Custom" , style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A2472)),),
                const SizedBox(width: 5,),
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldScreen(schedule: scheduleFuture!),
                      ),
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('Распоредот е зачуван'),
                    //     duration: Duration(seconds: 2),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.dashboard_customize),
                  //label: "Custom",
                ),
              ],
            ),

            ActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                  ),
                );
              },
             // label: "Постоечки",
              icon: const Icon(Icons.add_circle_outlined),

            ),

          ],
        ),


      ),
    );
  }
}
