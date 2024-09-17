import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Overview",
          style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 56,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Financial Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard('Total Salary', '\$1,289.38', Colors.grey.shade200),
                _buildCard('Total Expense', '\$298.16', Colors.blue),
                _buildCard(
                    'Monthly Savings', '\$3,389.45', Colors.grey.shade200),
              ],
            ),
            const SizedBox(height: 20),
            // Middle Row with Circular Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton('Savings', Icons.savings, Colors.blue),
                _buildIconButton('Remind', Icons.alarm, Colors.grey.shade200),
                _buildIconButton('Budget', Icons.wallet, Colors.grey.shade200),
              ],
            ),
            const SizedBox(height: 20),
            // Latest Entries Section
            const Text(
              "Latest Entries",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card_outlined),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Method to build a card for the top row
  Widget _buildCard(String title, String value, Color color) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 8),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }

  // Method to build circular icon buttons
  Widget _buildIconButton(String title, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }

  // Method to build a list item for the latest entries section
  static Widget _buildListItem(
      String title, String amount, String paymentMethod, String date) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(Icons.fastfood, color: Colors.black),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$amount • $paymentMethod • $date'),
      trailing: const Icon(Icons.more_vert),
    );
  }
}
