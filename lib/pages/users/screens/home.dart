import 'package:flutter/material.dart';
import 'package:project_akhir/components/carousels_top.dart';
import 'package:project_akhir/components/new_book.dart';
import 'package:project_akhir/components/top_book.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselsTop(),
        SizedBox(height: 20.0),
        TopBook(), // Panggil carousel dari file terpisah
        NewBook(),
        // Tambahkan widget lain di bawah carousel jika diperlukan
      ],
    );
  }
}