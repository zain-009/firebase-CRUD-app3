import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/controllers/fetchDataController/fetch_data_controller.dart';
import 'package:firebasetest2/controllers/logoutController/logout_controller.dart';
import 'package:firebasetest2/models/userModel/user_model.dart';
import 'package:firebasetest2/views/postPage/post_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? uid;
  UserModel? userModel;
  bool load = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        load = false;
      });
    });
    getData();
    super.initState();
  }

  Future<UserModel> getData () async {
    userModel = await FetchDataController.getUserModelById(FirebaseAuth.instance.currentUser!.uid);
    return userModel!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.blue),
                          ),
                          content:
                          const Text("Are you sure you want to Logout?"),
                          contentPadding: const EdgeInsets.all(20),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.black54),
                                )),
                            TextButton(
                                onPressed: () {
                                  LogoutController.logout(context);
                                },
                                child: const Text("Yes")),
                          ],
                        ));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
               load ? const Center(child: CircularProgressIndicator()) : Card(
                child: ListTile(
                  title: Text(userModel!.lastName),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostPage()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
