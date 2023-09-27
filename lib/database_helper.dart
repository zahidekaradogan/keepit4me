// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  static const String databaseName = "notes.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = join(await getDatabasesPath(), databaseName);

    if(await databaseExists(databasePath)){
      //checking if there is a database
      if (kDebugMode) {
        print("The database already exists. No need to copy");
      }
    }else{
      //taking database from the asset
      ByteData data = await rootBundle.load("database/$databaseName");
      //Convert a byte of the database to copy.
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //copying database
      await File(databasePath).writeAsBytes(bytes,flush: true);
      if (kDebugMode) {
        print("The database has been copied");
      }
    }
    return openDatabase(databasePath);
  }

}