import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/screens/login_screen.dart';

import '../services/db_auth.dart';
import '../widgets/uihelper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                "Creation d'un compte",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 30),

              // email
              TextFormField(
                decoration: InputDecoration(
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
                    int res = await DBAuth.register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (res > 0) {
                      // inscription réussie
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Inscription réussie")),
                      );

                      // Redirection vers l’écran de connexion
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } else {
                      // échec (ex: email déjà existant)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Cet email est déjà utilisé")),
                      );
                    }
                  }
                },
                buttonName: 'S’inscrire',
              ),

              SizedBox(height: 8),

              Text("Ou", style: TextStyle(fontSize: 20)),

              SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: UiHelper.customText(
                  text: "Connectez vous",
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
