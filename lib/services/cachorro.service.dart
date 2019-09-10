import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_sqlite/models/cachorro.dart';

class CachorroService {
  final database = openDatabase(
    join(getDatabasesPath().toString(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    version: 1,
  );

  Future<List<Cachorro>> listar() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Cachorro(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> inserir(Cachorro dog) async {
    final Database db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizar(Cachorro dog) async {
    final db = await database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: "id = ?",
      whereArgs: [dog.id],
    );
  }

  Future<void> apagar(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}