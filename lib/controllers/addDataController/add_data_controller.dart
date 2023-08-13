import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest2/controllers/snackBarController/snackBar_controller.dart';
import 'package:firebasetest2/models/userModel/user_model.dart';
import 'package:flutter/cupertino.dart';

class AddDataController {
  static Future<void> addDetails(String firstName, String lastName, int age,
      String email, String uid, BuildContext context) async {
    try {
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          age: age,
          email: email,
          uid: uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userModel.toJson());
    } catch (e) {
      SnackBarController.showSnackBar(context, e.toString());
    }
  }
}
