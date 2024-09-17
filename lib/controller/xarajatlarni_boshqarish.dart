import 'package:flutter/material.dart';
import 'package:imtixon_6_oy/model/xarajatlar_model.dart';
import 'package:imtixon_6_oy/service/xarajatlar_servisi.dart';

class XarajatlarniBoshqarish with ChangeNotifier {
  final XarajatlarServisi xarajatlarServisi;

  XarajatlarniBoshqarish({required this.xarajatlarServisi});

  List<XarajatlarModel> _xarajatlar = [];

  Future<List<XarajatlarModel>> get daromatlar async {
    _xarajatlar = await xarajatlarServisi.get();
    return [..._xarajatlar];
  }

  Future<void> xarajatQoshish({
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await xarajatlarServisi.insert(
        summa: summa, kategory: kategory, sana: sana, izoh: izoh);
    notifyListeners();
  }

  Future<void> editXarajat({
    required double summa,
    required String kategory,
    required DateTime sana,
    required String izoh,
  }) async {
    await xarajatlarServisi.insert(
        summa: summa, kategory: kategory, sana: sana, izoh: izoh);
    notifyListeners();
  }

  Future<void> deletexarajat({
    required int id,
  }) async {
    await xarajatlarServisi.delete(id);
    notifyListeners();
  }
}
