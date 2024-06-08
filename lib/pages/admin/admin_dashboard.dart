import 'package:flutter/material.dart';
import 'package:project_akhir/components/footer.dart';
// import 'package:project_akhir/pages/admin/add_book.dart';
import 'package:project_akhir/pages/admin/member_crud_page.dart';
// import 'package:project_akhir/components/menu-tile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
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
                    'Hi Admin',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Manage your library here',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('lib/assets/admin.png'),
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
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                // Member CRUD
                itemDashboard(
                  context,
                  'Member',
                  Icons.people,
                  Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MemberCrudPage()),
                    );
                  },
                ),
                // CRUD Buku
                // itemDashboard(
                //   context,
                //   'Buku',
                //   Icons.book,
                //   Colors.green,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => AddBookPage()),
                //     );
                //   },
                // ),
                // Laporan Pinjaman
                // itemDashboard(
                //   context,
                //   'Laporan Pinjaman',
                //   Icons.report,
                //   Colors.red,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => LaporanPinjamanPage()),
                //     );
                //   },
                // ),
                // Pengaturan
                // itemDashboard(
                //   context,
                //   'Pengaturan',
                //   Icons.settings,
                //   Colors.orange,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => PengaturanPage()),
                //     );
                //   },
                // ),
              ],
            ),
          ),

          // Footer
          Footer(backgroundColor: Colors.grey),
        ],
      ),
    );
  }
}

Widget itemDashboard(
    BuildContext context, String title, IconData icon, Color color,
    {required Function() onTap}) {
  return Card(
    child: ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    ),
  );
}
