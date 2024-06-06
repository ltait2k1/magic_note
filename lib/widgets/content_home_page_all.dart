import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:magic_note/views/edit_note_quill.dart';
import 'package:magic_note/views/note_view_screen.dart';
import '../services/fire_store_db.dart';
import '../views/test_picker.dart';

class ContentHomePage extends StatelessWidget {
  final bool isGridView;
  const ContentHomePage({super.key, required this.isGridView});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreServices().getNotesStream(),
      builder: (context, snapshot) {
        if(user == null)
          return Center(child: Text('Please log in'));
        else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Please create a new note'));
          } else {
            final documents = snapshot.data!.docs;
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: !isGridView
                  ? StaggeredGridView.countBuilder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: documents.length,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final data = document.data() as Map<String, dynamic>;
                  final title = data["title"] ?? "";
                  final content = data["content"] ?? "";
                  final id = document.id;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteEditor(

                              ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          Text(
                            content
                                .toString()
                                .length <= 200
                                ? content
                                : "${content.toString().substring(
                                0, 200)}.........",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final data = document.data() as Map<String, dynamic>;
                  final title = data["title"] ?? "";
                  final content = data["content"] ?? "";
                  final id = document.id;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteViewScreen(
                                id: id,
                                content: content,
                                title: title,
                              ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          Text(
                            content
                                .toString()
                                .length <= 200
                                ? content
                                : "${content.toString().substring(
                                0, 200)}.........",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
