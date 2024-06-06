import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class NoteEditor extends StatefulWidget {
  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
   TextEditingController? _titleController;
  final QuillController _controllerContent = QuillController.basic();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      String imageUrl = await _uploadFile(imageFile);
      if (imageUrl.isNotEmpty) {
        final index = _controllerContent.selection.baseOffset;
        _controllerContent.document.insert(index, BlockEmbed.image(imageUrl));
      }
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      File videoFile = File(video.path);
      String videoUrl = await _uploadFile(videoFile);
      if (videoUrl.isNotEmpty) {
        final index = _controllerContent.selection.baseOffset;
        _controllerContent.document.insert(index, BlockEmbed.video(videoUrl));
      }
    }
  }

  Future<String> _uploadFile(File file) async {
    try {
      String fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      UploadTask uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: _pickVideo,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
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
            )
          ),
          Expanded(
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: _controllerContent,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('de'),
                ),
              ),
            ),
          ),
          QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _controllerContent,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('de'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}