// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper {
//   DBHelper._();
//   static final DBHelper getInstance = DBHelper._();
//
//   static const String Table_Name = "note";
//   static const String Column_sn = "s_no";
//   static const String Column_title = "title";
//   static const String Column_desc =
//       "description"; // ✅ changed from desc → description
//
//   Database? myDB;
//
//   Future<Database> getDB() async {
//     myDB ??= await openDB();
//     return myDB!;
//   }
//
//   Future<Database> openDB() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String dbPath = join(directory.path, "noteDB.db");
//
//     return await openDatabase(
//       dbPath,
//       version: 1,
//       onCreate: (db, version) async {
//         /// create tables
//         await db.execute('''
//           CREATE TABLE $Table_Name (
//             $Column_sn INTEGER PRIMARY KEY AUTOINCREMENT,
//             $Column_title TEXT,
//             $Column_desc TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<bool> addNote({required String nTitle, required String nDesc}) async {
//     var db = await getDB();
//     int rowsEffected = await db.insert(Table_Name, {
//       Column_title: nTitle,
//       Column_desc: nDesc,
//     });
//     return rowsEffected > 0;
//   }
//
//   Future<List<Map<String, dynamic>>> getAllNote() async {
//     var db = await getDB();
//     List<Map<String, dynamic>> mData = await db.query(Table_Name);
//     return mData;
//   }
//
//   Future<bool> updateNote(
//       {required String mTitle, required String mDesc, required int sno}) async {
//     var db = await getDB();
//     int rowsEffected = await db.update(
//         Table_Name,
//         {
//           Column_title: mTitle,
//           Column_desc: mDesc,
//         },
//         where: "$Column_sn = $sno");
//     return rowsEffected > 0;
//   }
//
//   Future<bool> deleteNote({required int sno}) async {
//     var db = await getDB();
//     int rowsEffected = await db
//         .delete(Table_Name, where: "$Column_sn = ?", whereArgs: ['$sno']);
//     return rowsEffected>0;
//   }
// }
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  static const String Table_Name = "note";
  static const String Column_sn = "s_no";
  static const String Column_title = "title";
  static const String Column_desc = "description";

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, "noteDB.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $Table_Name (
            $Column_sn INTEGER PRIMARY KEY AUTOINCREMENT,
            $Column_title TEXT,
            $Column_desc TEXT
          )
        ''');
      },
    );
  }

  Future<bool> addNote({required String nTitle, required String nDesc}) async {
    final db = await getDB();
    int rowsEffected = await db.insert(Table_Name, {
      Column_title: nTitle,
      Column_desc: nDesc,
    });
    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNote() async {
    final db = await getDB();
    return await db.query(Table_Name, orderBy: "$Column_sn DESC");
  }

  Future<bool> updateNote(
      {required String mTitle, required String mDesc, required int sno}) async {
    final db = await getDB();
    int rowsEffected = await db.update(
      Table_Name,
      {
        Column_title: mTitle,
        Column_desc: mDesc,
      },
      where: "$Column_sn = ?",
      whereArgs: [sno],
    );
    return rowsEffected > 0;
  }

  Future<bool> deleteNote({required int sno}) async {
    final db = await getDB();
    int rowsEffected =
    await db.delete(Table_Name, where: "$Column_sn = ?", whereArgs: [sno]);
    return rowsEffected > 0;
  }
}
