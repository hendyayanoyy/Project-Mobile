import 'package:project_akhir/models/book.dart';

class TransactionDetail {
  final int? id;
  final int? transactionId;
  final int? bookId;
  final Book? book;
  final double? price;
  final int? quantity;

  TransactionDetail({
    this.id,
    this.transactionId,
    this.bookId,
    this.book,
    this.price,
    this.quantity
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      id: json['id'],
      transactionId: json['transaction_id'],
      bookId: json['book_id'],
      book: Book.fromJson(json['book']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  factory TransactionDetail.toJson(Map<String, dynamic> json) {
    return TransactionDetail(
      id: json['id'],
      transactionId: json['transaction_id'],
      bookId: json['book_id'],
      book: Book.fromJson(json['book']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}