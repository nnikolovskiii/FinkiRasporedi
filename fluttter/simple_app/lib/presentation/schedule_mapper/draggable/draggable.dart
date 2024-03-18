import 'package:flutter/material.dart';

class DraggableContainer extends StatefulWidget {
  const DraggableContainer({super.key});

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer> {
  double xPos = 0.0;
  double yPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: xPos,
          top: yPos,
          child: Draggable(
            feedback: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Drag me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            childWhenDragging: Container(), // Placeholder when dragging
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Drag me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDraggableCanceled: (_, offset) {
              setState(() {
                xPos = offset.dx;
                yPos = offset.dy;
              });
            },
            onDragEnd: (details) {
              // Use details.offset to set the new position
              setState(() {
                xPos = details.offset.dx;
                yPos = details.offset.dy;
              });
            },
          ),
        ),
      ],
    );
  }
}