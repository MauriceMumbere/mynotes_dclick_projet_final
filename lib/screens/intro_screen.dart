import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/screens/login_screen.dart';
import 'package:mynotes_dclick_projet_final/screens/home_screen.dart';
import 'package:mynotes_dclick_projet_final/services/db_auth.dart';
import 'package:mynotes_dclick_projet_final/widgets/uiHelper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 4));

    final isLoggedIn = await DBAuth.isLoggedIn();

    if (isLoggedIn) {
      // Redirection vers HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Redirection vers LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/solar_notes-bold.png"),
            const SizedBox(height: 5),
            UiHelper.customText(
              text: "My notes",
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
