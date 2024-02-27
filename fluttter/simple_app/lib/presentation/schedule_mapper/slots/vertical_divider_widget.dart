import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class VerticalDividerWidget extends StatelessWidget {
  final double  numCells;
  final Color color;
  const VerticalDividerWidget({super.key, required this.numCells, required this.color});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    height = (height-50)/18;
    return Container(
        padding: const EdgeInsets.all(5.0),

    child:Container(
      width: 2.0, // Adjust the width as needed
      height: (height+2)*numCells+6*numCells, // Set height to fill available vertical space
      color: color, // Set the color of the vertical line
    ));
  }
}
