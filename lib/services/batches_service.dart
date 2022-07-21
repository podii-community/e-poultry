import 'package:epoultry/models/batch_model.dart';
import 'package:epoultry/services/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

class BatchesService {
  final SqliteService _sqliteService = SqliteService();
  Future<int> createItem(Batches batch) async {
    final Database db = await _sqliteService.initializeDB();
    final id = await db.insert('Batches', batch.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Batches>> getItems() async {
    final db = await _sqliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Batches');
    return queryResult.map((e) => Batches.fromMap(e)).toList();
  }
}
