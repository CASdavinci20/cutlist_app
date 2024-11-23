import 'dart:async';

import 'package:app_framework/app_framework.dart';
import 'package:cutlist/WelcomePage.dart';
import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
 
import 'base_page.dart';
import 'main_utils/bloc/app_bloc.dart';
import 'main_utils/utils/next_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppBloc appBloc;
  @override
  void initState() {

    Timer(const Duration(seconds: 6), () {
      checkStore();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      body: Center(child: Text(
        "Vancutz",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Color(PublicVar.primaryColor)),
      ),),
    );
  }

 

  checkStore() async {
    if (await SharedStore().getData(type: 'bool', key: 'accountApproved') !=
        null) {
      PublicVar.accountApproved =
      await SharedStore().getData(type: 'bool', key: 'accountApproved');
    }
    if (await SharedStore().getData(key: 'user_id', type: "string") != null) {
      PublicVar.userAppID =
      await SharedStore().getData(key: 'user_id', type: "string");
    }

    if (await SharedStore().getData(key: 'access_token', type: "string") != null) {
      PublicVar.appToken =
      await SharedStore().getData(key: 'access_token', type: "string");
    }

    if (PublicVar.accountApproved == false) {
      //NextPage().clearPages(context, Login());
      NextPage().nextRoute(context, WelcomePage());
    } else {
      //extPage().clearPages(context, Login());
      //NextPage().clearPages(context, Base());
      NextPage().clearPages(context, BottomNav());
      //NextPage().clearPages(context, Resources());
    }
  }
}
