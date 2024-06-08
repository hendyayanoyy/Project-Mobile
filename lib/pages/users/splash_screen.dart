import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
                Text(
                  'Vyn',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD65A31),
                    fontFamily:
                        'Gravitas One', // Gunakan font yang sudah diimpor
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'a book store',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontFamily: 'Actor', // Gunakan font yang sudah diimpor
                  ),
                ),
                const SizedBox(height: 10.0),
                FractionallySizedBox(
                  widthFactor:
                      0.5, // Atur ukuran gambar berdasarkan fraksi dari lebar induk
                  child: Image.asset(
                    'lib/assets/images/cover-splash.png',
                    fit: BoxFit.contain,
                  ),
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
    home: SplashScreen(),
  ));
}
