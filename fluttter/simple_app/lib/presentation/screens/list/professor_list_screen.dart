import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/schedule.dart';
import 'package:simple_app/service/professor_service.dart';
import 'package:simple_app/service/course_service.dart';

import '../../widgets/search_bar_widget.dart';
import 'lecture_list_screen.dart';

class ProfessorListScreen extends StatefulWidget {
  final Schedule schedule;
  final String courseId;
  final String courseName;

  const ProfessorListScreen(
      {super.key, required this.schedule,
      required this.courseId,
      required this.courseName});

  @override
  _ProfessorListScreenState createState() =>
      _ProfessorListScreenState(courseId, courseName);
}

class _ProfessorListScreenState extends State<ProfessorListScreen> {
  final String courseId;
  final String courseName;
  List<Professor> professors = [];
  List<Professor> filteredProfessors = [];
  ProfessorService professorService = ProfessorService();
  CourseService courseService = CourseService();
  final TextEditingController _searchController =
      TextEditingController(); // Add this line

  _ProfessorListScreenState(this.courseId, this.courseName);

  @override
  void initState() {
    super.initState();
    fetchProfessors();
  }

  Future<void> fetchProfessors() async {
    try {
      List<Professor> fetchedProfessors =
          await professorService.getProfessorsByCourseId(courseId: courseId);
      setState(() {
        professors = fetchedProfessors;
        filteredProfessors = fetchedProfessors;
        print('Fetched Professors: $professors');
      });
    } catch (e) {
      print('Error fetching professors: $e');
    }
  }

  void filterProfessors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProfessors = professors;
      } else {
        filteredProfessors = professors
            .where((professor) =>
                professor.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF123499),
          ),),
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Adjust padding as needed
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: filterProfessors,
              hintText: "Пребарај професор..",
            ),
            const SizedBox(height: 8),
            // Add some space between search bar and list
            Expanded(
              child: ListView.separated(
                itemCount: filteredProfessors.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(), // Add Divider between items
                ////////////////////////////
                itemBuilder: (context, index) {
                  Color backgroundColor = index % 2 == 0 ? Colors.transparent : Colors.grey.shade200;
                  return GestureDetector(
                    onTap: () {
                      final selectedProfessor = filteredProfessors[index];
                      String professorId = selectedProfessor.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LectureListScreen(
                            schedule: widget.schedule,
                            professorId: professorId,
                            professorName: selectedProfessor.name,
                            courseId: courseId,
                            // Pass any other necessary information to LectureSlotsScreen
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: backgroundColor, // Set background color here
                      child: ListTile(
                        title: Text(filteredProfessors[index].name),
                        // Add other professor details or actions if needed
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
