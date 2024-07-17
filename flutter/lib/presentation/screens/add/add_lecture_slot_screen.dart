import 'package:flutter/material.dart';
import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../widgets/color_picker_widget.dart';

bool isOverlapping(Schedule schedule, LectureSlot lec,
    {LectureSlot? currentLecture}) {
  List<LectureSlot> lectures = schedule.lectures ?? [];
  for (LectureSlot lec1 in lectures) {
    if (currentLecture != null && lec1 == currentLecture) {
      continue;
    }
    if (lec1.day == lec.day) {
      bool overlap =
          ((lec1.timeFrom >= lec.timeFrom && lec1.timeFrom < lec.timeTo) ||
              (lec1.timeTo > lec.timeFrom && lec1.timeTo <= lec.timeTo) ||
              (lec1.timeFrom <= lec.timeFrom && lec1.timeTo >= lec.timeTo));

      if (overlap) {
        return true;
      }
    }
  }
  return false;
}

class FieldScreen extends StatefulWidget {
  final Schedule schedule;
  final LectureSlot? lectureSlot;

  const FieldScreen({
    super.key,
    required this.schedule,
    this.lectureSlot,
  });

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController abbreviationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedDayIndex = 0;
  int selectedTimeFrom = 8;
  int selectedTimeTo = 9;

  @override
  void initState() {
    super.initState();
    if (widget.lectureSlot != null) {
      nameController.text = widget.lectureSlot!.name ?? "";
      abbreviationController.text = widget.lectureSlot!.abbreviation ?? "";
      selectedDayIndex = widget.lectureSlot!.day;
      selectedTimeFrom = widget.lectureSlot!.timeFrom.toInt();
      selectedTimeTo = widget.lectureSlot!.timeTo.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> hours = List<int>.generate(13, (index) => index + 8);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.lectureSlot?.lecture == null) ...[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Име",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xFF123499).withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.drive_file_rename_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Името е задолжително';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: abbreviationController,
                  decoration: InputDecoration(
                      hintText: "Кратенка",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xFF123499).withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.short_text)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Кратенката е задолжителна';
                    }
                    if (value.length > 5) {
                      return 'Кратенката мора да биде до 5 букви';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],
              DropdownButtonFormField<int>(
                value: selectedDayIndex,
                onChanged: (int? newIndex) {
                  setState(() {
                    selectedDayIndex = newIndex!;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Day",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color(0xFF123499).withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                items: const [
                  DropdownMenuItem<int>(value: 0, child: Text('Понеделник')),
                  DropdownMenuItem<int>(value: 1, child: Text('Вторник')),
                  DropdownMenuItem<int>(value: 2, child: Text('Среда')),
                  DropdownMenuItem<int>(value: 3, child: Text('Четврток')),
                  DropdownMenuItem<int>(value: 4, child: Text('Петок')),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Изборот на ден е задолжителен';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedTimeFrom,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedTimeFrom = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Од (часот)',
                            hintText: "Од ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFF123499).withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.access_time),
                          ),
                          items: hours.map((hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text(hour.toString()),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedTimeTo,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedTimeTo = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'До (часот)',
                            hintText: "до",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFF123499).withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.access_time),
                          ),
                          items: hours.map((hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text(hour.toString()),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value <= selectedTimeFrom) {
                              return 'Времето до мора да биде поголемо од времето од';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String? name = nameController.text;
                          if (name == "") {
                            name = null;
                          }
                          String abbreviation = abbreviationController.text;

                          if (widget.lectureSlot == null ||
                              widget.lectureSlot!.lecture == null) {
                            LectureSlot newLectureSlot = LectureSlot(
                              name: name,
                              abbreviation: abbreviation,
                              day: selectedDayIndex,
                              timeFrom: selectedTimeFrom,
                              timeTo: selectedTimeTo,
                            );

                            if (isOverlapping(
                                widget.schedule, newLectureSlot)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Overlap Warning'),
                                    content: const Text(
                                        'The selected lecture overlaps with an existing one.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ColorPickerScreen(
                                    schedule: widget.schedule,
                                    lectureSlot: newLectureSlot,
                                    update: false,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  Navigator.pop(context, true);
                                }
                              });
                            }
                          } else {
                            widget.lectureSlot!.name = name;
                            widget.lectureSlot!.abbreviation = abbreviation;
                            widget.lectureSlot!.day = selectedDayIndex;
                            widget.lectureSlot!.timeFrom = selectedTimeFrom;
                            widget.lectureSlot!.timeTo = selectedTimeTo;

                            if (isOverlapping(
                                widget.schedule, widget.lectureSlot!,
                                currentLecture: widget.lectureSlot)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Overlap Warning'),
                                    content: const Text(
                                        'The selected lecture overlaps with an existing one.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ColorPickerScreen(
                                    schedule: widget.schedule,
                                    lectureSlot: widget.lectureSlot!,
                                    update: true,
                                    color: widget.lectureSlot!.hexColor,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  Navigator.pop(context, true);
                                }
                              });
                            }
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
