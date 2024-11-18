import 'package:cutlist/creditsub/container/carddetails.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:cutlist/profile/containers/creditcontainer.dart';
import 'package:flutter/material.dart';

class CreditSubPage extends StatefulWidget {
  const CreditSubPage({super.key});

  @override
  CreditSubPageState createState() => CreditSubPageState();
}

class CreditSubPageState extends State<CreditSubPage> {

  final CreditContainer creditContainer = CreditContainer();
  final CardDetails cardDetails = CardDetails();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFEfafaff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
             child:  Image.asset(
                'assets/arrow_left.png',
                height: 40,
              )
              ),

            const  SizedBox(height: 20,),
            creditContainer.credit(
              context: context,
              numCoin: PublicVar.creditAmount,
            ),
         const   SizedBox(height: 50,),

            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              const    Text(
                    'Manage Cards',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0f2851)
                    ),
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                     child:  Image.asset(
                        'assets/addbutton.png',
                        height: 20,
                      )
                      ),
                    const  SizedBox(width: 5),
                   const   Text(
                        'Add payment method',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0f2851)
                        ),
                      )
                    ],
                  )
                ],
              ),

            ),

            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Color(0xFFEffffff),  
              ),
             child:  Column(
                children: [
                  cardDetails.cardDetails(
                    cardNum: '****3917'
                    )
                ],
              ),
            )
            ],
          ),
          ),
      ),
    );
  }
}