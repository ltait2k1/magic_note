import 'package:flutter/material.dart';

import '../services/fire_store_db.dart';

class CreatNoteView extends StatefulWidget {
  const CreatNoteView({super.key});

  @override
  State<CreatNoteView> createState() => _CreatNoteViewState();
}

class _CreatNoteViewState extends State<CreatNoteView> {
  String title ="";
  String content="";
  TextEditingController? titleController;
  TextEditingController? contentController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: (){
              FireStoreServices().addNote(content, title);
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
              controller: titleController,
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
                      color: Colors.grey.withOpacity(0.8)
                  )
              ), onChanged: (value){
                title = value;
            },
            ),
            Container(
              height: 300,
              child: TextField(
                controller: contentController,
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
                        color: Colors.grey.withOpacity(0.8)
                    )
                ),
                onChanged: (value){
                  content = value;
                },

              ),
            )

          ],
        ),
      ),
    );
  }
}
