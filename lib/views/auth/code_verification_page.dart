import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../widgets/roundButton/round_button.dart';
import '../../controllers/authController/auth_controller.dart';


class CodeVerificationPage extends StatefulWidget {
  final String verificationId;
  const CodeVerificationPage({super.key,required this.verificationId});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  bool isLoading = false;
  String smsCode = '';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: false,
                onChanged: (pin) => smsCode = pin,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundButton(
                  text: "Verify",
                  isLoading: isLoading,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AuthController.verifyOtp(widget.verificationId, smsCode,context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  color: Colors.deepPurpleAccent),

            ],
          ),
        ),
      ),
    );
  }
}
