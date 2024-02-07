import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  final bool segmented;

  const EmptyTimeSlotWidget({super.key, required this.segmented});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: const Border(
              top: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            // Adjust the radius as needed
          ),
        ),
        if (segmented) // Only include TransparentTimeSlotWidget if segmented is true
          const Positioned(
            top: 0,
            left: 0,
            child: TransparentTimeSlotWidget(),
          ),
      ],
    );
  }
}