import 'package:cutlist/createpin/containers/createpininput.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  CreatePinPageState createState() => CreatePinPageState();
}

class CreatePinPageState extends State<CreatePinPage> {
  final CreatePinInput createPinInput = CreatePinInput();

  final TextEditingController _controllerPin1 = TextEditingController();
   final TextEditingController _controllerPin2 = TextEditingController();
    final TextEditingController _controllerPin3 = TextEditingController();
     final TextEditingController _controllerPin4 = TextEditingController();
      final TextEditingController _controllerPin5 = TextEditingController();
       final TextEditingController _controllerPin6 = TextEditingController();
        

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
               child:  Image.asset(
                  'assets/arrow_left.png',
                  height: 30,
                ),
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
            
            const SizedBox(height: 20,),

          const  Text(
             'Create a 6-digit PIN that you can remember ',
              style: TextStyle(
              color:  Color(0xFFE0333333),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ), 
            ),

          const  SizedBox(height: 10,),

            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //   createPinInput.createPinInput(
            //    inputNumber:  _controllerPin1
            //   ),
            //    createPinInput.createPinInput(
            //    inputNumber:  _controllerPin2
            //   ),
            //    createPinInput.createPinInput(
            //    inputNumber:  _controllerPin3
            //   ),
            //     createPinInput.createPinInput(
            //    inputNumber:  _controllerPin4
            //   ),
            //    createPinInput.createPinInput(
            //    inputNumber:  _controllerPin5
            //   ),
            //                  createPinInput.createPinInput(
            //    inputNumber:  _controllerPin6
            //   ),
            // ],
            // ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
            child:PinCodeTextField(
                  appContext: context,
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
          ]
        )
        )
        );

}
}