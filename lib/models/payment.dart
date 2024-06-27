import 'package:http/http.dart' as http;
import 'package:project_akhir/models/banks.dart';
import 'package:project_akhir/models/member.dart';

class Payment {
  final int? id;
  final String? codePayment;
  final double? total;
  final int? bankId;
  final Banks? bank;
  final String? numberVirtual;
  final int? transactionId;
  final String? status;
  final int? memberId;
  final Member? member;

  Payment({
    this.id,
    this.codePayment,
    this.total,
    this.bankId,
    this.bank,
    this.numberVirtual,
    this.transactionId,
    this.status,
    this.memberId,
    this.member
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      codePayment: json['code_payment'],
      total: json['total'],
      bankId: json['bank_id'],
      bank: json['bank'] != null ? Banks.fromJson(json['bank']) : null,
      numberVirtual: json['number_virtual'],
      transactionId: json['transaction_id'],
      status: json['status'],
      memberId: json['member_id'],
      member: json['member'] != null ? Member.fromJson(json['member']) : null
    );
  }

  static Future<bool> createPayment(
    double? total,
    int? memberId,
    int? transactionId,
    int? bankId
  ) async {

    final response = await http.post(
      Uri.parse(
        'http://admin-book.test:8080/api/route_transactions.php?action=create-payments',
      ),
      body: {
        'total': total.toString(),
        'member_id': memberId.toString(),
        'transaction_id': transactionId.toString(),
        'bank_id': bankId.toString(),
      }
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create payment');
    }
  }

}