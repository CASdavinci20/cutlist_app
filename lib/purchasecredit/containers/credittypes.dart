import 'package:flutter/material.dart';


class CreditTypeContainer{
  Widget creditType(
    {
      required int creditAmount,
      required int price,
      required VoidCallback ontap
    }
  ){
    return Container(
      width: 350,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFEffffff), 
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child:InkWell(
          onTap: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/coin.png',
              height: 40,
            ),

            SizedBox(
              width: 120,
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
                '$creditAmount',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE0f2851),
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                'Credit',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFE0f2851),
                ),
              )
                ],
              )    
            ),
            SizedBox(
              child: Column(
                children: [
                   Text(
                'Buy now at',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFE0f2851),
                ),
              ),
              const SizedBox(height: 5,),
               Text(
                'N $price',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE0f2851),
                ),
              )
                ],
              ),
            )
          ],
        ),
      )
        ),
    );
  }
}