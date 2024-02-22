import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/provider.dart';
import 'package:task_1/signin_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SignProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
