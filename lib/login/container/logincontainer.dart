import 'package:flutter/material.dart';

class LoginContainer {
  final Function()? onPhoneNumberChanged;
  LoginContainer({this.onPhoneNumberChanged});

  Widget loginContainer(
      {required String title,
      required String textLabel,
      required TextEditingController inputData,
      required Icon icon}) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFE0333333),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: inputData,
            decoration: InputDecoration(
              prefixIcon: icon,
              labelText: textLabel,
              fillColor: Color(0xFFE0fafaff),
              filled: true,
              labelStyle: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFFE0cacacf),
                  fontWeight: FontWeight.w600),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFE0b1b2b4), width: 2.0),
                  borderRadius: BorderRadius.circular(15)),
              hintStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
