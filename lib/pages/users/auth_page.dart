import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('lib/assets/images/cover-auth.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'VynBookstore',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFD65A31),
                    fontFamily: 'Gravitas One',
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'books from whole world !',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontFamily: 'Actor', // Gunakan font yang sudah diimpor
                  ),
                ),
                const SizedBox(height: 80.0),
                SizedBox(
                  width: 500.0,
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD65A31),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {}, // Tambahkan logika onPressed Anda
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF222831),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      }, // Tambahkan logika onPressed Anda
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthPage(),
  ));
}
