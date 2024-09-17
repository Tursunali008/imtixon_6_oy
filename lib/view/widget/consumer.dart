import 'package:flutter/material.dart';
import 'package:imtixon_6_oy/controller/daromatlarni_boshqarish.dart';
import 'package:imtixon_6_oy/model/daromatlar_modeli.dart';
import 'package:provider/provider.dart';

class DaromatItem extends StatelessWidget {
  final DaromatlarModeli daromat;
  const DaromatItem({
    super.key,
    required this.daromat,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(daromat.izoh),
      subtitle: Text(daromat.summa.toString()),
      trailing: IconButton(
        onPressed: () {
          context.read<DaromatlarniBoshqarish>().deletedaromat(id: daromat.id);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
