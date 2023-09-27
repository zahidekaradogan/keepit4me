// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:keepit4me/main.dart';
import 'package:keepit4me/notes.dart';
import 'package:keepit4me/notesdao.dart';

class NoteDetailPage extends StatefulWidget {

  Notes note;

  NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  var tfLessonName = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();

  Future<void> delete(int note_id) async {
    await Notesdao().deleteNote(note_id);
    debugPrint("$note_id DELETED");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ));
  }

  Future<void> update(int note_id, String lesson_name, int note1, int note2) async {
    await Notesdao().updateNote(note_id, lesson_name, note1, note2);
    debugPrint("$note_id - $lesson_name - $note1 - $note2 UPDATED");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ));
  }

  @override
  void initState() {
    super.initState();
    var note = widget.note;
    tfLessonName.text = note.lesson_name;
    tfNote1.text = note.note1.toString();
    tfNote2.text = note.note2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note Detail",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
        ),
        actions: [
          ElevatedButton(
            child: const Text("delete", style: TextStyle(color: Colors.white),),
            onPressed : (){
              delete(widget.note.note_id);
            },
          ),
          ElevatedButton(
            child: const Text("update", style: TextStyle(color: Colors.white),),
            onPressed : (){
              update(widget.note.note_id, tfLessonName.text, int.parse(tfNote1.text), int.parse(tfNote2.text));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfLessonName,
                decoration: const InputDecoration(hintText: "Lesson Name"),
              ),
              TextField(
                controller: tfNote1,
                decoration: const InputDecoration(hintText: "1st Note"),
              ),
              TextField(
                controller: tfNote2,
                decoration: const InputDecoration(hintText: "2nd Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
