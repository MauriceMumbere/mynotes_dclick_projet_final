import 'package:flutter/material.dart';
import 'package:mynotes_dclick_projet_final/screens/edit_screen.dart';
import 'package:mynotes_dclick_projet_final/widgets/uihelper.dart';

import '../models/notes.dart';
import '../services/db_auth.dart';
import '../services/db_notes.dart';
import 'create_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Notes>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _notesFuture = DBNotes.getNotes();
    });
  }

  void _deleteNotes(int id) async {
    await DBNotes.deleteNotes(id);
    _loadNotes();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Note supprimée avec succès !")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiHelper.customText(
                    text: "Notes",
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Déconnexion"),
                          content: const Text(
                            "Voulez-vous vraiment vous déconnecter ?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Annuler"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await DBAuth.logout();

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text("Confirmer"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // ...
                ],
              ),
              SizedBox(height: 40),
              Expanded(
                child: FutureBuilder<List<Notes>>(
                  future: _notesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Erreur : ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "assets/images/note_empty.png",
                          height: 400,
                          width: double.infinity,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final note = snapshot.data![index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(note.title),
                              subtitle: Text(
                                note.content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Image.asset("assets/images/edit.png"),
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditNoteScreen(note: note),
                                        ),
                                      );
                                      _loadNotes();
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/images/trash.png",
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                            "Confirmer la suppression",
                                          ),
                                          content: const Text(
                                            "Voulez-vous vraiment supprimer cette note ?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Annuler"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _deleteNotes(note.id!);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Supprimer"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // ...
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          );
          _loadNotes();
        },
        backgroundColor: Colors.white,
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(Icons.add, color: Colors.black, size: 25),
      ),
    );
  }
}
