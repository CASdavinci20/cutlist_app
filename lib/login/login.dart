import 'package:cutlist/login/container/logincontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';
import 'verificationpage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final  LoginContainer  loginContainer = LoginContainer();

  final TextEditingController   _phoneNumber = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppBloc appBloc;

    validationFields()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

     if (await AppActions().checkInternetConnection()) {
      sendToSever();
     }else{
      // showLoading();
      AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
   }


   sendToSever() async{
     Map postdata = {
      "phoneNumber": "+2349133456765"
    };
    print(postdata);
    if(await Server().postAction(url:Urls.cutLogin,data:postdata,bloc:appBloc)){
      print(appBloc.mapSuccess);
      PublicVar.appToken=appBloc.mapSuccess["data"]["access_token"];
       PublicVar.userAppID=appBloc.mapSuccess["data"]["user"]["_id"];
      PublicVar.userPhone=appBloc.mapSuccess["data"]["user"]["phoneNumber"];
        PublicVar.userName=appBloc.mapSuccess["data"]["user"]["fullName"];
         PublicVar.creditAmount=appBloc.mapSuccess["data"]["user"]["credits"];
        // PublicVar.userOtp = appBloc.mapSuccess["data"]["user"]["otp"];
        print(PublicVar.userOtp);
      NextPage().nextRoute(context, VerificationPage());

    }

   }

  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    return  Scaffold(
       backgroundColor: const Color(0xFFEf9f9f9),
      body: SingleChildScrollView(
       child:  Form(
          key: _formKey,
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
           validationFields();
          // Navigator.push(context, 
          // MaterialPageRoute(builder: (context)=> VerificationPage())
          // );
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

      )
    );
  }
}