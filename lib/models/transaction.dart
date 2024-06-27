import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_akhir/helpers/app_session.dart';
import 'package:project_akhir/models/member.dart';
import 'package:project_akhir/models/payment.dart';
import 'package:project_akhir/models/transaction_detail.dart';

class Transactions {
  final int? id;
  final String? codeTransaction;
  final double? total;
  final String? status;
  final int? memberId;
  late Member? member;
  late List<TransactionDetail>? detail;
  late Payment? payment;

  Transactions({
    this.memberId,
    this.member,
    this.id,
    this.codeTransaction,
    this.total,
    this.status,
    this.detail,
    this.payment
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {

    return Transactions(
      id: json['id'],
      codeTransaction: json['code_transaction'],
      total: json['total'],
      status: json['status'],
      memberId: json['member_id'],
      member: json['member'] != null ? Member.fromJson(json['member']) : null,
      detail: json['detail'] != null ? List<TransactionDetail>.from(json['detail'].map((x) => TransactionDetail.fromJson(x))) : null,
      payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null
    );
  }

  static Future<List<Transactions>> listTransactions() async {

    Member member = await AppSession.getUserSession();
    int id = member.id;

    final response = await http.get(
      Uri.parse(
        'http://admin-book.test:8080/api/route_transactions.php?action=get-transactions&member_id=$id'
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      List<Transactions> transactions = data.map(
        (json) {
          return Transactions.fromJson(json);
        }).toList();
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  static Future<Transactions> detailTransaction(int id) async {
    final response = await http.get(
      Uri.parse(
        'http://admin-book.test:8080/api/route_transactions.php?action=detail-transaction&id=$id'
      ),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Transactions transaction = Transactions.fromJson(data['data']);

      return transaction;
    } else {
      throw Exception('Failed to load transactions');

    }
  }

  static Future<bool> createTransaction(
    double total,
    List<dynamic> detail,
  ) async {

    Member member = await AppSession.getUserSession();
    int memberId = member.id;

    final response = await http.post(
      Uri.parse(
        'http://admin-book.test:8080/api/route_transactions.php?action=create-transaction',
      ),
      body: {
        'detail': json.encode(detail),
        'member_id': memberId.toString(),
        'total': total.toString(),
      }
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}