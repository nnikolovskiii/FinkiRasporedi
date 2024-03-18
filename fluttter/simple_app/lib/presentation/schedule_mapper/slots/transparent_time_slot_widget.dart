import 'package:flutter/material.dart';

class TransparentTimeSlotWidget extends StatefulWidget {
  int num;
  TransparentTimeSlotWidget({Key? key, this.num = 6}) : super(key: key);

  @override
  _TransparentTimeSlotWidgetState createState() =>
      _TransparentTimeSlotWidgetState();
}

class _TransparentTimeSlotWidgetState extends State<TransparentTimeSlotWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MouseRegion(
      onEnter: (event) {
        setState(() => isHovered = true);
        // Get the position and print it
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        print("Widget position: $offset");
      },
      onExit: (_) => setState(() => isHovered = false),
      child: SizedBox(
        height: 50,
        width:  (width-90)/widget.num,
      ),
    );
  }
}
