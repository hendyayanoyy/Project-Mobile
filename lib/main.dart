import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:project_akhir/pages/users/user_dashboard.dart';
// import 'package:project_akhir/pages/admin/admin_dashboard.dart';
import 'package:project_akhir/pages/admin/member_crud_page.dart';
// import 'package:project_akhir/pages/admin/member_crud.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MemberCrudPage(),
        ),
      ),
    );
  }
}
