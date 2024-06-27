// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/models/member.dart';
import 'package:project_akhir/pages/admin/member_edit_page.dart';
import 'package:project_akhir/pages/admin/member_tambah_page.dart';

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
          // 'http://localhost/project_akhir/lib/backends/get_member.php'));
          'http://project-hendi.test:8080/lib/backends/get_member.php'));
          // 'http://10.0.2.2:8080/lib/backends/get_member.php'));
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
        title: const Text('Manage Member'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(member.email ?? 'Unknown'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
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
                      icon: const Icon(Icons.delete, color: Colors.red),
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
              builder: (context) => const AddMemberPage(),
            ),
          );
          if (newMember != null) {
            // Handle new member
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Member'),
          content: Text(
              'Are you sure you want to delete ${member.name ?? 'Unknown'}?'), // Menggunakan operator null-aware
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
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
