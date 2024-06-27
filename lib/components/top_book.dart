// ignore_for_file: depend_on_referenced_packages, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/models/book.dart';
import 'package:project_akhir/pages/users/books/detail_page.dart';

class TopBook extends StatefulWidget {
  const TopBook({Key? key}) : super(key: key);

  @override
  State<TopBook> createState() => _TopBookState();
}

class _TopBookState extends State<TopBook> {
  final List<String> imgList = [
    'lib/assets/topbook-1.png',
    'lib/assets/topbook-2.png',
    'lib/assets/topbook-3.png',
    'lib/assets/topbook-1.png',
    'lib/assets/topbook-2.png',
    'lib/assets/topbook-3.png',
  ];

  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          // 'http://localhost/project_akhir/lib/backends/route_books.php?action=top'));
          'http://admin-book.test:8080/api/route_books.php?action=top'));

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Text(
            'Top Books',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: books
                .map((book) => 
                  GestureDetector(
                    onTap: (() => {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => DetailPage(id: book.id))),
                    }), 
                    child: Container(
                      width: 148.0,
                      height: 180.0,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(book.image),
                          fit: BoxFit.fill,
                        )
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        elevation: 0,
                        margin: const EdgeInsets.only(top: 0.0, bottom: 12.0, left: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment(1, -1),
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 28.0,
                                ),
                              ),
                            ),
                            const Spacer(flex: 1,),
                            Text(
                              book.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              book.author,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18.0,
                                ),
                                Text(
                                  book.rating.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ),
                  )
                ).toList(),
          ),
        )
      ],
    );
  }
}
