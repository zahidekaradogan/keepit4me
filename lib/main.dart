import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keepit4me/note_detail_page.dart';
import 'package:keepit4me/note_registry_page.dart';
import 'package:keepit4me/notesdao.dart';

import 'notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'keepit4me',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List<Notes>> showAllNotes() async {
    var noteList = await Notesdao().allNotes();
    return noteList;
  }

  Future<bool> closeApp() async {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: (const Icon(Icons.arrow_back)),
            onPressed: () {
              closeApp();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              FutureBuilder<List<Notes>>(
                future: showAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var noteList = snapshot.data;
                    double average = 0.0;
                    if (noteList!.isNotEmpty) {
                      double total = 0.0;
                      for (var n in noteList) {
                        total = total + ((n.note1 + n.note2) / 2);
                      }
                      average = total / noteList.length;
                    }
                    return Text(
                      "Average : ${average.toInt()}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    );
                  } else {
                    return const Text(
                      "Average : 0",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    );
                  }
                },
              )
            ],
          )),
      body: WillPopScope(
        onWillPop: closeApp,
        child: FutureBuilder<List<Notes>>(
            future: showAllNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var noteList = snapshot.data;
                return ListView.builder(
                    itemCount: noteList!.length,
                    itemBuilder: (context, indexs) {
                      var note = noteList[indexs];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteDetailPage(
                                  note: note,
                                ),
                              ));
                        },
                        child: Card(
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  note.lesson_name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(note.note1.toString()),
                                Text(note.note2.toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteRegistryPage(),
              ));
        },
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
