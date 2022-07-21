import 'package:epoultry/services/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/report_model.dart';

class ReportsService {
  final SqliteService _sqliteService = SqliteService();
  Future<int> createItem(Report report) async {
    final Database db = await _sqliteService.initializeDB();

    final id = await db.insert('Reports', report.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Report>> getItems() async {
    final db = await _sqliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Batches');
    return queryResult.map((e) => Report.fromMap(e)).toList();
  }
}
