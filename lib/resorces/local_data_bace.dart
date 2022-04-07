import 'dart:developer';

import 'package:googlesineintry/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT ";
    const pinType = "BOLLEAN NOT NULL";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE Notes(
      ${NoteConstants.id} $idType,
      ${NoteConstants.pin} $pinType,
      ${NoteConstants.title} $textType,
      ${NoteConstants.content} $textType,
      ${NoteConstants.createTime} $textType
    )
    ''');
  }

  Future archNote(Note? note) async {
    final db = await instance.database;

    await db!.update(NoteConstants.tableName,
        {NoteConstants.isArchive: !note!.isArchieve ? 1 : 0},
        where: '${NoteConstants.id} = ?', whereArgs: [note.id]);
  }

  Future pinNote(Note? note) async {
    final db = await instance.database;

    await db!.update(
        NoteConstants.tableName, {NoteConstants.pin: !note!.pin ? 1 : 0},
        where: '${NoteConstants.id} = ?', whereArgs: [note.id]);
  }

  // Future<Note> InsertEntry(Note notes) async {
  //   final db = await instance.database;
  //   final String id =
  //       (await db!.insert(NoteConstants.tableName, notes.toJson())) as String;
  //   log(id.toString() + "inInsertEntery");
  //   return notes.copy(id: id);
  // }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NoteConstants.createTime} ASC';
    final queryResult =
        await db!.query(NoteConstants.tableName, orderBy: orderBy);

    return queryResult.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note?> findNoteById(int id) async {
    final db = await instance.database;
    final map = await db!.query(NoteConstants.tableName,
        where: '${NoteConstants.id} = ?', whereArgs: [id]);
    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future updateNote(Note note) async {
    log(note.id.toString());
    final db = await instance.database;
    await db!.update("Notes", {"title": note.title, "content": note.content},
        where: '${NoteConstants.id}=?', whereArgs: [note.id]);
    log('note updated');
  }

  Future delteNote(String? id) async {
    final db = await instance.database;
    await db!.delete((NoteConstants.tableName),
        where: '${NoteConstants.id} = ?', whereArgs: [id]);
  }

  Future<List<int>?> getNotesString(String element) async {
    if (element != "") {
      String searchString = element.trim();
      log(searchString + "hai");
      final db = await instance.database;
      final result = await db!.query(NoteConstants.tableName);

      List<int> resultList = [];

      result.forEach((element) {
        if (element["title"].toString().toLowerCase().contains(searchString) ||
            element["content"].toString().contains(searchString)) {
          resultList.add(element["id"] as int);
        }
      });

      return resultList;
    }
    return null;
  }
}
