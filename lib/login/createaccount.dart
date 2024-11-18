import 'package:cutlist/login/container/logincontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';
import 'login.dart';
import 'verificationpage.dart';



class CreateAccountPage extends StatefulWidget{
  const CreateAccountPage ({super.key});


 @override
  CreateAccountPageState  createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage>{
 
  final TextEditingController _fullNameController = TextEditingController();
 final TextEditingController _phoneController = TextEditingController();
 final LoginContainer loginContainer = LoginContainer();
GlobalKey <FormState> _formKey = GlobalKey<FormState>();
 late AppBloc appBloc;
  bool isChecked = false;

  
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
    String phoneNumber = '+234${_phoneController.text.trim()}';
    String withoutCountryCode = phoneNumber.replaceFirst('+234', '');

     String formattedPhoneNumber = withoutCountryCode.length > 1
    ? withoutCountryCode.substring(1) 
    : withoutCountryCode;
     if (formattedPhoneNumber == null || formattedPhoneNumber.isEmpty) {
    throw Exception('Username cannot be empty');
  }

  if (_fullNameController.text == null || _fullNameController.text.isEmpty) {
    throw Exception('Password cannot be empty');
  }else{
    print('IT IS THE ${formattedPhoneNumber} ${_fullNameController}');
  }


     Map postdata = {
      "fullName":'${_fullNameController.text}',
      "phoneNumber":'+234${formattedPhoneNumber}'
    };
    print(postdata);
    if(await Server().postAction(url:Urls.cutUsers,data:postdata,bloc:appBloc)){
      print(appBloc.mapSuccess.runtimeType);
      print("Full mapSuccess: ${appBloc.mapSuccess}");
        // PublicVar.userPhone=appBloc.mapSuccess["data"]["user"]["phoneNumber"];
        // PublicVar.userName=appBloc.mapSuccess["data"]["user"]["fullName"];
         CircularProgressIndicator();
      AppActions().showErrorToast(
        text: 'Registration Successful',
        context: context,
      );

      NextPage().nextRoute(context, VerificationPage());

    }

   }


  @override
  Widget build(BuildContext context){
    appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEf9f9f9),
      body: SingleChildScrollView(
       child: Form(
        key: _formKey,
      child: Padding(
          padding: EdgeInsets.fromLTRB(  30,70,30, 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const  Text(
                'Enter your contact details',
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
                title: 'Full Name', 
                textLabel: 'Enter your name', 
                inputData: _fullNameController , 
                icon: Icon(
                  Icons.person_2_outlined
                )
                ),
                const SizedBox(height: 10,),
                 loginContainer.loginContainer(
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
            setState(() {
              isChecked = value ?? false; // Update the state with the new value
            });
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
          validationFields();
        },
        child: Image.asset(
          'assets/submitbutton.png'
        ),
      ),
   )
    ),
      SizedBox(height: 40,),
      
    

    Center(
     child:  RichText(
        text: TextSpan(
          children:[
          const TextSpan(
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
       child:const Text(
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
              
      )
                

            ],
          ),
          ),
      )
      )
    );
  }
}