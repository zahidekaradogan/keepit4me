import 'package:keepit4me/database_helper.dart';

import 'notes.dart';

class Notesdao {

  Future<List<Notes>> allNotes() async {
    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notes");

    return List.generate(maps.length, (i) {
      var line = maps[i];
      return Notes(
          line["not_id"], line["lesson_name"], line["note1"], line["note2"]);
    });
  }

  Future<void> addNote(String lesson_name, int note1, int note2) async {
    var db = await DatabaseHelper.databaseAccess();

    var info = <String,dynamic>{};

    info["lesson_name"] = lesson_name;
    info["note1"] = note1;
    info["note2"] = note2;

    await db.insert("notes", info);                                             //creating a record in a table
  }

  Future<void> updateNote(int note_id, String lesson_name, int note1, int note2) async {
    var db = await DatabaseHelper.databaseAccess();

    var info = <String,dynamic>{};

    info["lesson_name"] = lesson_name;
    info["note1"] = note1;
    info["note2"] = note2;

    await db.update("notes", info, where: "note_id=?", whereArgs: [note_id]);
  }

  Future<void> deleteNote(int note_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("notes", where: "note_id=?", whereArgs: [note_id]);
  }
}
