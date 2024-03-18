import 'package:flutter/material.dart';

class DraggableExample extends StatefulWidget {
  final Function(RenderBox) onStateChange;

  const DraggableExample({Key? key, required this.onStateChange}) : super(key: key);

  @override
  _DraggableExampleState createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  final GlobalKey _draggableKey = GlobalKey();
  Offset _offset = const Offset(200, 250);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Your background widget (MyTable() in this case)
              // Draggable Widget
              Positioned(
                left: _offset.dx,
                top: _offset.dy,
                child: LongPressDraggable(
                  feedback: Container(
                    key: _draggableKey,
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  onDragEnd: (details) {
                    setState(() {
                      double adj = MediaQuery.of(context).size.height - constraints.maxHeight;
                      _offset = Offset(details.offset.dx, details.offset.dy - adj);
                    });
                  },
                  onDragUpdate: (details) {
                    RenderBox renderBox =
                    _draggableKey.currentContext!.findRenderObject() as RenderBox;
                    // print(
                    //     'Position: ${renderBox.localToGlobal(Offset.zero)}, '
                    //         'Size: ${renderBox.size}');

                    widget.onStateChange(renderBox);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}