import 'dart:ffi';

import 'package:flutter/material.dart';

class CardDetails {

  Widget cardDetails({
    required String cardNum

  }){
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          Padding(
            padding:EdgeInsets.fromLTRB( 20,30,20,10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/mastercardlogo.png',
                  height: 25,
                ),

                SizedBox(
                  width: 150,
                     child: Text(
                      cardNum,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:Color(0xFFE0f2851), 
                      ),
                     ),
                ),

                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFFEfff5f5), 
                    ),
                    child: Center(
               child:  GestureDetector(
                  onTap: (){

                  }, 
                  child: Image.asset(
                    'assets/delete.png',
                    color: Color(0xFFEf57752),
                    height: 17,
                  ),
                  )
                )
                )

              ],
            ),
            ),

          const  Divider(height: 2,color: Colors.black,)

      ],
      ),
    );
  }
}