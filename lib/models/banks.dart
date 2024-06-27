
import 'dart:convert';

import 'package:http/http.dart' as http;

class Banks {
  final int? id;
  final String? name;
  final String? codeBank;
  final double? adminFee;

  Banks({this.id, this.name, this.codeBank, this.adminFee});

  factory Banks.fromJson(Map<String, dynamic> json) {
    return Banks(
      id: json['id'],
      name: json['name'],
      codeBank: json['code_bank'],
      adminFee: json['admin_fee'],
    );
  }

  static Future<List<Banks>> getBanks() async {
    final response = await http.get(Uri.parse(
        'http://admin-book.test:8080/api/route_banks.php?action=list'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      List<Banks> banks = data.map((json) => Banks.fromJson(json)).toList();
      return banks;
    } else {
      throw Exception('Failed to load banks');
    }
  }

}