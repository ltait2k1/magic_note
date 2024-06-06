import 'package:flutter/material.dart';
import 'package:magic_note/services/fire_store_db.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  final String id;
  final String title;
  final String content;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: () {
              final updatedTitle = _titleController.text;
              final updatedContent = _contentController.text;
              FireStoreServices().updateNote(
                widget.id,
                updatedTitle,
                updatedContent,
              ).then((_) {
                Navigator.pop(context, true);
              });
            },
            icon: Icon(Icons.save_outlined),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              cursorColor: Colors.grey,
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              height: 300,
              child: TextField(
                controller: _contentController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.multiline,
                minLines: 50,
                maxLines: null,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Note",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
