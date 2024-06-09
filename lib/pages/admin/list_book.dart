// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/models/book.dart';
import 'package:project_akhir/pages/admin/add_book.dart';
import 'package:project_akhir/widgets/book_list_view.dart';

class ListBook extends StatefulWidget {
  const ListBook({Key? key}) : super(key: key);
  @override

  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {

  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          // 'http://localhost/project_akhir/lib/backends/route_books.php?action=read'));
          'http://project-hendi.test:8080/lib/backends/route_books.php?action=read'));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        List<dynamic> data = responseBody['data'];

        setState(() {
          books = data.map(
            (json) => Book.fromJson(json),
          ).toList();
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Book'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBookPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: BookListView(books: books),
        ),
        // child: SingleChildScrollView(
        //   padding: EdgeInsets.all(16.0),
        //   scrollDirection: Axis.vertical,
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Text('Book List', style: TextStyle(fontSize: 20),),
        //         ],
        //       ),
        //       BookListView(),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}