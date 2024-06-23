// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir/helpers/app_session.dart';
import 'package:project_akhir/pages/users/dashboard_user.dart';
import 'package:project_akhir/pages/users/sign_up.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  late String _email;
  late String _password;

  late BuildContext _context;

  Future<void> _signIn() async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://admin-book.test:8080/api/route_auth.php?action=login'
        ),
        body: {
          'email': _email,
          'password': _password
        }
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AppSession.setBearerToken(data['data']['access_token']);
        AppSession.setUserSession(data['data']['user']);

        ScaffoldMessenger.of(_context).showSnackBar(
          const SnackBar(content: Text('Login successful!'))
        );
        Navigator.push(_context, MaterialPageRoute(builder: (context) => DashboardUser()));
      } else {
        ScaffoldMessenger.of(_context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.reasonPhrase}'))
        );
      }

    } catch(e) {
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
                    'Sign In',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD65A31),
                      fontFamily: 'GravitasOne',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: <Widget>[
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
                          onChanged: (value) => _password = value,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _context = context;
                            _signIn();
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
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          }, // Tambahkan logika onPressed Anda
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xFFD65A31)),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text('Sign In With :',
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
    home: SignInPage(),
  ));
}
