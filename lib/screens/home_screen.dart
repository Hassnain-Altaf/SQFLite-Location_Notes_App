import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_helper.dart';
import '../models/note_model.dart';
import 'add_note_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> noteList;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  void refreshNotes() {
    setState(() {
      noteList = DatabaseHelper().getNotes();
    });
  }

  void deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);
    refreshNotes();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Notes',
          style: TextStyle(color: Colors.white), // Make title text white
        ),
        backgroundColor: Color(0xFF6200EA), // Deep Purple
        iconTheme: IconThemeData(color: Colors.white), // Make icons white
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: noteList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;
          if (notes.isEmpty) return Center(child: Text("No notes yet."));

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, i) {
              final note = notes[i];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: note.imagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(note.imagePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: const Color.fromARGB(255, 243, 238, 238),
                        ),
                  title: Text(
                    note.locationName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    note.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Color(0xFF6200EA)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddNoteScreen(
                                note: note,
                                onSave: refreshNotes,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => deleteNote(note.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteScreen(onSave: refreshNotes),
          ),
        ),
        backgroundColor: Color(0xFF6200EA), // Deep Purple
        child: Icon(Icons.add),
      ),
    );
  }
}
