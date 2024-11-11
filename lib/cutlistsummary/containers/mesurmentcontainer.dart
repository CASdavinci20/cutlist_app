import 'package:flutter/material.dart';


class MesurementContainer {
  Widget mesurementContainer({
    required String cutType,
    required String long,
    required String width,
    required String quantity,
  }){
    return SizedBox(
           height: 80,
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cutType,
            style:const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFFE0f2851),
            ),
          ),

          SizedBox(
             height: 60,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     RichText(
                  text: TextSpan(
                    children: [
                    const  TextSpan(
                        text: 'L - ',
                        style: TextStyle(
                          fontSize: 10,
                          color:Color(0xFFEf5af71),
                          fontWeight: FontWeight.w600
                        )
                      ),
                      TextSpan(
                        text: long,
                         style:const TextStyle(
                        fontSize: 22,
                        color:Color(0xFFE0f2851),
                        fontWeight: FontWeight.w600
                        )

                      ),
                    ]
                  )
                ),
              const  SizedBox(width: 20,),

                  RichText(
                  text: TextSpan(   
                  children: [
                    
                     const   TextSpan(
                        text: 'W - ',
                        style: TextStyle(
                          fontSize: 10,
                          color:Color(0xFFEf5af71),
                          fontWeight: FontWeight.w600
                        )
                      ),
                      TextSpan(
                        text: width,
                         style:const TextStyle(
                        fontSize: 22,
                        color:Color(0xFFE0f2851),
                        fontWeight: FontWeight.w600
                        )

                      ),


                    ]
                  )
                  ),
                  const  SizedBox(width: 100,),

                   RichText(
                  text: TextSpan(   
                  children: [
                     const  TextSpan(
                        text: 'D - ',
                        style: TextStyle(
                          fontSize: 10,
                          color:Color(0xFFEf5af71),
                          fontWeight: FontWeight.w600
                        )
                      ),
                      TextSpan(
                        text: quantity,
                         style:const TextStyle(
                        fontSize: 22,
                        color:Color(0xFFE0f2851),
                        fontWeight: FontWeight.w600
                        )

                      ),
                    
                    ]
                  )
                  )

                  ],
                ),

                Transform.translate(
                  offset: const Offset(0, -14), // Move the image up by 10 pixels
                  child: Center(
                    child: Image.asset(
                      'assets/yellowpolicy.png',
                      height: 25,
                    ),
                  ),
                ),

              ],
            ),
          ),

        const  Divider(height: 2, color: Colors.black,)
           
        ],
      ),

    );
  }


  
}