import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final int day;
  int num;
  static const Map<int, String> daysMap = {
    0: "ПОН",
    1: "ВТО",
    2: "СРЕ",
    3: "ЧЕТ",
    4: "ПЕТ"
  };

  DayWidget({super.key, required this.day, this.num = 6});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    height = (height-50)/18;

    return Container(
      height: height,
      width: (width - 90) / num, // Adjust according to your layout requirements
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown, // Use scaleDown to fit the text within the available space
          child: Text(
            daysMap[day]!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3585b8),
            ),
            textAlign: TextAlign.center, // Center the text
            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
          ),
        ),
      ),
    );
  }
}

