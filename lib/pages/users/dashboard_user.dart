import 'package:flutter/material.dart';
import 'package:project_akhir/pages/users/screens/books.dart';
import 'package:project_akhir/pages/users/screens/carts.dart';
import 'package:project_akhir/pages/users/screens/home.dart';
import 'package:project_akhir/pages/users/screens/profile.dart';
import 'package:project_akhir/pages/users/screens/transactions.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({Key? key}) : super(key: key);

  @override
  _DashboardUserState createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {

  late int _selectedIndex = 0;

  List<Widget> pageList = [
    const Home(),
    const Books(),
    const Carts(),
    const Transactions(),
    const Profile()
  ];

  Future<void> _changePage (int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        toolbarHeight: 70.0, // Mengatur tinggi AppBar
        title: Container(
          height: 40.0, // Mengatur tinggi TextField
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 25, 25),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white70,
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              // Tambahkan logika untuk aksi menu di sini
            },
            iconSize: 30.0, // Mengurangi ukuran icon
            padding: const EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFFEFFEA),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
            backgroundColor: Color(0xFFFEFFEA), 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Color(0xFFFEFFEA),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transaction',
            backgroundColor: Color(0xFFFEFFEA), 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color(0xFFFEFFEA),
          ),
        ],
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _selectedIndex,
        onTap: (value) => {
          _changePage(value)
        },
      ),
    );
  }
}