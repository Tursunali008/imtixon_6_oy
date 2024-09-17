import 'package:imtixon_6_oy/model/xarajatlar_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class XarajatlarServisi {
  late final Database _database;
  final String _dbName = "xarajat.db";
  final String _table = "xarajat";
  final String _id = "id";
  final String _summa = "summa";
  final String _kategory = "kategory";
  final String _sana = "sana";
  final String _izoh = "izoh";

  Future<void> init() async {
    final folder = await getApplicationDocumentsDirectory();
    final path = "${folder.path}/$_dbName";
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    final String query = """
      CREATE TABLE $_table 
      (
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_summa TEXT NOT NULL,
        $_kategory TEXT NOT NULL,
        $_sana TEXT NOT NULL,
        $_izoh TEXT NOT NULL

      )
""";

    await db.execute(query);
  }

  Future<List<XarajatlarModel>> get() async {
    final List<XarajatlarModel> xarajatlar = [];
    final data = await _database.query(_table);

    for (var item in data) {
      final xarajat = XarajatlarModel(
        id: item[_id] as int,
        summa: item[_summa] as double,
        kategory: item[_kategory] as String,
        date: item[_sana] as DateTime,
        izoh: item[_izoh] as String,
      );

      xarajatlar.add(xarajat);
    }

    return xarajatlar;
  }

  Future<void> insert({
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await _database.insert(_table, {
      _summa: summa.toString(),
      _kategory: kategory,
      _sana: sana.toString(),
      izoh: izoh
    });
  }

  Future<void> edit({
    required int daromatId,
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await _database.update(
      _table,
      {
        _summa: summa.toString(),
        _kategory: kategory,
        _sana: sana.millisecondsSinceEpoch,
        _izoh: izoh,
      },
      where: '$_id = ?',
      whereArgs: [daromatId],
    );
  }

  Future<void> delete(int xarajatId) async {
    await _database.delete(_table, where: "id=$xarajatId");
  }
}
