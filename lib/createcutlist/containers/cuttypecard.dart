import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CutTypeCard{

  Widget  cutTypeCard({
      required String title, selected,

      required VoidCallback onTap
  }){
    return  GestureDetector(
      onTap: onTap,
    child: Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      color: selected == title?Colors.black: Colors.grey ,
       ),
       child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    )
    )   
    );

  }

}