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
  void updateNote(Note note) {
    noteController.text = note.content;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Update Note",
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
                      noteDatabase.udpateNote(note, noteController.text);
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

  // user wants to delete note
  void deleteNote(Note note) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Delete Note?",
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                // save
                TextButton(
                    onPressed: () {
                      // create a note
                      noteDatabase.deleteNote(note);
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: Text("Delete")),
                // cancel
                TextButton(onPressed: (){
                  Navigator.pop(context);

                }, child: Text("cancel"))
              ],
            ));
  }

  // logout the username
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
        title: Text("Notes: ${currentUserEmail.toString()}",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout, color: Colors.white,))
        ],
      ),
      body: StreamBuilder(
          stream: noteDatabase.stream,
          builder: (context, snapshot) {
            // loading...
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // Item builder
            final notes = snapshot.data!;
            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  // get each notes
                  final note = notes[index];
                  // get the list of title
                  return ListTile(
                    title: Text(note.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            updateNote(note);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteNote(note);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
//
// Center(
// child: Text(
// currentUserEmail.toString(),
// style: TextStyle(fontSize: 16),
// )),
