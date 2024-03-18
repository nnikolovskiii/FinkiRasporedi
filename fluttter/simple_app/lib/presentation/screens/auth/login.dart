import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/login_request_model.dart';
import 'package:simple_app/presentation/screens/auth/signup.dart';
import 'package:simple_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:simple_app/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
              key: globalFormKey, // Assigned the globalFormKey here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(context),
                  _inputField(context),
                  _loginButton(context),
                  _signup(context),
                ],
              ),
            ),
          ),
        ));
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Username",
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
          onChanged: (val) {
            setState(() => username = val);
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          obscureText: hidePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          onChanged: (val) {
            setState(() => password = val);
          },
        ),
      ],
    );
  }

  _loginButton(context) {
    return ElevatedButton(
      onPressed: () async {
        if (globalFormKey.currentState!.validate()) {
          globalFormKey.currentState!.save();

          // Show loading indicator
          setState(() {
            isApiCallProcess = true;
          });

          // Call your API here to perform login
          // Replace the following lines with your actual API call
          Future.delayed(const Duration(seconds: 2), () async {
            // Simulate API call completion
            setState(() {
              isApiCallProcess = false;
            });

            // Check login credentials
            dynamic result = await AuthService.login(LoginRequestModel(
              username: username,
              password: password,
            ));
            if (result == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleListScreen(),
                ),
              );
            } else {
              // Show error message if login fails
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid username or password'),
                ),
              );
            }
          });
        }
      },
      child: const Text("Login"),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
