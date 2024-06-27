// ignore_for_file: non_constant_identifier_names, duplicate_ignore, avoid_print, use_build_context_synchronously

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/helpers/app_session.dart';
import 'package:project_akhir/models/book.dart';
import 'package:project_akhir/models/member.dart';

class Cart {
  final int? id;
  final int member_id;
  final Member? member;
  final int book_id;
  final Book? book;
  late int quantity = 1;

  Cart({this.id, required this.member_id, required this.book_id, this.member, this.book});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      member_id: json['member']['id'],
      member: Member.fromJson(json['member']),
      book_id: json['book']['id'],
      book: Book.fromJson(json['book']),
    );
  }

  static Future<void> addCart(BuildContext context, int book_id, int member_id) async {
    final response = await http.post(
      Uri.parse(
        'http://admin-book.test:8080/api/route_carts.php?action=create'
      ),
      body: {
        'member_id': member_id.toString(),
        'book_id': book_id.toString()
      }
    );

    if(response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart added successfully'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add cart: ${response.reasonPhrase}'))
      );
    }
  }

  static Future<List<Cart>> listCart() async {

    Member member = await AppSession.getUserSession();
    int id = member.id;

    final response = await http.get(
      Uri.parse(
        'http://admin-book.test:8080/api/route_carts.php?action=list&member_id=$id'
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      List<Cart> carts = data.map(
        (json) {
          return Cart.fromJson(json);
        }).toList();
      return carts;
    } else {
      throw Exception('Failed to load carts');
    }
  }

  static Future<bool> deleteCart(BuildContext context, int? id) async {
    final response = await http.get(
      Uri.parse(
        'http://admin-book.test:8080/api/route_carts.php?action=delete&id=$id'
      )
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart deleted successfully'))
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete cart: ${response.reasonPhrase}'))
      );
      return false;
    }
  }

}