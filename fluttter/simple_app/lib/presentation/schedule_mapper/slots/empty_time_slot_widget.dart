import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  final bool segmented;
  int num;

  EmptyTimeSlotWidget({super.key, required this.segmented, this.num = 6});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    height = (height-50)/18;
    return Stack(
      children: [
        Container(
          height: height,
          width:  (width-90)/num,

        ),
        if (segmented) // Only include TransparentTimeSlotWidget if segmented is true
           Positioned(
            top: 0,
            left: 0,
            child: TransparentTimeSlotWidget(num: num,),
          ),
      ],
    );
  }
}
