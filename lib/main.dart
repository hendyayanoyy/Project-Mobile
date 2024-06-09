import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_akhir/pages/users/dashboard_user.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          // child: AdminDashboard(),
          child: DashboardUser(),
          // child: SplashScreen(),
          // child: MemberCrudPage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
