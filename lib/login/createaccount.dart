import 'package:app_framework/app_framework.dart';
import 'package:cutlist/base_page.dart';
import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:cutlist/login/container/logincontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';
import '../main_utils/widgets/global_widgets.dart';
import 'login.dart';
import 'verificationpage.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final LoginContainer loginContainer = LoginContainer();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppBloc appBloc;
  bool isChecked = false;
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
        AppActions().showErrorToast(
          text: PublicVar.checkInternet,
          context: context,
        );
      }
    }
  }

  sendToSever() async {
    String phoneNumber = '+234${_phoneController.text.trim()}';
    String withoutCountryCode = phoneNumber.replaceFirst('+234', '');

    String formattedPhoneNumber = withoutCountryCode.length > 1
        ? withoutCountryCode.substring(1)
        : withoutCountryCode;
    if (formattedPhoneNumber == null || formattedPhoneNumber.isEmpty) {
      throw Exception('Phonenumber cannot be empty');
    }

    if (_fullNameController.text == null || _fullNameController.text.isEmpty) {
      throw Exception('Name cannot be empty');
    } else {
      print('IT IS THE ${formattedPhoneNumber} ${_fullNameController}');
    }

    Map postdata = {
      "fullName": '${_fullNameController.text}',
      "phoneNumber": '+234${formattedPhoneNumber}'
    };
    print(postdata);
    if (await Server()
        .postAction(url: Urls.cutUsers, data: postdata, bloc: appBloc)) {
      if(appBloc.mapSuccess["data"]!=null){
        var response=appBloc.mapSuccess["data"];
        await Server().postAction(url: Urls.cutVerification, data: {"phoneNumber":response["phoneNumber"], "otp":response["otp"]}, bloc: appBloc);
        await Server().postAction(url: Urls.cutLogin, data: {"phoneNumber":response["phoneNumber"]}, bloc: appBloc);


      print("Full mapSuccess: ${appBloc.mapSuccess}");
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
      AppActions().showSuccessToast(
        text: 'Registration Successful',
        context: context,
      );
       //NextPage().nextRoute(context, VerificationPage());
      NextPage().nextRoute(context, BottomNav());
      }else {
        showLoading();
        AppActions().showErrorToast(
          text: appBloc.mapSuccess["msg"],
          context: context,
        );
      }
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
                const Text(
                  'Enter your contact details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
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
                        'will need to verify your phone number',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 60),
                          child: Column(children: [
                            loginContainer.loginContainer(
                                title: 'Full Name',
                                textLabel: 'Enter your name',
                                inputData: _fullNameController,
                                icon: Icon(Icons.person_2_outlined)),
                            const SizedBox(
                              height: 10,
                            ),
                            loginContainer.loginContainer(
                                title: 'Phone Number',
                                keyboardType: "number",
                                textLabel: '090-70.....',
                                inputData: _phoneController,

                                icon: Icon(Icons.phone_outlined)),
                          ])),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(height: 4, color: Colors.black45),
                      const SizedBox(
                        height: 20,
                      ),
                  Text(
                      'By clicking on the registration button, you accept our Privacy Policy and Term of Use', textAlign: TextAlign.center,
                ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
                        child: ButtonWidget(
                          onPress: () {
                            validationFields();
                            // if (!loading) {
                            //   validationFields();
                            // }
                          },
                          width: double.infinity,
                          height: 50.0,
                          txColor: Colors.black,
                          bgColor: Color(PublicVar.primaryColor),
                          loading: loading,
                          text: "Register",
                          addIconBG: false,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: RichText(
                              text: TextSpan(children: [
                        const TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        WidgetSpan(
                            child: InkWell(
                                onTap: () {
                                  context;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Loginpage()));
                                },
                                child: Text(' Login here.',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Color(PublicVar.primaryColor),
                                    ))))
                      ])))
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
