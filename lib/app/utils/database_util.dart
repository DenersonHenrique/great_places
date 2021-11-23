import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DataBaseUtil {
  static Future<sql.Database> database() async {
    final databasePath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(databasePath, 'places.db'),
      onCreate: (database, version) {
        return database.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DataBaseUtil.database();
    await database.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DataBaseUtil.database();
    return database.query(table);
  }
}
