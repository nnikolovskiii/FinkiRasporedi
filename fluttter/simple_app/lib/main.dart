import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/auth/login.dart';
import '../presentation/screens/list/schedule_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScheduleListScreen(),
      routes: {
        '/home': (context) => const ScheduleListScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
