import 'package:cutlist/purchasecredit/purchasecredit.dart';
import 'package:cutlist/transactions/transactionspage.dart';
import 'package:flutter/material.dart';


class CreditContainer{
  Widget credit(
    {
      required int numCoin,
      required BuildContext context
    }
  ){

    return Container(
      width: 350,
      height: 150,
      decoration: BoxDecoration(
      color:Color(0xFFEffffff) ,
      borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child:Column(
        children: [
          
          SizedBox(
            height: 110,
            width: 300,
          child:   Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(
                height: 80,
            child:  Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                'Credit Balance',
                style: TextStyle(
                  color: Color(0xFFE0f2851),
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),


              Row(
                children: [
                  Image.asset(
                    'assets/coin.png',
                    height: 30,
                  ),

                  Text(
                    "$numCoin",
                    style:const TextStyle(
                  color: Color(0xFFE0f2851),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ), 
                  )
                ],
              )   
                ],
              ),
          ),
             

             Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const TransactionsPage(),
                      ),
                  ); 

                  },
                 child:  Image.asset(
                'assets/arrowright.png',
                 height: 35,
              ),
                ),
              
            
               GestureDetector(
                onTap: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const PurchaseCreditPage(),
                      ),
                  ); 

                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/wallet.png',
                      height: 20,
                    ),
              const SizedBox(width: 10,),
                  const  Text(
                      'Purchase credit',
                     style: TextStyle(
                  color: Color(0xFFE0f2851),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                    )
                  ],
                ),
              )

              ],
             )

            ],
          )
          )
        ],
      ) ,
      )
    );

  }
}