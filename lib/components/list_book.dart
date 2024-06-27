import 'package:flutter/material.dart';
import 'package:project_akhir/models/book.dart';
import 'package:project_akhir/pages/users/books/detail_page.dart';

class ListBooks extends StatefulWidget {
  const ListBooks({Key? key}) : super(key: key);

  @override
  State<ListBooks> createState() => _ListBookState();
}

class _ListBookState extends State<ListBooks> {
  bool? _isLoading = true;
  List<Book> listBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      List<Book> data = await Book.getBooks();
      setState(() {
        _isLoading = false;
        listBooks = data;
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    _isLoading == true
    ? const Center(child: CircularProgressIndicator())
    : Wrap(
      children: listBooks.map((book) => 
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
      ).toList()
    );
  }
}