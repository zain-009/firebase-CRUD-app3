import 'package:firebasetest2/controllers/loginController/login_controller.dart';
import 'package:firebasetest2/views/auth/phoneLoginPage/phone_login_page.dart';
import 'package:firebasetest2/views/auth/signupPage/signup_page.dart';
import 'package:firebasetest2/widgets/roundButton/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.quicksand(
                        fontSize: 40,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.alternate_email),
                      hintText: "Email",
                      errorText: _formKey.currentState?.validate() == false
                          ? 'Please enter a valid email'
                          : null,
                    ),
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: isObscure,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Password",
                      errorText: _formKey.currentState?.validate() == false
                          ? 'Please enter a valid password'
                          : null,
                    ),
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundButton(
                    text: "Login",
                    isLoading: isLoading,
                    color: Colors.deepPurpleAccent,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await LoginController.signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don\'t have an account? "),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // RoundButton(
                  //   text: "Login with Phone Number",
                  //   color: Colors.grey,
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const PhoneLoginPage()));
                  //   },
                  // ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                         Size(size.width * 0.9, size.height * 0.06), // Set the width and height as needed
                      ),
                    ),
                    child: isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : Text("Login with Phone Number",style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.bold),),
                  )

                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
