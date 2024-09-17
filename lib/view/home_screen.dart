import 'package:flutter/material.dart';
import 'package:imtixon_6_oy/view/widget/consumer.dart';
import 'package:provider/provider.dart';
import 'package:imtixon_6_oy/controller/daromatlarni_boshqarish.dart';
import 'package:imtixon_6_oy/utils/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Overview",
          style: TextStyle(fontSize: AppTextstyle.globaltextsyle),
        ),
        actions: [
          IconButton(
            onPressed: () {
              const double summa = 23.4;
              const String kategory = "depozit";
              DateTime sana = DateTime(DateTime.april);
              const String izoh = "sasadsdhgfhf";
              context.read<DaromatlarniBoshqarish>().daromatQoshish(
                  summa: summa, kategory: kategory, sana: sana, izoh: izoh);
            },
            icon: Icon(
              Icons.add,
              size: AppTextstyle.globaltextsyle,
            ),
          ),
        ],
      ),
      body: Consumer<DaromatlarniBoshqarish>(
        builder: (context, daromatController, child) {
          return FutureBuilder(
              future: daromatController.daromatlar,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("NO DATA"),
                  );
                }

                final daromatlar = snapshot.data!;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: daromatlar.length,
                  itemBuilder: (context, index) {
                    return DaromatItem(
                      daromat: daromatlar[index],
                    );
                  },
                );
              });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card_outlined),
            label: 'Add Daromat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_rounded),
            label: 'Add Xarajat',
          ),
        ],
      ),
    );
  }
}
