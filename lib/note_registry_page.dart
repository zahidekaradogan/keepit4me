// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:keepit4me/main.dart';
import 'package:keepit4me/notesdao.dart';

class NoteRegistryPage extends StatefulWidget {
  const NoteRegistryPage({Key? key}) : super(key: key);

  @override
  State<NoteRegistryPage> createState() => _NoteRegistryPageState();
}

class _NoteRegistryPageState extends State<NoteRegistryPage> {
  var tfLessonName = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();

  Future<void> register(String lesson_name, int note1, int note2) async {
    await Notesdao().addNote(lesson_name, note1, note2);
    //debugPrint("$lesson_name - $note1 - $note2 SAVED");
    Navigator.push(context, MaterialPageRoute( builder: (context) => const Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note Registry",
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          register(tfLessonName.text, int.parse(tfNote1.text), int.parse(tfNote2.text));
        },
        tooltip: 'note registration',
        icon: const Icon(Icons.save),
        label: const Text("SAVE"),
      ),
    );
  }
}
