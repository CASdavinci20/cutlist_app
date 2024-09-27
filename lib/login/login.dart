import 'package:cutlist/login/container/logincontainer.dart';
import 'package:flutter/material.dart';

import 'verificationpage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final  LoginContainer  loginContainer = LoginContainer();

  final TextEditingController   _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: const Color(0xFFEf9f9f9),
      body: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.fromLTRB(  30,70,30, 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your Phone Number',
                textAlign:TextAlign.center,
                style: TextStyle(
                      color:  Color(0xFFE0f2851),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),

              ),
              SizedBox(height: 10,),
        
           SizedBox(
        
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
              loginContainer.loginContainer(
                title: 'Phone Number', 
                textLabel: 'Enter your Phone', 
                inputData: _phoneNumber , 
                icon: Icon(
                  Icons.phone_outlined
                )
                ),
                const SizedBox(height: 10,),
                ]
              )
             ),
            const SizedBox( height: 30,),
             const Divider(height: 4, color: Color(0xFFE0b1b2b4)),
          
          const SizedBox( height: 20,),

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
          ],
        ),
      )
                

            ],
          ),
          ),
      )


    );
  }
}