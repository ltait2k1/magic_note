import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note extends ChangeNotifier {
  String? id;
  String? title;
  dynamic? content;
  DateTime? createAt;
  DateTime? updateAt;

  Note({
    this.id,
    this.title,
    this.content,
    this.createAt,
    this.updateAt
  });
  factory Note.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Note(
        id: doc.id,
        title: doc['title'],
        content: doc['content'],
        createAt: doc['createAt']);
  }
  Note.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createAt = json['createAt'];
  }
}

