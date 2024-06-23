// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_akhir/helpers/app_session.dart';
import 'package:project_akhir/models/book.dart';
import 'package:project_akhir/models/cart.dart';
import 'package:project_akhir/models/member.dart';

class DetailPage extends StatefulWidget {
  final int? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  Book? _book;
  bool _isLoading = true;
  Member? _member;

  @override
  void initState() {
    super.initState();
    _detailBook();
    _getMember();
  }

  Future<void> _detailBook() async {
    try {
      Book book = await Book.detailBook(widget.id!);

      setState(() {
        _book = book;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load books');
    }
  }

  Future<void> _getMember() async {
    try {
      Member member = await AppSession.getUserSession();
      setState(() {
        _member = member;
      });
    } catch(e) {
      print(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addCart(BuildContext context) async {
    try {
      Cart.addCart(context, _book!.id, _member!.id);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_border_outlined,
              color: Colors.black38,
            ),
            onPressed: () {
              print('bookmark');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          width: 200.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(_book!.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        _book!.title, 
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold  
                        )
                      ),
                      Text(
                        _book!.author, 
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 18.0),
                      Text(
                        'Rp. ' + _book!.price.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: [
                          Text('Rating :'),
                          Text(
                            _book!.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black38,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange.shade800,
                          )
                        ],
                      ),
                      SizedBox(height: 18.0),
                      Text('Summary :'),
                      Text(
                        _book!.description,
                        textAlign: TextAlign.justify,
                      ),
                    ]
                  )
                )
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _addCart(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white
                    ),
                    Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ]
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFD65A31)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}