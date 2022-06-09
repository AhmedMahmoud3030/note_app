import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/style/app_style.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({Key key}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  int colors_id = Random().nextInt(AppStyle.cardsColor.length);
  String formattedDate =
      DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now());

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.secoundaryColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection('notes').add({
            'color_id': colors_id.toString(),
            'creation_date': formattedDate,
            'note_title': _titleController.text,
            'note_content': _mainController.text,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((err) => print('faield to add new note due $err'));
        },
        child: Icon(Icons.save_rounded),
      ),
      backgroundColor: AppStyle.cardsColor[colors_id],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[colors_id],
        elevation: 0,
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note Title'),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              formattedDate,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note Content'),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
