import 'package:cutlist/createpin/createpinpage.dart';
import 'package:flutter/material.dart';


class SigninAndSecurityPage extends StatefulWidget {
  const SigninAndSecurityPage({super.key});

  @override
  SigninAndSecurityPageState createState() => SigninAndSecurityPageState();
}

class SigninAndSecurityPageState extends State<SigninAndSecurityPage> {

  final TextEditingController _controllerSigninDetails = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEfafaff),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                     Navigator.of(context).pop();

                  },
              child:   Image.asset(
                  'assets/arrow_left.png',
                  height: 30,
                )
                ),
                const SizedBox(width: 10,),
                const  Text(
                  'Sign-in Security',
                  style:TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
              ],
            ),


            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                 Image.asset(
                  'assets/locked.png',
                  height: 50,
                 ),
               
             const  SizedBox(height: 10,),
               
                SizedBox(
                  width: 300,
                 child:  RichText(
              text:const TextSpan(
             text:  'Create a PIN for extra security. Use the PIN to access your account. ',
              style: TextStyle(
              color:  Color(0xFFE0333333),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ), 
            children: [
            
              TextSpan(
            text: 'Learn more',
            style: TextStyle(
              color:   Color(0xFFE093cffc),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            // recognizer: TapGestureRecognizer()
            // ..onTap = () {
            // }      
          ),
            ]
             )  
            ),
                ),

      InkWell(
        onTap: (){
          context;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=> const CreatePinPage(),
              ),
            
          );

        },
        child: Image.asset(
          'assets/turnOnBut.png',
          width: 350,
        ),
      ),


                ],
              ),
            )
          ],
        ),
        )
    );
  }
}