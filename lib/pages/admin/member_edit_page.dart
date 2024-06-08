import 'package:flutter/material.dart';
import 'package:project_akhir/models/member.dart';
import 'package:http/http.dart' as http;

class MemberEditPage extends StatefulWidget {
  final Member member;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;

  const MemberEditPage({
    Key? key,
    required this.member,
    this.buttonColor = Colors.black,
    this.textColor = Colors.white,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  _MemberEditPageState createState() => _MemberEditPageState();
}

class _MemberEditPageState extends State<MemberEditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.member.name ?? '';
    _email = widget.member.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Member'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),

              SizedBox(height: 20),

              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 136, 100, 100)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20),

              // Button Save
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Panggil fungsi untuk mengirim permintaan HTTP ke backend
                    updateMember(widget.member.id, _name, _email);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Text(
                      "Simpan Perubahan",
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mengirim permintaan HTTP ke backend untuk mengubah data anggota
  void updateMember(int id, String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/project_akhir/lib/backends/update_member.php'),
        body: {
          'id': id.toString(),
          'name': name,
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        // Data berhasil diperbarui
        print('Data anggota berhasil diperbarui');
        // Navigasi kembali ke halaman sebelumnya
        Navigator.pop(context, Member(id: id, name: name, email: email));
      } else {
        // Gagal mengirim permintaan atau mendapatkan respons
        print('Gagal memperbarui data anggota: ${response.body}');
      }
    } catch (error) {
      // Handle kesalahan koneksi atau kesalahan lainnya
      print('Gagal memperbarui data anggota: $error');
    }
  }
}
