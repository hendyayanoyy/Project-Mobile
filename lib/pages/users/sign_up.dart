// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/pages/users/sign_in.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;

  late BuildContext _context;

  Future<void> _signUp() async {
    try {
      final response = await http.post(
        // Uri.parse('http://localhost/project_akhir/lib/backends/sign_up.php'),
        Uri.parse('http://admin-book.test:8080/api/route_auth.php?action=register'),
        body: {
          'nama': _name,
          'email': _email,
          'password': _password,
        }
      );

      if (response.statusCode == 200) {
          ScaffoldMessenger.of(_context).showSnackBar(
            const SnackBar(content: Text('Member added successfully!')),
          );
          Navigator.pop(_context, true);
        } else {
          ScaffoldMessenger.of(_context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to add member: ${response.reasonPhrase}')),
          );
        }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black, // Warna latar belakang gelap
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD65A31),
                      fontFamily: 'Gravitas One',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                          ),
                          onChanged: (value) => _name = value,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) => _email = value,
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          onChanged: (value) => _password = value,                          
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _context = context;
                            _signUp();
                          }, // Tambahkan logika onPressed Anda
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD65A31),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 180.0,
                              vertical: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                          }, 
                          child: const Text('Sign In', style: TextStyle(color: Color(0xFFD65A31))),
                        ),
                        const SizedBox(height: 20.0),
                        const Text('Sign Up With :',
                            style: TextStyle(color: Color(0xFFD65A31))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        color: Colors.white,
                        onPressed: () {}, // Tambahkan logika onPressed Anda
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google),
                        color: Colors.white,
                        onPressed: () {}, // Tambahkan logika onPressed Anda
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        color: Colors.white,
                        onPressed: () {}, // Tambahkan logika onPressed Anda
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpPage(),
  ));
}
