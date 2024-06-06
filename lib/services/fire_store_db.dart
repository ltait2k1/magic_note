import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  User? user = FirebaseAuth.instance.currentUser;
  late final CollectionReference usernotes;
  FireStoreServices() {
    if (user != null) {
      usernotes = FirebaseFirestore.instance
          .collection("notes")
          .doc(user!.uid)
          .collection("usernotes");
    } else {
      usernotes = FirebaseFirestore.instance
          .collection("notes")
          .doc("0000000000")
          .collection("usernotes");
    }
  }
  Future<void> addNote(String content, String title)
  {
    return usernotes.add({
      "content": content,
      "title" : title,
      "createAt": DateTime.now(),
      "updateAt": DateTime.now(),
    }).then((_) {
      print("DATA added successfully");
  });
  }

  Stream<QuerySnapshot> getNotesStream()
  {
    final noteStream = usernotes.orderBy("updateAt", descending: true,).snapshots();
    return noteStream;
  }

 Future<void> updateNote(String docId, String newTitle, String newContent)
 {
   return usernotes.doc(docId).update({
     "title" : newTitle,
     "content" : newContent,
     "updateAt" : DateTime.now(),
   });
 }
 Future<DocumentSnapshot<Object?>> getNoteById(String id)
 {
   return usernotes.doc(id).get();
 }
  deleteNotes(String ID){

  }


}
