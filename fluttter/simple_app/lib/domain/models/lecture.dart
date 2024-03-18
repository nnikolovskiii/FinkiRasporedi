import 'package:simple_app/domain/models/course.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';


class Lecture {
  int id;
  String? name;
  int day;
  int timeFrom;
  int timeTo;
  Professor professor;
  Course course;
  Room room;

  Lecture({
    required this.id,
    required this.name,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professor,
    required this.course,
    required this.room,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
        id: json['id'],
        name: json['name'],
        day: json['day'],
        timeFrom: json['timeFrom'],
        timeTo: json['timeTo'],
        professor: Professor.fromJson(json['professor']),
        course: Course.fromJson(json['course']),
        room: Room.fromJson(json['room']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'professor': professor.toJson(),
      'course': course.toJson(),
      'room': room.toJson(),
    };
  }
}
