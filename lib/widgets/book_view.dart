import 'package:flutter/material.dart';
class BookView extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final String bookImage;
  final String bookDescription;
  final double bookRating;

  const BookView({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImage,
    required this.bookDescription,
    required this.bookRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 180,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            bookImage
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              bookTitle,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              bookAuthor,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                ),
                Text(
                  bookRating.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

  