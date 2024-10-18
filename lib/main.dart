import 'package:flutter/material.dart';
import 'package:uts_project_syifa/screens/home.dart';
import 'package:uts_project_syifa/screens/login_page.dart';
import 'package:uts_project_syifa/screens/register_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login/register flutter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context)=> LoginPage(),
        '/register': (context) => RegisterPage(),
        '/Home': (context)=> Home(),
      },
    );
  }
}
