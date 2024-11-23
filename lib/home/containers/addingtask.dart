import 'package:cutlist/mylist/mylistpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main_utils/models/PublicVar.dart';
import '../../main_utils/widgets/global_widgets.dart';

class AddTask {
  Future addTask({
    required TextEditingController projectName,
    required BuildContext context,
    required VoidCallback onTap 
  }) {
    late bool loading = false;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFEf9f9f9) ,
          contentPadding: EdgeInsets.zero, 
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20), 
                  const  Text(
                      'Create a Project',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color:Color(0xFFE0f2851), 
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: projectName,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Image.asset(
                            'assets/policy.png',
                            height: 10,
                            width: 10,
                          ),
                        ),
                        labelText: 'Enter Project name',
                        fillColor: Color(0xFFFAFAFF),
                        filled: true,
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFCACACF),
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFB1B2B4), width: 2.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ButtonWidget(
                          onPress: () {
                            if(!loading){
                            onTap;
                            }
                          },
                          width: double.infinity,
                          height: 50.0,
                        radius: 50.0,
                          txColor: Colors.black,
                          bgColor: Color(PublicVar.primaryColor),
                          loading: loading,
                          text: "Save",
                          addIconBG: false,
                        ),
                      
                      // child: GestureDetector(
                      //   onTap:onTap,
                      //   child: Image.asset(
                      //     'assets/createtaskbutton.png',
                      //     height: 100,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:Padding(
                  padding: EdgeInsets.all(15),
                child: GestureDetector(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFf0f1f9),
                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Center(
                      
                      child: Text(
                        'X',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                        ),
                    ),
                    
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              )
            ],
          ),
        );
      },
    );
  }
}

