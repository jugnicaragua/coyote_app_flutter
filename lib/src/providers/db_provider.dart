import 'dart:io';

import 'package:coyote_app/src/models/banks.dart';
import 'package:coyote_app/src/models/centralBank.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'CoyoteDb.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("""
      CREATE TABLE Bank(
        id INTEGER PRIMARY KEY ON CONFLICT REPLACE,
        bestSellPrice INTEGER,
        date TEXT,
        bank TEXT,
        sell REAL,
        buy REAL,
        currency TEXT,
        bestBuyPrice INTEGER,
        createdOn TEXT,
        updatedOn text
      );
      """);
      await db.execute("""
      CREATE TABLE CentralBank(
        id INTEGER PRIMARY KEY ON CONFLICT REPLACE,
        amount REAL,
        date TEXT,
        currency TEXT,
        createdOn TEXT,
        updatedOn TEXT
      );""");
    });
  }

  Future<void> insertCentralBank(String table, CentralBank centralBank) async {
    await database.then((db) => {db.insert(table, centralBank.toJson())});
  }

  Future<CentralBank> centralBankSelectByDate(String date) async {
    final db = await database;
    print(date);
    final map = await db.query(
      'CentralBank',
      columns: null,
      where: 'date = ?',
      whereArgs: [date],
    );
    return (map.length > 0) ? CentralBank.fromJson(map.first) : null;
  }

  Future<void> insertAll(String table, List<Bank> banks) async {
    await database.then((db) {
      banks.forEach((element) {
        db.insert(table, element.toJson());
      });
    });
  }

  Future<List<Bank>> selectByDate(String date) async {
    final db = await database;
    final maps = await db.query(
      "Bank",
      columns: null,
      where: 'createdOn = ?',
      whereArgs: [date],
    );
    return (maps.length > 0) ? maps.map((e) => Bank.fromDb(e)).toList() : [];
  }

  Future<List<Bank>> select() async {
    final db = await database;
    final maps = await db.query(
      "Bank",
      columns: null,
    );
    return (maps.length > 0) ? maps.map((e) => Bank.fromJson(e)).toList() : [];
  }
}
