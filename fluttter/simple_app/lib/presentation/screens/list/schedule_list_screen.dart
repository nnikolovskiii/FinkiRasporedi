import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/presentation/screens/auth/authenticate.dart';
import 'package:simple_app/presentation/screens/auth/login.dart';
import 'package:simple_app/service/auth_service.dart';
import 'package:simple_app/service/schedule_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_app/service/shared_service.dart';

import '../../../domain/models/schedule.dart';
import '../add/add_schedule_screen.dart';
import '../calendar_screen.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleService scheduleService = ScheduleService();
  final Schedule schedule;
  final String theme;
  final Color bgColor;
  final Color bgColor1;
  final VoidCallback? onTap;

  ScheduleItem(
      {super.key,
      required this.schedule,
      required this.theme,
      required this.bgColor,
      required this.bgColor1,
      this.onTap});

  ScheduleItem copyWith({
    Schedule? schedule,
    String? theme,
    Color? bgColor,
    Color? bgColor1,
    VoidCallback? onTap,
  }) {
    return ScheduleItem(
      schedule: schedule ?? this.schedule,
      theme: theme ?? this.theme,
      bgColor: bgColor ?? this.bgColor,
      bgColor1: bgColor1 ?? this.bgColor1,
      onTap: onTap ?? this.onTap,
    );
  }

  confirmDelete(BuildContext context) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Потврди бришење"),
          content: const Text("Дали сте сигурни дека сакате да избришете?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Откажи"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Избриши"),
            ),
          ],
        );
      },
    );

    if (deleteConfirmed) {
      // Perform delete operation here
      await scheduleService.deleteSchedule(schedule.id ?? -1);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Избришан распоред')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            await confirmDelete(context);
          } else if (direction == DismissDirection.endToStart) {
            await confirmDelete(context);
          }
          return false;
        },
        onDismissed: (_) {},
        background: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 100, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                    15), // Adjust the border radius as needed
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Center(
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ),
        ),

        // background: Container(
        //
        //   color: Colors.red,
        //   alignment: Alignment.centerRight,
        //   padding: EdgeInsets.only(right: 20.0),
        //   child: Icon(Icons.delete, color: Colors.white),
        // ),
        // secondaryBackground: Container(
        //   color: Colors.green,
        //   alignment: Alignment.centerLeft,
        //   padding: EdgeInsets.only(left: 20.0),
        //   child: Icon(Icons.edit, color: Colors.white),
        // ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 11.0, 8.0, 15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  theme,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        schedule.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: bgColor1,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        schedule.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 5),
              ],
            ),
            // Your card UI here
          ),
        ),
      ),
    );
  }
}

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late Future<List<Schedule>> futureSchedules;
  final ScheduleService scheduleService = ScheduleService();

  @override
  void initState() {
    super.initState();
    futureSchedules = fetchSchedules();
  }

  Future<List<Schedule>> fetchSchedules() async {
    return await scheduleService.getSchedulesWithPagination();
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            // Set your desired border radius here
            // Optionally, you can add a border to the dialog as well
            side: const BorderSide(
              color: Colors.grey, // Set your desired border color here
              width: 3.0, // Set your desired border width here
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Replace 'path_to_your_image' with the path to your image asset

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF123499)),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset('resources/images/info.png'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 20,
      //   title: const Text(
      //     "Распореди",
      //     style: TextStyle(
      //       color: Color(0xFF123499),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: const Text(
          'Распореди',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF123499),
          ),
        ),
        elevation: 20,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
            child: FutureBuilder<Map<String, dynamic>?>(
              future: AuthService.getLoggedInUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return IconButton(
                    icon: const Icon(Icons.account_circle_sharp),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        snapshot.data!['username'],
                        style: const TextStyle(color: Color(0xFF123499)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          AuthService.logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            // Adjust the horizontal padding as needed
            child: IconButton(
              icon: const Icon(Icons.info_sharp),
              // Replace 'icon2' with the icon you want to use
              onPressed: () {
                _showImageDialog(context);
              },
            ),
          ),
        ],
      ),

      body: FutureBuilder<List<Schedule>>(
        future: futureSchedules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: LoadingAnimationWidget.prograssiveDots(
                  // leftDotColor: Color(0xFF01579B),
                  // rightDotColor: Colors.orange,
                  size: 80,
                  color: Colors.blue.shade800,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<ScheduleItem> scheduleItems = snapshot.data!.map((schedule) {
              return ScheduleItem(
                schedule: schedule,
                theme: "resources/images/bgImg.jpg",
                //bgColor: Color(0xFF1A237E),
                bgColor: Colors.blue.shade900.withOpacity(0.8),
                bgColor1: const Color(0xFFFFFFFF),
              );
            }).toList();

            return ListView(
              children: scheduleItems.map((scheduleItem) {
                return scheduleItem.copyWith(
                  onTap: () {
                    navigateToCalendar(scheduleItem.schedule);
                  },
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: Text('No data found'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.amber.shade600.withOpacity(0.9),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScheduleScreen()),
          );

          if (result != null) {
            setState(() {
              futureSchedules =
                  fetchSchedules(); // Call fetchSchedules again to refresh the list
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateToCalendar(Schedule schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(schedule.id ?? 0),
      ),
    );
  }
}
