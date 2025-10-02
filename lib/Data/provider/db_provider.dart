// import 'package:flutter/cupertino.dart';
// import 'package:sqflite_database_project/Data/Local/db_helper.dart';
//
// class DbProvider extends ChangeNotifier{
//   DBHelper dbHelper;
//   DbProvider({
//     required this.dbHelper
// });
//   List<Map<String, dynamic>> _mData = [];
//   List<Map<String, dynamic>> getNotes() => _mData;
//
//   void addNote(String ntitle, String nDesc) async {
//     bool check = await dbHelper.addNote(nTitle: ntitle, nDesc: nDesc);
//     if(check){
//       _mData = await dbHelper.getAllNote();
//       notifyListeners();
//     }
//   }
//   void updateNote(String ntitle, String nDesc, int sno) async {
//     bool check = await dbHelper.updateNote(mTitle: ntitle, mDesc: nDesc,sno: sno);
//     if(check){
//       _mData = await dbHelper.getAllNote();
//       notifyListeners();
//     }
//   }
//   void initialNotes () async{
//     _mData = await dbHelper.getAllNote();
//     notifyListeners();
//   }
//
//
// }
import 'package:flutter/foundation.dart';
import 'package:sqflite_database_project/Data/Local/db_helper.dart';

class DbProvider extends ChangeNotifier {
  final DBHelper dbHelper;
  DbProvider({required this.dbHelper});

  List<Map<String, dynamic>> _mData = [];
  List<Map<String, dynamic>> getNotes() => _mData;

  Future<void> addNote(String ntitle, String nDesc) async {
    bool check = await dbHelper.addNote(nTitle: ntitle, nDesc: nDesc);
    if (check) {
      _mData = await dbHelper.getAllNote();
      notifyListeners();
    }
  }

  Future<void> updateNote(String ntitle, String nDesc, int sno) async {
    bool check =
    await dbHelper.updateNote(mTitle: ntitle, mDesc: nDesc, sno: sno);
    if (check) {
      _mData = await dbHelper.getAllNote();
      notifyListeners();
    }
  }

  Future<void> deleteNote(int sno) async {
    bool check = await dbHelper.deleteNote(sno: sno);
    if (check) {
      _mData = await dbHelper.getAllNote();
      notifyListeners();
    }
  }

  Future<void> initialNotes() async {
    _mData = await dbHelper.getAllNote();
    notifyListeners();
  }
}
