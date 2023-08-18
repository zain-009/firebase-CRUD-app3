import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest2/widgets/roundButton/round_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/authController/auth_controller.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntlPhoneField(
                  disableLengthCheck: false,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    labelText: null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'PK',
                  onChanged: (phone) {
                    phoneNumber = phone.completeNumber;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                RoundButton(
                    text: "Submit",
                    isLoading: isLoading,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthController.verifyPhoneNumber(phoneNumber, context);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    color: Colors.deepPurpleAccent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
