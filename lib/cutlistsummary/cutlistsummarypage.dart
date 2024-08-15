import 'package:cutlist/cutlistsummary/containers/mesurmentcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

 class CutListSummaryPage extends StatefulWidget{
  const CutListSummaryPage({super.key});

  @override
  CutListSummaryPageState  createState()=> CutListSummaryPageState();

}

class CutListSummaryPageState extends State<CutListSummaryPage>{
  final MesurementContainer  mesurement = MesurementContainer();


  @override
  Widget build(BuildContext context){
    return Scaffold(
          backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            children: [
              SizedBox(
                width: 320,
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                       
                        children: [
                          GestureDetector(
                            onTap: (){
                               Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/arrow_left.png',
                              height: 30,
                            ),
                          ),
                       const   SizedBox(width: 10,),

                         const Text(
                            'Cut List Summary',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE0f2851),
                            ),
                          )
                        ],
                      ),
                    ),
 

                  SizedBox(
                    height: 35,
                    width: 35,
                 child: ElevatedButton(
                  
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEf2c94c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),   
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4)
                  ),  
                    onPressed: (){

                    }, 
                    child:const Center(
                  child:   Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                      ),
                    )
                    )
                    )
                  )
                  ],
                ),
              ),

             const SizedBox(height: 20,),

             mesurement.mesurementContainer(
              cutType: 'Frame Vertical', 
              long: '224.5', 
              width: '22.5', 
              quantity: '5'
              ),
             const SizedBox(height: 10,),

              mesurement.mesurementContainer(
              cutType: 'Frame Vertical', 
              long: '224.5', 
              width: '22.5', 
              quantity: '5'
              ),

            const  SizedBox(height: 20,),


            Image.asset(
              'assets/savebutton.png',
              height: 70,
              width: 300,
            )

            ],
          ),
          ),
      ),
    );
      }
}