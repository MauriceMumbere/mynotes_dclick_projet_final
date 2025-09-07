import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/screens/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData(useMaterial3: true, fontFamily: "Roboto"),
      home: IntroScreen(),
    );
  }
}
