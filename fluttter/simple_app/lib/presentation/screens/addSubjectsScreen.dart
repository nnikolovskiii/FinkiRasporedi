import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/service/course_service.dart';
import 'package:simple_app/domain/models/course.dart';
import 'package:simple_app/presentation/screens/ProfessorListScreen.dart';
import '../../domain/models/subject.dart';
import '../widgets/SelectedLecturesProvider.dart';
import '../widgets/searchBar_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


Color myCustomColor2 = Color(0xFF42587F);

ThemeData theme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFF9DB6D),
    iconTheme: IconThemeData(color: Colors.grey),
    titleTextStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: myCustomColor2,
    brightness: Brightness.light,
  ),
);



List<Subject> subjects = [];

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => SelectedLecturesProvider(), // Adding the provider here
    child: const SearchBarApp(),
  ),
);

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Course> courses = []; // Add a list to store courses
  List<Course> filteredCourses = []; // Add a list to store courses
  CourseService _courseService = CourseService(); // Initialize CourseService
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchCourses(); // Fetch courses when the app starts
  }

  void fetchCourses() async {
    try {
      List<Course> fetchedCourses = await _courseService.getCourses();
      setState(() {

        courses = fetchedCourses;
        filteredCourses =fetchedCourses;
        // Debugging: Print the fetched courses and subjects
        print('Fetched Courses: $courses');
        isLoading = false;
      });
    } catch (e) {
      // Print error message
      print('Error fetching courses: $e');
      isLoading = false;
      // Handle error scenarios here
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Избери предмети'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search bar and suggestions
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBarWidget(
                  controller: controller,
                  onChanged: (String value) {
                  setState(() {
                  if (value.isEmpty) {
                  filteredCourses = courses;
                  print(filteredCourses.length);
                  } else {
                  filteredCourses = courses
                      .where((course) =>
                  course.subject.name?.toLowerCase().startsWith(value.toLowerCase()) ?? false)
                      .toList();
                  print(filteredCourses.length);
                  }
                  });
                  }, hintText: 'Пребарај предмет..',
                  );
                  },

                suggestionsBuilder: (
                    BuildContext context,
                    SearchController controller,
                    ) {
                  return List<Widget>.generate(filteredCourses.length, (int index) {
                    final String itemName = filteredCourses[index].subject.name ?? '';
                    return ListTile(
                      title: Text(itemName),

                    );
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Implement the filter functionality here
                  // This onPressed function will be triggered when the filter icon is pressed
                  // You can add your filter logic or open a filter dialog/pop-up
                },
              ),
              // Display the filtered list
              if (isLoading)
                 Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: Color(0xFF01579B) ,
                      rightDotColor: Colors.orange,
                      size: 80,
                    ),
                  ),
                )
              else
                 Expanded(
                child: ListView.separated(
                  itemCount: filteredCourses.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(), // Add Divider between items
                  itemBuilder: (BuildContext context, int index) {
                    final String itemName =
                        filteredCourses[index].subject.name ?? '';

                    return ListTile(
                      title: Text(itemName),
                      onTap: () {
                        String courseName = filteredCourses[index].subject.name as String;
                        String courseId = filteredCourses[index].id as String;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Притиснавте: $courseName'),
                            duration: Duration(seconds: 1),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessorListScreen(courseId: courseId, courseName : courseName), // Pass courseId as argument
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}