import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/widgets/uihelper.dart';

import '../models/notes.dart';
import '../services/db_notes.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // titre
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "titre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ce champ ne doit pas etre vide";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 240,
                  child: TextFormField(
                    controller: contentController,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "Contenue",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ce champ ne doit pas etre vide";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                UiHelper.customButton(
                  callback: () async {
                    if (_formKey.currentState!.validate()) {
                      final note = Notes(
                        title: titleController.text.trim(),
                        content: contentController.text.trim(),
                      );

                      int result = await DBNotes.insertNotes(note);

                      if (result > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Note créée avec succès !")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Erreur lors de la création de la note.",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  buttonName: "Créer une note",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
