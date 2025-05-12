import 'package:app_framework/app_framework.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CreateCutListInput {

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();

  Widget createCutListCard({
    required String title,
    required String tag,
    required String explaination,
    required TextEditingController cutData,
    Key? key,
     keyboardType

  }){
     return  SizedBox(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 7), 
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE0f2851),
              ),
            ),
             Text(
              explaination,
              style: TextStyle(
                fontSize: 10,
                // fontWeight: FontWeight.w500,
                color: Color(0xFFE0f2851),
              ),
            ),
            SizedBox(height: 5,),
        TextFormField(
          controller: cutData,
          validator: Validation().text,
          textCapitalization: TextCapitalization.words,
          keyboardType: keyboardType=="text"?TextInputType.text:TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: title,

            fillColor: const Color(0xFFE0fafaff),
            filled: true,
            labelStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFFE0f2851),
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE0b1b2b4), width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
          ]
      ),
      )
    );
  }



   cutInput(context){
      return  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [   
              createCutListCard(
                tag: 'Height of Door',
                explaination: '',
                title: 'Height', 
                cutData: _heightController
                ),
                const SizedBox(width: 10,),
                 createCutListCard(
                  tag: 'Width of Door',
                  explaination: '',
                title: 'Width', 
                cutData: _widthController
                ),
                 const SizedBox(width: 10,),
                  createCutListCard(
                    tag: 'Wall Thickness',
                    explaination: '',
                title: 'Dept',
                cutData: _deptController ,
                  )
                ]
      );
    }

}