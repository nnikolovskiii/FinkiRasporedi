import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:simple_app/domain/models/lecture_slots.dart';

import '../../domain/models/schedule.dart';
import '../../service/lecture_slot_service.dart';
import '../../service/schedule_service.dart';
import '../screens/calendar_screen.dart';



class ColorPickerScreen extends StatefulWidget {
  final Schedule schedule;
  final LectureSlot lectureSlot;
  final bool update;
  final ScheduleService scheduleService =
  ScheduleService();
  final LectureSlotService lectureSlotService =
  LectureSlotService();
  final String? color;

  ColorPickerScreen({super.key, 
    required this.schedule,
    required this.lectureSlot, required this.update, this.color,
  });

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  late Color selectedColor; // Initial color
  TextEditingController hexController = TextEditingController();


  @override
  void initState() {
    selectedColor = HexColor.fromHex(widget.color??"#808080");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Center(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                  hexController.text = color.toHex().toUpperCase();
                });
              },
              showLabel: true,
              enableAlpha: false,

            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: hexController,
              decoration: InputDecoration(
                labelText: 'Enter Hex Color',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    _updateColorFromHex();
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Selected Color',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Hex: ${selectedColor.toHex()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    widget.lectureSlot.hexColor = selectedColor.toHex().toString();

                    if (widget.update){
                      await widget.lectureSlotService
                          .updateLectureSlot(
                          widget.lectureSlot.id ?? 0, widget.lectureSlot);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CalendarScreen(widget.schedule.id ?? 0),
                        ),
                      );
                    }else {
                      await widget.scheduleService
                          .addLecture(
                          widget.schedule.id ?? 0, widget.lectureSlot);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CalendarScreen(widget.schedule.id ?? 0),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Use Color'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateColorFromHex() {
    String hexCode = hexController.text.trim();
    if (RegExp(r'^#?[0-9A-Fa-f]{6}$').hasMatch(hexCode)) {
      setState(() {
        selectedColor = HexColor.fromHex(hexCode);
      });
    }
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex() {
    return '#${value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
