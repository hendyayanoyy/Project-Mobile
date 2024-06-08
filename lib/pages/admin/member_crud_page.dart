import 'package:flutter/material.dart';
import 'package:project_akhir/models/member.dart';
import 'package:project_akhir/pages/admin/member_edit_page.dart';
import 'package:project_akhir/pages/admin/member_tambah_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemberCrudPage extends StatefulWidget {
  @override
  _MemberCrudPageState createState() => _MemberCrudPageState();
}

class _MemberCrudPageState extends State<MemberCrudPage> {
  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost/project_akhir/lib/backends/get_member.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          members = data.map((member) => Member.fromJson(member)).toList();
        });
      } else {
        throw Exception(
            'Failed to fetch members'); // Menambahkan pesan kesalahan
      }
    } catch (e) {
      print('Failed to fetch members: $e');
      // Anda bisa menambahkan log atau pesan kesalahan lainnya di sini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Member'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(member.name ?? 'Unknown',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(member.email ?? 'Unknown'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final updatedMember = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MemberEditPage(member: member),
                          ),
                        );
                        if (updatedMember != null) {
                          // Handle update member
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteDialog(context, member);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newMember = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMemberPage(),
            ),
          );
          if (newMember != null) {
            // Handle new member
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Member'),
          content: Text(
              'Are you sure you want to delete ${member.name ?? 'Unknown'}?'), // Menggunakan operator null-aware
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // _deleteMember(member.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
