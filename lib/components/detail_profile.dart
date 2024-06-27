import 'package:flutter/material.dart';
import 'package:project_akhir/helpers/app_session.dart';
import 'package:project_akhir/models/member.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({Key? key}) : super(key: key);

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {

  bool _isLoading = true;
  late Member? member;

  late String? name;
  late String? email;
  late String? password;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    try {
      Member member = await AppSession.getUserSession();

      setState(() {
        _isLoading = false;
        name = member.name;
        email = member.email;
        member = member;
      });
    } catch(e) {
      print(e);
    }
  }


  Future<void> _updateProfile() async {
    try {
      Member.updateMember(member!.id, name!, email!, password);
      _getProfile();
    } catch(e) {
      print(e);
    }
  }

  Future <void> _logout() async {
    try {
      AppSession.removeUserSession();
      Navigator.pop(context);
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
        
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Detail Profile', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 18.0),
          TextFormField(
            initialValue: name,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
            onChanged: (value) {
              name = value;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: email,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              _updateProfile();
            },
            child: Text('Update Profile', style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD65A31)),
            ),
            onPressed: _logout,
            child: const Text('Logout', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}