import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/controllers/signupController/signup_controller.dart';
import 'package:firebasetest2/controllers/snackBarController/snackBar_controller.dart';
import 'package:firebasetest2/views/homePage/HomePage.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Future<void> signIn(
      String email, String password, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        SnackBarController.showSnackBar(
            context, "Login Successful!");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        SignupController.sendVerificationMail()
            .then((value) => SnackBarController.showSnackBar(
                context, "Account not verified. Check email for verification"))
            .onError((error, stackTrace) =>
                SnackBarController.showSnackBar(context, error.toString()));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          SnackBarController.showSnackBar(context, "Account does not exist!");
        }
        if (e.code == 'wrong-password') {
          SnackBarController.showSnackBar(context, "Wrong Password!");
        }
        if (e.code == 'too-many-requests') {
          SnackBarController.showSnackBar(context, "Too many requests! Try again after a few moments");
        }
      }
    }
  }
}
