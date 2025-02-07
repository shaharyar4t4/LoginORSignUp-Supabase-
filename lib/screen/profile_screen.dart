import 'package:flutter/material.dart';
import 'package:loginsupabase/auth/auth_services.dart';
import 'package:loginsupabase/services/note.dart';
import 'package:loginsupabase/services/note_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthServices _authServices = AuthServices();
  final noteDatabase = NoteDaabase();
  final TextEditingController noteController = TextEditingController();

  // user wants to add a new note
  void addNote() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Add Note",
                style: TextStyle(fontSize: 16),
              ),
              content: TextField(
                controller: noteController,
                decoration: InputDecoration(
                    hintText: "Enter your note here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: [
                // save
                TextButton(
                    onPressed: () {
                      // create a note
                      final newNote = Note(content: noteController.text);
                      noteDatabase.createNote(newNote);
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: Text("Save")),
                // cancel
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  // user wants to update note

  // user wants to delete note

  void logout() async {
    await _authServices.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = _authServices.getCurrenUserEmail();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Text(
        currentUserEmail.toString(),
        style: TextStyle(fontSize: 16),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
