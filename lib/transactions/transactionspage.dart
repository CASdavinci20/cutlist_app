import 'package:cutlist/transactions/containers/transactionscontainer.dart';
import 'package:flutter/material.dart';



class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  TransactionsPageState createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {

  final TransactionsContainer transactions  = TransactionsContainer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEfafaff),
      body: SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child:Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                     Navigator.of(context).pop();
                  },
              child:  Image.asset(
                  'assets/arrow_left.png',
                  height: 40,
                )
                ),

                const SizedBox(width: 10,),
              const  Text(
                  'Transactions',
                  style:TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
              ],
            ),

            SizedBox(
              width: 320,
              height: 50,
              child:
              GestureDetector(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/wallet.png',
                    height: 20,
                  ),
                  SizedBox(width: 5,),
                 const Text(
                   'Purchase Credits ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE0f2851),
                      ),
                    ),
                ],
              ),
              )
            ),

            const SizedBox(height: 5,),
            transactions.transactions(
              monthOfYear: 'July 2024', 
              dateBought: 'Tuesday 30th July. 04:09pm', 
              trsactionTitle: 'Wallet Top Up', 
              coin: 30
              ),

               transactions.transactions(
              monthOfYear: 'July 2024', 
              dateBought: 'Tuesday 30th July. 04:09pm', 
              trsactionTitle: 'Wallet Top Up', 
              coin: 30
              )
            
          ],
        ) ,
      ),
      )
    );
  }
}