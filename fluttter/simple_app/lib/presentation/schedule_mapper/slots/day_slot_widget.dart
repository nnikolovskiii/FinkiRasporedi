import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final int day;
  int num;
  static const Map<int, String> daysMap = {
    0: "Понделник",
    1: "Вторник",
    2: "Среда",
    3: "Четврток",
    4: "Петок"
  };

  DayWidget({super.key, required this.day, this.num = 6});


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 50,
      width: (width-90)/num,
      child: Center(
        child: Text(
          daysMap[day]!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
              color: Color(0xFF3585b8),
          ), // Replace with your actual text
        ),
      ),
    );
  }
}

