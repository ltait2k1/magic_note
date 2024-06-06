import 'package:flutter/material.dart';
import 'package:magic_note/views/edit_note_view.dart';

import '../services/fire_store_db.dart';

class NoteViewScreen extends StatefulWidget {
  const NoteViewScreen({
    super.key,
    required this.id,
    required this.content,
    required this.title,
  });

  final String id;
  final String content;
  final String title;

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _content = widget.content;
  }

  Future<void> _editNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteView(
          id: widget.id,
          title: _title,
          content: _content,
        ),
      ),
    );

    if (result == true) {
      // Reload the note
      // Fetch the updated note from Firestore (assuming you have a method for this)
      final updatedNote = await FireStoreServices().getNoteById(widget.id);
      setState(() {
        _title = updatedNote["title"];
        _content = updatedNote["content"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.push_pin_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.archive_outlined)),
          IconButton(
            onPressed: _editNote,
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            SizedBox(height: 10), // Add some spacing
            Text(_content),
          ],
        ),
      ),
    );
  }
}
