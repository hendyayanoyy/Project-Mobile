import 'package:flutter/material.dart';
import 'package:project_akhir/pages/users/sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Vyn',
                  style: TextStyle(
                    fontSize: 56.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD65A31),
                    fontFamily:
                        'Gravitas One', // Gunakan font yang sudah diimpor
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'a book store',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontFamily: 'Actor', // Gunakan font yang sudah diimpor
                  ),
                ),
                const SizedBox(height:1.0),
                FractionallySizedBox(
                  widthFactor:
                      0.5, // Atur ukuran gambar berdasarkan fraksi dari lebar induk
                  child: Image.asset(
                    'lib/assets/cover-splash.png',
                    fit: BoxFit.contain,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD65A31),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                  }, 
                  child: const Text(
                    'Sign In', 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
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
    home: SplashScreen(),
  ));
}
