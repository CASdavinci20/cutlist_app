import 'package:flutter/material.dart';

class  TransactionsContainer {

  Widget transactions({
    required String monthOfYear,
    required String dateBought,
    required String trsactionTitle,
    required int coin

  }){
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFEffffff), 
      ),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child:Column(
        children: [
       Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                  monthOfYear,
                  style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFE0f2851),
                      ), 
                ),

              const SizedBox(height: 5,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  trsactionTitle,
                  style:const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/coin.png',
                      height: 30,
                    ),
                  const  SizedBox(width: 7,),
                     Text(
                  '$coin',
                  style:const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
                  ],
                )
              ],
             ),
               
              const SizedBox(height: 5,),
               Text(
                  dateBought,
                  style:const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
          ],
        ),
      ),
      Divider(height: 2,color: Colors.black,),
        ]
      )
      )
    );
  }
}