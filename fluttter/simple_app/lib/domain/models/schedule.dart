
import 'lecture_slots.dart';

class Schedule {
  int? id;
  String name;
  String description;
  List<LectureSlot>? lectures;

  Schedule({
    this.id,
    required this.name,
    required this.description,
    this.lectures,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    List<LectureSlot>? lectures;
    if(json["lectures"] != null) {
      var lectureList = json['lectures'] as List<dynamic>;
      lectures = lectureList.map((lectureJson) =>
          LectureSlot.fromJson(lectureJson)).toList();
    }
    return Schedule(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      lectures: lectures,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? lecturesJson;
    if (lectures != null) {
      lecturesJson = lectures!.map((lecture) => lecture.toJson()).toList();
    }

    if (id == null || lecturesJson == null) {
      return {
        'name': name,
        'description': description,
      };
    }else{
      return {
        'id': id,
        'name': name,
        'description': description,
        'lectures': lecturesJson,
      };
    }
  }

}