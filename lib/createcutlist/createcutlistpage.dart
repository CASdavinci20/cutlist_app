import 'dart:ffi';

import 'package:cutlist/createcutlist/containers/cuttypecard.dart';
import 'package:cutlist/createcutlist/containers/createcutlistinput.dart';
import 'package:cutlist/createcutlist/containers/explanation.dart';
import 'package:cutlist/cutlistsummary/cutlistsummarypage.dart';
import 'package:flutter/material.dart';

class CreateCutListPage extends StatefulWidget {
  const CreateCutListPage({super.key});

  @override
  CreateCutListPageState createState() => CreateCutListPageState();
}

class CreateCutListPageState extends State<CreateCutListPage> {

  final CutTypeCard cutTypeCard =  CutTypeCard();
  final CreateCutListInput   cutListInput = CreateCutListInput();
  final Explanation  explanation = Explanation();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration:const BoxDecoration(
                  color: Color(0xFFf0f1f9),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child:const Center(
                  child: Text(
                    'X',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           const   SizedBox(height: 70), 
           const   Center(
                child: Text(
                  'Create Cut List',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE0f2851),
                  ),
                ),
              ),
              SizedBox( height: 10,),

              SizedBox(
                width: 350,
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                const  Text(
                    'Cut Type',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0f2851),
                  ),
                  ),
                  SizedBox(height: 10,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                       cutTypeCard.cutTypeCard(
                        title: 'Door Cut',
                         onTap: (){
                          
                         }
                         ),
                         SizedBox( width: 10,),

                         cutTypeCard.cutTypeCard(
                        title: 'Shelf Cut',
                         onTap: (){
                          
                         }
                         ),
                        
                         SizedBox( width: 10,),
                          cutTypeCard.cutTypeCard(
                        title: 'Console Cut',
                         onTap: (){
                          
                         }
                         )
                      ],
                    ),
                  )

                ],
              )
              ),

   const   SizedBox(height: 20,),
             SizedBox(
                width: 350,
                height: 500,
                child: Column(
                  children: [
              const    SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Measurement',
                   style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0f2851),
                  ),
                        ),

                          Text(
                          '(2 long)',
                   style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEf5af71),
                  ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                   cutListInput.cutInput(context),
                   SizedBox(height: 200,),

                   Divider(height: 5,color: Color(0xFFE0b1b2b4)),

                   const SizedBox(height: 10,),
                   explanation.explaination(),
                   SizedBox(height: 30,),

                   Center(
                    child: GestureDetector(
                      onTap: (){
                        context;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CutListSummaryPage()),
                            );
                        
                      },
                      child: Image.asset(
                        'assets/previewbutton.png',
                        height: 50,

                      ),
                    ),
                   )
                  ],
                ),
              ),
        
            ],
          ),
        ],
      ),
      )
      )
    );
  }
}

