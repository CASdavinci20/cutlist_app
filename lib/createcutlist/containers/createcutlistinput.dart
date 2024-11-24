import 'package:flutter/material.dart';

class CreateCutListInput {

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();

  Widget createCutListCard({
    required String title,
    required TextEditingController cutData,
     keyboardType

  }){
     return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0), 
        child: TextFormField(
          controller: cutData,
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
      ),
    );
  }



   cutInput(context){
      return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [   
              createCutListCard(
                title: 'Height', 
                cutData: _heightController
                ),
                const SizedBox(width: 10,),
                 createCutListCard(
                title: 'Width', 
                cutData: _widthController
                ),
                 const SizedBox(width: 10,),
                  createCutListCard(
                title: 'Dept',
                cutData: _deptController ,
                  )
                ]
      );
    }

}