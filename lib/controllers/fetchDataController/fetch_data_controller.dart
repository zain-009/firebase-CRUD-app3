import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/userModel/user_model.dart';

class FetchDataController {
  static Future<UserModel?> getUserModelById(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot docSnap =
    await firestore.collection('users').doc(uid).get();

    if (docSnap.exists) {
      print(UserModel.fromMap(docSnap.data() as Map<String, dynamic>));
      return UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
  }
}
