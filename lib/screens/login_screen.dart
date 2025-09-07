import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/screens/home_screen.dart';
import 'package:mynotes_dclick_projet_final/screens/register_screen.dart';

import '../services/db_auth.dart';
import '../widgets/uihelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Connexion au compte",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 30),
              // email
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/images/email.png"),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return "Email invalide";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/images/password.png"),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              // submit button
              UiHelper.customButton(
                callback: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await DBAuth.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (user != null) {
                      //Connexion réussie
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Connexion réussie")),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      // Identifiants incorrects
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Email ou mot de passe incorrect"),
                        ),
                      );
                    }
                  }
                },
                buttonName: 'Se connecter',
              ),
              SizedBox(height: 8),
              Text("Ou", style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: UiHelper.customText(
                  text: "Cree un compte",
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
