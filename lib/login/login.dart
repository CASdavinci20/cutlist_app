import 'package:app_framework/app_framework.dart';
import 'package:cutlist/base_page.dart';
import 'package:cutlist/login/container/logincontainer.dart';
import 'package:cutlist/login/createaccount.dart';
import 'package:cutlist/main_utils/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/containers/bottomnav.dart';
import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final LoginContainer loginContainer = LoginContainer();

  final TextEditingController _phoneNumber = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  validationFields() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoading();
      if (await AppActions().checkInternetConnection()) {
        sendToSever();
      } else {
        showLoading();
        AppActions().showErrorToast(
          text: PublicVar.checkInternet,
          context: context,
        );
      }
    }
  }

  sendToSever() async {
    String phoneNumber = '+234${_phoneNumber.text.trim()}';
    String withoutCountryCode = phoneNumber.replaceFirst('+234', '');

    String formattedPhoneNumber = withoutCountryCode.length > 1
        ? withoutCountryCode.substring(1)
        : withoutCountryCode;
    if (formattedPhoneNumber == null || formattedPhoneNumber.isEmpty) {
      throw Exception('Phonenumber cannot be empty');
    }


    Map postdata = {"phoneNumber": "+234${formattedPhoneNumber}"}; //"+2349133456765"
    print(postdata);
    if (await Server()
        .postAction(url: Urls.cutLogin, data: postdata, bloc: appBloc)) {
      print(appBloc.mapSuccess);
      PublicVar.appToken = appBloc.mapSuccess["data"]["access_token"];
      PublicVar.userAppID = appBloc.mapSuccess["data"]["user"]["_id"];
      PublicVar.userName = appBloc.mapSuccess["data"]["user"]["fullName"];
      PublicVar.userPhone = appBloc.mapSuccess["data"]["user"]["phoneNumber"];
      await SharedStore()
          .setData(type: 'bool', data: true, key: 'accountApproved');
      await SharedStore()
          .setData(type: 'string', data: PublicVar.userAppID, key: "user_id");
      await SharedStore()
          .setData(type: 'string', data: PublicVar.appToken, key: "access_token");
      await SharedStore()
          .setData(type: 'string', data: PublicVar.userName, key: "fullName");
      await SharedStore()
          .setData(type: 'string', data: PublicVar.userPhone, key: "phoneNumber");

      if(appBloc.mapSuccess["data"]["user"]["credits"] > 0){
        double creditValue = appBloc.mapSuccess["data"]["user"]["credits"];
        PublicVar.creditAmount = creditValue.roundToDouble();
      }


      print(PublicVar.userOtp);
      print(PublicVar.creditAmount);

      AppActions().showSuccessToast(
        text: 'Login Successful',
        context: context,
      );
      NextPage().nextRoute(context, BottomNav());
    } else {
      showLoading();
      AppActions().showErrorToast(
        text: appBloc.errorMsg,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFEf9f9f9),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 70, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your Phone Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE0f2851),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'we will need to verify your phone number',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 60),
                          child: Column(children: [
                            loginContainer.loginContainer(
                                title: 'Phone Number',
                                keyboardType: "number",
                                textLabel: 'Enter your Phone',
                                inputData: _phoneNumber,
                                icon: Icon(Icons.phone_outlined)),
                            const SizedBox(
                              height: 10,
                            ),
                          ])),


                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
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
                          text: "Login",
                          addIconBG: false,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child:  RichText(
                              text: TextSpan(
                                  children:[
                                    const TextSpan(
                                        text: 'New here?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        )
                                    ),
                                    WidgetSpan(
                                        child: InkWell(
                                            onTap: (){
                                              context;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context)=>  CreateAccountPage())
                                              );

                                            },
                                            child: Text(
                                                ' Create Account.',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(PublicVar.primaryColor),
                                                )
                                            )
                                        )
                                    )

                                  ]
                              )
                          )
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
