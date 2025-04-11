import 'package:flutter/material.dart';
import 'screens/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Notes',
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
