import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/note_editor.dart';
import 'package:note_app/style/app_style.dart';

class NoteReader extends StatefulWidget {
  NoteReader({
    Key key,
    @required this.doc,
  }) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  _NoteReaderState createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int color_id = int.parse(widget.doc['color_id']);

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => NoteEditor()),),);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[color_id],
        titleTextStyle: TextStyle(color: Colors.black),
        title: Text(
          widget.doc['note_title'],
          style: AppStyle.mainTitle,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              widget.doc['creation_date'],
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.doc['note_content'],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
