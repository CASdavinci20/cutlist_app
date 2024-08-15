import 'package:cutlist/login/container/logincontainer.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget{
  const LoginPage ({super.key});


 @override
  LoginPageState  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
 

 final LoginContainer loginContainer = LoginContainer();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFEf9f9f9),
      body: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.fromLTRB(  30,70,30, 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your contact details',
                textAlign:TextAlign.center,
                style: TextStyle(
                      color:  Color(0xFFE0f2851),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),

              ),
              SizedBox(height: 10,),

              loginContainer.login(context)
                

            ],
          ),
          ),
      )
    );
  }
}