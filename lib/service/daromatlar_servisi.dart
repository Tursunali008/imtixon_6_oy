import 'package:imtixon_6_oy/model/daromatlar_modeli.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DaromatlarServisi {
  late final Database _database;
  final String _dbName = "daromat.db";
  final String _table = "daromat";
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
        $_sana INTEGER NOT NULL,  -- Store date as integer (milliseconds since epoch)
        $_izoh TEXT NOT NULL
      )
    """;

    await db.execute(query);
  }
Future<List<DaromatlarModeli>> get() async {
  final List<DaromatlarModeli> daromatlar = [];
  final data = await _database.query(_table);

  for (var item in data) {
    final daromat = DaromatlarModeli(
      id: item[_id] as int,
      summa: double.parse(item[_summa] as String),
      kategory: item[_kategory] as String,
      date: DateTime.fromMillisecondsSinceEpoch(item[_sana] as int),
      izoh: item[_izoh] as String,
    );

    daromatlar.add(daromat);
  }

  return daromatlar;
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
      _sana: sana.toIso8601String(),
      _izoh: izoh,
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
        _sana: sana.toIso8601String(),
        _izoh: izoh,
      },
      where: '$_id = ?',
      whereArgs: [daromatId],
    );
  }

  Future<void> delete(int daromatId) async {
    await _database.delete(_table, where: '$_id = ?', whereArgs: [daromatId]);
  }
}
