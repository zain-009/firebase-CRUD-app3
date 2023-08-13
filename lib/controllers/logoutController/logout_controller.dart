import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/views/auth/loginPage/login_page.dart';
import 'package:flutter/material.dart';

class LogoutController{
  static Future <void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}