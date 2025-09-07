// edit_note_screen.dart

import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/widgets/uihelper.dart';

import '../models/notes.dart';
import '../services/db_notes.dart';

class EditNoteScreen extends StatefulWidget {
  final Notes note;

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _updateNote() async {
    if (_formKey.currentState!.validate()) {
      final updatedNote = Notes(
        id: widget.note.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );

      await DBNotes.updateNotes(updatedNote);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Note mise à jour avec succès!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modifier la note")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Titre
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Titre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ce champ ne doit pas être vide";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Contenu
                SizedBox(
                  height: 240,
                  child: TextFormField(
                    controller: _contentController,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "Contenu",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ce champ ne doit pas être vide";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Bouton de soumission
                UiHelper.customButton(
                  callback: _updateNote,
                  buttonName: "Enregistrer les modifications",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
