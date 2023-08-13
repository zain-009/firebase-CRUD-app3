import 'package:firebasetest2/controllers/postController/post_controller.dart';
import 'package:firebasetest2/widgets/roundButton/round_button.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _postController = TextEditingController();
  bool isLoading = false;


  @override
  void dispose() {
    super.dispose();
    _postController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _postController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Whats in your mind? ...',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 25,),
              RoundButton(text: "Post",isLoading: isLoading, onTap: () async {
              }, color: Colors.deepPurpleAccent),
            ],
          ),
        ),
      ),
    );
  }
}
