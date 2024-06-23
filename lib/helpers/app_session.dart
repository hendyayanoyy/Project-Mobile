

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:project_akhir/models/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {

  static Future<bool?> setBearerToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString("token", token);
    return success;
  }

  static Future<String> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    return "Bearer " + token;
  }

  static Future<bool?> checkSession() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    return token != "";
  }

  static Future<bool?> setUserSession(Map user) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString("user", json.encode(user));
    return success;
  } 

  static Future<Member> getUserSession() async {
    final pref = await SharedPreferences.getInstance();
    String user = pref.getString("user") ?? "";

    Member member = Member.fromJson(json.decode(user));

    return member;
  }
}