import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'epoultry.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Batches(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,type TEXT NOT NULL,age TEXT NOT NULL,quantity TEXT NOT NULL,units TEXT NOT NULL,date TEXT NOT NULL )",
        );
        await database.execute(
          "CREATE TABLE Reports(id INTEGER PRIMARY KEY AUTOINCREMENT, reduceBy TEXT NOT NULL,reason TEXT NOT NULL,typeOfFeed TEXT NOT NULL,quantity TEXT NOT NULL,units TEXT NOT NULL,measurement TEXT NOT NULL,eggsCollected TEXT NOT NULL,mediumEggs TEXT NOT NULL,largeEggs TEXT NOT NULL,fullyBroken TEXT NOT NULL,partiallyBroken TEXT NOT NULL,deformedEggs TEXT NOT NULL,comment TEXT NOT NULL,date TEXT NOT NULL, )",
        );
      },
      version: 1,
    );
  }
}
