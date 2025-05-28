import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/forgot_password_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login' : (_) => LoginScreen(),
        '/signup': (_) => SignUpScreen(),
        '/forgot': (_) => ForgotPasswordScreen(),
        '/home'  : (_) => HomeScreen(),
      },
    );
  }
}

