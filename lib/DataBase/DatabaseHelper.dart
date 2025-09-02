import 'package:path/path.dart';
import 'package:rwad2/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Databasehelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'notes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT
      )
''');
  }

  /// CRUD operations
  Future<int> insertNote(Notes note) async {
    final dbClient = await db;
    return await dbClient.insert('notes', note.toMap());
  }

  Future<List<Notes>> getNotes() async {
    final dbClient = await db;
    final result = await dbClient.query('notes');
    return result.map((map) => Notes.FromMap(map)).toList();
  }

  Future<int> updateNote(Notes note) async {
    final dbClient = await db;
    return await dbClient.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future deleteNote(int id) async {
    final dbClient = await db;
    return await dbClient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
