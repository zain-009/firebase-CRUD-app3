import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/controllers/addDataController/add_data_controller.dart';
import 'package:firebasetest2/controllers/snackBarController/snackBar_controller.dart';
import 'package:firebasetest2/views/auth/loginPage/login_page.dart';
import 'package:flutter/material.dart';

class SignupController {
  static Future<void> signup(
      String email, String password, BuildContext context, String firstName,String lastName,int age,) async {
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String? uid = auth.currentUser?.uid;
      AddDataController.addDetails(firstName, lastName, age, email,uid!,context);
      sendVerificationMail();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e){
      if(e is FirebaseAuthException){
        if(e.code == 'email-already-in-use'){
          SnackBarController.showSnackBar(context, "Email already in use");
        }
      } else {
        SnackBarController.showSnackBar(context, e.toString());
      }
    }
  }

  static Future<void> sendVerificationMail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    await user?.sendEmailVerification();
  }
}
