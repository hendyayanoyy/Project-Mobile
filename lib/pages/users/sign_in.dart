import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD65A31),
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
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white70),
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
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white70),
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
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {}, // Tambahkan logika onPressed Anda
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFD65A31),
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
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignInPage(),
  ));
}
