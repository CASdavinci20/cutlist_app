import 'dart:async';

import 'package:app_framework/app_framework.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
 
import 'login/createaccount.dart';
import 'main_utils/bloc/app_bloc.dart';
import 'main_utils/utils/next_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required  });



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEf9f9f9),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      "Vantcutz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color(PublicVar.primaryColor)),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 300,
                      width: 250,
                      child: Image.asset(
                        "assets/woodworker.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 300,
                      height: 100,
                      child: Text(
                        'From concept To Cut - In Seconds',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFE0f2851),
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                Text(
                  'Designed for woodworkers, by woodworkers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE0f2851),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                    const SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccountPage()),
                          );
                        },
                        child: Image.asset(
                          'assets/buttonnext.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
