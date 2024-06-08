import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hi Hendi',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Welcome and enjoy in my bookstore',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('lib/assets/user.png'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),

          // Expanded ListView
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                itemDashboard(
                    context, 'Daftar Buku', Icons.library_books, Colors.blue),
                itemDashboard(
                    context, 'Kategori', Icons.category, Colors.green),
                itemDashboard(context, 'Pencarian', Icons.search, Colors.red),
                itemDashboard(
                    context, 'Pinjaman', Icons.history, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemDashboard(
    BuildContext context, String title, IconData iconData, Color background) {
  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(vertical: 15),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: ListTile(
      leading: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.10, vertical: 0.25),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        // Tindakan saat item di-tap
      },
    ),
  );
}
