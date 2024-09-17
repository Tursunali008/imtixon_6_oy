import 'package:flutter/material.dart';
import 'package:imtixon_6_oy/model/daromatlar_modeli.dart';
import 'package:imtixon_6_oy/service/daromatlar_servisi.dart';

class DaromatlarniBoshqarish with ChangeNotifier {
  final DaromatlarServisi daromatlarServisi;

  DaromatlarniBoshqarish({required this.daromatlarServisi});

  List<DaromatlarModeli> _daromatlar = [];

  Future<List<DaromatlarModeli>> get daromatlar async {
    _daromatlar = await daromatlarServisi.get();
    return [..._daromatlar];
  }

  Future<void> daromatQoshish({
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await daromatlarServisi.insert(
        summa: summa, kategory: kategory, sana: sana, izoh: izoh);
    notifyListeners();
  }

  Future<void> editDaromat({
    required int id,
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await daromatlarServisi.edit(
      daromatId: id,
      summa: summa,
      kategory: kategory,
      sana: sana,
      izoh: izoh,
    );
    notifyListeners();
  }

  Future<void> deletedaromat({
    required int id,
  }) async {
    await daromatlarServisi.delete(id);
    notifyListeners();
  }
}
