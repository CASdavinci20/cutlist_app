import 'package:flutter/material.dart';

class VerificationInput{
  
  

  Widget verificationInput({
    required TextEditingController  inputNumber
  }){
    return SizedBox(
          height: 40,
          width: 35,
       child:  TextFormField(
           controller: inputNumber,
            decoration: InputDecoration(
                fillColor:Color(0xFFE0fafaff), 
                filled: true,
                  enabledBorder: OutlineInputBorder(
                  borderSide:const BorderSide(color:Color(0xFFE0b1b2b4) , width: 2.0),
                  borderRadius: BorderRadius.circular(5)
                ),
            ) 
        )
    );
  }
}