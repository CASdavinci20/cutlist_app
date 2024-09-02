import 'package:cutlist/login/container/verificationInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../base_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  final TextEditingController _number1 = TextEditingController();
  final TextEditingController _number2 = TextEditingController();
  final TextEditingController _number3 = TextEditingController();
  final TextEditingController _number4 = TextEditingController();
  final TextEditingController _number5 = TextEditingController();
  final TextEditingController _number6 = TextEditingController();

  final VerificationInput verificationInput = VerificationInput();

  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      backgroundColor: const Color(0xFFEf9f9f9),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 70, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Verify - +234-903-4344-435',
              style: TextStyle(
                color: Color(0xFFE0f2851),
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Copy the OTP code sent to +234-903-4344-435.',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFFE0333333),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                child: const Text(
              'Wrong number ? ',
              style: TextStyle(
                color: Color(0xFFE0f3cd5b),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verificationInput.verificationInput(inputNumber: _number1),
                verificationInput.verificationInput(inputNumber: _number2),
                verificationInput.verificationInput(inputNumber: _number3),
                verificationInput.verificationInput(inputNumber: _number4),
                verificationInput.verificationInput(inputNumber: _number5),
                verificationInput.verificationInput(inputNumber: _number6),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter 6 Digit Code',
              style: TextStyle(
                color: Color(0xFFE0333333),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RichText(
                text: TextSpan(
                    text: 'Didn\'t receive code?',
                    style: TextStyle(
                      color: Color(0xFFE0333333),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                  TextSpan(
                      text: ' Resend Code',
                      style: TextStyle(
                        color: Color(0xFFE0f3cd5b),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ])),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: () {
                context;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BasePage()),
                );
              },
              child: SizedBox(
                width: 200,
                child: Image.asset(
                  'assets/button2.png',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
