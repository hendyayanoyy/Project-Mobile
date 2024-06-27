import 'package:flutter/material.dart';
import 'package:project_akhir/components/footer.dart';
import 'package:project_akhir/pages/admin/list_book.dart';
// import 'package:project_akhir/pages/admin/add_book.dart';
import 'package:project_akhir/pages/admin/member_crud_page.dart';
import 'package:project_akhir/widgets/book_view.dart';
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
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
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
          Container(
            padding: const EdgeInsets.all(18),
            child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "List Books", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ListBook()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ), 
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )
                    ]
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BookView(
                          bookTitle: "Pride and Prejudice", 
                          bookAuthor: "Jane Austen", 
                          bookImage: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
                          bookDescription: "book mindself",
                          bookRating: 3.5,
                        ),
                        BookView(
                          bookTitle: "Pride and Prejudice", 
                          bookAuthor: "Jane Austen", 
                          bookImage: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
                          bookDescription: "book mindself",
                          bookRating: 3.5,
                        ),
                        BookView(
                          bookTitle: "Pride and Prejudice", 
                          bookAuthor: "Jane Austen", 
                          bookImage: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
                          bookDescription: "book mindself",
                          bookRating: 3.5,
                        ),
                        BookView(
                          bookTitle: "Pride and Prejudice", 
                          bookAuthor: "Jane Austen", 
                          bookImage: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
                          bookDescription: "book mindself",
                          bookRating: 3.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Footer
          const Footer(backgroundColor: Colors.grey),
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
