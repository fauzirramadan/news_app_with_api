import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_day3/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? username, fullname, id;

  Future<void> saveSession(
      int? nValue, String? nUsername, String? nId, String? nFullname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", nValue ?? 0);
    prefs.setString("username", nUsername ?? "");
    prefs.setString("id", nId ?? "");
    prefs.setString("fullname", nFullname ?? "");
  }

  Future getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getInt("value");
    username = prefs.getString("username");
    id = prefs.getString("id");
    fullname = prefs.getString("fullname");
    return value;
  }

  // Clear Session
  Future<void> clearSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  }
}
