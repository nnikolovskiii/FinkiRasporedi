import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/lecture.dart';

class SelectedLecturesProvider extends ChangeNotifier {
  final List<Lecture> _selectedLectures = [];

  List<Lecture> get selectedLectures => _selectedLectures;

  void addSelectedLecture(Lecture lecture) {
    _selectedLectures.add(lecture);
    notifyListeners();
  }
}
