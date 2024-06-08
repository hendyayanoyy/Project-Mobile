

// ignore_for_file: prefer_const_declarations, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;


class Book {
  final String title;
  final String author;
  final String description;
  final String image;
  final int id;
  final double rating;
  final int year;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.id,
    required this.rating,
    required this.year,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      image: json['image'],
      id: json['id'],
      rating: json['rating'],
      year: json['year'],
    );
  }

  static Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(
        // 'http://localhost/project_akhir/lib/backends/get_member.php'));
        'http://project-hendi.test:8080/lib/backends/route_books.php?action=read'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Book> books = data.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load members');
    }
  }
}