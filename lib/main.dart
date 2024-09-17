import 'package:imtixon_6_oy/controller/daromatlarni_boshqarish.dart';
import 'package:imtixon_6_oy/service/daromatlar_servisi.dart';
import 'package:imtixon_6_oy/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final daromatlarServisi = DaromatlarServisi();
  await daromatlarServisi.init();

  runApp(MainApp(daromatlarServisi: daromatlarServisi));
}

class MainApp extends StatelessWidget {
  final DaromatlarServisi daromatlarServisi;
  const MainApp({super.key, required this.daromatlarServisi});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DaromatlarniBoshqarish(
        daromatlarServisi: daromatlarServisi,
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
