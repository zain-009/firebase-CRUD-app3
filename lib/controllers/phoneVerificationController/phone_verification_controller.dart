import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/views/homePage/HomePage.dart';
import 'package:flutter/material.dart';
import '../../views/auth/codeVerificationPage/code_verification_page.dart';
import '../snackBarController/snackBar_controller.dart';

class PhoneVerificationController {
  static Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (e) {
            SnackBarController.showSnackBar(context, e.toString());
          },
          codeSent: (String verificationId, int? token) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CodeVerificationPage(
                          verificationId: verificationId,
                        )));
          },
          codeAutoRetrievalTimeout: (e) {
            SnackBarController.showSnackBar(context, e.toString());
          });
    } catch (e) {
      SnackBarController.showSnackBar(context, e.toString());
    }
  }

  static Future<void> verifyOtp(String verificationId,String smsCode,BuildContext context) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e){
      SnackBarController.showSnackBar(context, e.toString());
    }
  }
}
