import 'package:cutlist/base_page.dart';
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
import '../main_utils/widgets/global_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  // final TextEditingController _number1 = TextEditingController();
  // final TextEditingController _number2 = TextEditingController();
  // final TextEditingController _number3 = TextEditingController();
  // final TextEditingController _number4 = TextEditingController();
  // final TextEditingController _number5 = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  final VerificationInput verificationInput = VerificationInput();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
 

   late AppBloc appBloc;
    late bool loading = false;

  showLoading() {
    if (loading) {
      loading = false;
    } else {
      loading = true;
    }
    setState(() {});
  }

   
   validationFields()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      showLoading();

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
       "otp":'${_pinController.text}'
      //  ${_number1.text} ${_number2.text} ${_number3.text} ${_number4.text} ${_number5.text} ${_number6.text}'
      //  "otp": 741704
  
    };
    print(verificationData);
    if(await Server().postAction(url:Urls.cutVerification,data:verificationData,bloc:appBloc)){
      print(appBloc.mapSuccess);
       CircularProgressIndicator();
      AppActions().showErrorToast(
        text: 'Welcome Back',
        context: context,
      );
        
      NextPage().nextRoute(context, BottomNav());

    }else{
       AppActions().showErrorToast(
        text: PublicVar.verfECode,
        context: context,
      );
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
                color: Colors.black,
                fontSize: 25,
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
            //    Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     verificationInput.verificationInput(inputNumber: _number1),
            //     verificationInput.verificationInput(inputNumber: _number2),
            //     verificationInput.verificationInput(inputNumber: _number3),
            //     verificationInput.verificationInput(inputNumber: _number4),
            //     verificationInput.verificationInput(inputNumber: _number5),
            //     verificationInput.verificationInput(inputNumber: _number6),
            //   ],
            // ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
            child:PinCodeTextField(
                  appContext: context,
                  controller: _pinController,
                  length: 6,
                  onChanged: (value) {
                    print("Current code: $value");
                  },
                  onCompleted: (value) {
                    print("Completed code: $value");
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Color(PublicVar.primaryColor),
                    selectedColor: Color(PublicVar.primaryColor),
                    inactiveColor: Colors.grey,
                  ),
                ),
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
              Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20.0, horizontal: 20.0),
            child: ButtonWidget(
              onPress: () {
                if (!loading) {
                  validationFields();
                }
              },
              width: double.infinity,
              height: 50.0,
              txColor: Colors.black,
              bgColor: Color(PublicVar.primaryColor),
              loading: loading,
              text: "Continue",
              addIconBG: false,
            ),
          ),
          ],
        ),
      ),
      )
      )
    );
  }
}
