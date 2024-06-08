import 'package:flutter/material.dart';
import 'package:project_akhir/components/carousels_top.dart';
import 'package:project_akhir/components/top_book.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({Key? key}) : super(key: key);

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
      body: const Column(
        children: [
          // SizedBox(height: 5.0),
          CarouselsTop(),
          SizedBox(height: 20.0),

          TopBook(), // Panggil carousel dari file terpisah
          // Tambahkan widget lain di bawah carousel jika diperlukan
        ],
      ),
    );
  }
}
