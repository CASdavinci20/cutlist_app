import 'package:flutter/material.dart';

class Notifications {
   Widget notifications({
    required String notifications,
    required VoidCallback ontap
   }){

    return ListTile(
      leading: Icon(
        Icons.message_outlined,
        color: Colors.grey[500],
        size: 20,
      ),
         title: Text(
          notifications,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE0f2851),
          ),
         ),

         trailing:Icon(
          Icons.arrow_forward_ios,
          size: 15,
         ) ,
         onTap: ontap,
    );
    // return GestureDetector(
    //   onTap: (){
        
    //   },
    //  child:   SizedBox(
    //   width: 330,
    //   height: 100,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [   
    //    Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [

    //       SizedBox(
    //                 height: 35,
    //                 width: 35,
    //              child: ElevatedButton(
                  
    //                style: ElevatedButton.styleFrom(
    //                 backgroundColor: Color(0xFFEf0f1f9),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(50),   
    //                 ),
    //                 padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4)
    //               ),  
    //                 onPressed: (){

    //                 }, 
    //                 child:const Center(
    //               child:   Icon(
    //                 Icons.verified,
    //                 color: Colors.lightBlue,
    //                 size: 25,
    //               )
    //                 )
    //                 )
    //               ),

    //               SizedBox(
    //                 width: 270,
    //                 child: Text(
    //                   notifications,
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w600,
    //                      color:Color(0xFFE0f2851), 
    //                   ),
    //                 ),
    //               ),
    //     ],
    //   ),
    //   const SizedBox(height: 10,),
    // const  Divider(height: 2,color: Colors.black,),
    //     ]
    //   )
    //  )
    // );
   }
}