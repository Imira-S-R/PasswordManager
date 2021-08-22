import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:password_manager/model/password_model.dart';

class PasswordDatabase {
  static final PasswordDatabase instance = PasswordDatabase._init();

  static Database? _database;

  PasswordDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('password_info.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${PasswordFields.id} $idType, 
  ${PasswordFields.title} $textType,
  ${PasswordFields.username} $textType,
  ${PasswordFields.password} $textType
  )
''');
  }

  Future<Password> create(Password password) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, password.toJson());
    return password.copy(id: id);
  }

  Future<Password> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: PasswordFields.values,
      where: '${PasswordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Password.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Password>> readAllNotes() async {
    final db = await instance.database;

    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes);

    return result.map((json) => Password.fromJson(json)).toList();
  }

  Future<int> update(Password password) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      password.toJson(),
      where: '${PasswordFields.id} = ?',
      whereArgs: [password.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${PasswordFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
