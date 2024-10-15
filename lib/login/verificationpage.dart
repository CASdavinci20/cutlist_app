import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:cutlist/home/homepage.dart';
import 'package:cutlist/login/container/verificationInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

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
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

   late AppBloc appBloc;
   
   validationFields()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

     if (await AppActions().checkInternetConnection()) {
      sendVerification();
     }else{
      AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
   }

    sendVerification() async{
  
     Map verificationData = {
      "phoneNumber":"${PublicVar.userPhone}",
       "otp":'${_number1.text} ${_number2.text} ${_number3.text} ${_number4.text} ${_number5.text} ${_number6.text}'
      //  "otp": 741704
  
    };
    print(verificationData);
    if(await Server().postAction(url:Urls.cutVerification,data:verificationData,bloc:appBloc)){
      print(appBloc.mapSuccess);
        
      NextPage().nextRoute(context, BottomNav());

    }

   }

   resendOTP()async{
   Map data = {
       "phoneNumber":"${PublicVar.userPhone}",
    };
    if(await Server().postAction(url:Urls.cutResendOTP ,data: data,bloc: appBloc)){
      print(appBloc.mapSuccess);
    }
   }



  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEf9f9f9),
      body:SingleChildScrollView(
       child:  Form(
          key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 70, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text(
              'Verify - ${PublicVar.userPhone}',
              style:const TextStyle(
                color: Color(0xFFE0f2851),
                fontSize: 22,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              'Copy the OTP code sent to ${PublicVar.userPhone}.',
              textAlign: TextAlign.left,
              style:const TextStyle(
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
          const  SizedBox(
              height: 20,
            ),
          const  Text(
              'Enter 6 Digit Code',
              style: TextStyle(
                color: Color(0xFFE0333333),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
           const SizedBox(
              height: 50,
            ),
            RichText(
                text: TextSpan(
                    text: 'Didn\'t receive code?',
                    style:const TextStyle(
                      color: Color(0xFFE0333333),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                  TextSpan(
                      text: ' Resend Code',
                      style: const TextStyle(
                        color: Color(0xFFE0f3cd5b),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                          resendOTP();
                      }),
                ])),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: () {
                // validationFields();

                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=> BottomNav())
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
      )
      )
    );
  }
}
