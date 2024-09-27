

import 'dart:ffi';

import 'package:cutlist/login/login.dart';
import 'package:cutlist/login/verificationpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginContainer{

  
  final TextEditingController _fullNameController = TextEditingController();
 final TextEditingController _phoneController = TextEditingController();
 bool isChecked = false;

  Widget loginContainer ({
    required String title,
    required String  textLabel,
    required TextEditingController inputData,
    required Icon icon
  }){
    
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                      color:  Color(0xFFE0333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ), 
          ),
           TextFormField(
                    controller: inputData,
                    decoration:  InputDecoration(
                     prefixIcon: icon,
                      labelText: textLabel,
                      fillColor:Color(0xFFE0fafaff), 
                      filled: true,
                      labelStyle:const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFE0cacacf),
                        fontWeight: FontWeight.w600
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:Color(0xFFE0b1b2b4) , width: 2.0),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      hintStyle:const TextStyle(fontSize: 16),
                      
                    ),
                ),
        ],
      ),
    );
  }


    Widget login(context){
      return SizedBox(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  Text(
                'will need to verify your phone number',
               
                style: TextStyle(
                      color:  Color(0xFFE0333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
             
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0 ,vertical: 60),
              child: Column(
                children: [
              loginContainer(
                title: 'Full Name', 
                textLabel: 'Enter your name', 
                inputData: _fullNameController , 
                icon: Icon(
                  Icons.person_2_outlined
                )
                ),
                const SizedBox(height: 10,),
                 loginContainer(
                title: 'Phone Number', 
                textLabel: '090-70.....', 
                inputData: _phoneController , 
                icon: Icon(
                  Icons.phone_outlined
                )
                ),  
                ]
              )
             ),
            const SizedBox( height: 30,),
             const Divider(height: 4, color: Color(0xFFE0b1b2b4)),
          
          const SizedBox( height: 20,),
           Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {

          },
        ),
        SizedBox(
          width: 250,
       child:  Text('By continuing you accept our Privacy Policy and Term of Use'),
        )
      ],
    ),

    SizedBox(height: 40,),
    
    Center(
   child:  SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: (){
          context;
             Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const VerificationPage()),
            );

        },
        child: Image.asset(
          'assets/button.png'
        ),
      ),
   )
    ),
      SizedBox(height: 40,),
      
    

    Center(
     child:  RichText(
        text: TextSpan(
          children:[
           TextSpan(
            text: 'Already have an account',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black
            )
          ),
          WidgetSpan(
            child: InkWell(
              onTap: (){
                context;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>  Loginpage())
                );
                  
              },
       child: Text(
             ' Login here.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE0f2c94c),
            )
          )
            )
          )
    
          ]
        )
        )
    )
          ],
        ),
      );
    }
}