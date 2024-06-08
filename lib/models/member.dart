import 'package:http/http.dart' as http;
import 'dart:convert';

class Member {
  final int id;
  final String? name;
  final String? email;

  Member({required this.id, this.name, this.email});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['nama'],
      email: json['email'],
    );
  }

  // Metode untuk melakukan update data anggota
  static Future<void> updateMember(
      int id, String newName, String newEmail) async {
    final String url =
        'http://localhost/project_akhir/lib/backends/update_member.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
        'name': newName,
        'email': newEmail,
      },
    );
    if (response.statusCode == 200) {
      print('Data anggota berhasil diperbarui');
    } else {
      throw Exception('Gagal memperbarui data anggota');
    }
  }

  static Future<List<Member>> getMembers() async {
    final response = await http.get(Uri.parse(
        'http://localhost/project_akhir/lib/backends/get_member.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Member> members = data.map((json) => Member.fromJson(json)).toList();
      return members;
    } else {
      throw Exception('Failed to load members');
    }
  }
}
