import 'package:flutter/material.dart';



class ContactUs {
  Widget contactUsCard(
    {
    required Image icon,
    required String title,
    required VoidCallback onTap
    }
  ){
    return SizedBox(
      width: 350,
      child: Column(
        children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
                icon,
           SizedBox(
            width: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0f2851),
                  ),
                )  
              ],
            ),
          ),
    
       IconButton(
      onPressed: onTap,
        icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          )
       )
        ],
      ),
      ),

        ]
      )

    );
  }


  Widget contactUs(){
    return  Container(
      height:350,
       decoration: BoxDecoration(
      color:Color(0xFFEffffff) ,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          contactUsCard(
            icon: Image.asset(
              'assets/chat.png',
            color:   Color(0xFFEbfbfbf),
              height: 25,
            ), 
            title: 'Chat', 
            onTap: (){
             

            }
          ),
       const SizedBox(height: 10,),
       const Divider(height: 0.5, color: Colors.grey,),
       const SizedBox(height: 10,),

            contactUsCard(
            icon: Image.asset(
              'assets/phone.png',
              height: 25,
              color: Color(0xFFEbfbfbf),
            ), 
            title: '+42 564 342 786', 
            onTap: (){
              
            }
          ),
            const SizedBox(height: 10,),
          const Divider(height: 0.5, color: Colors.grey,),
          const SizedBox(height: 10,),

            contactUsCard(
            icon: Image.asset(
              'assets/message.png',
              height: 25,
             color:  Color(0xFFEbfbfbf),
            ), 
            title: 'contact@onelook.com', 
            onTap: (){
             
            }
          ),
          const SizedBox(height: 10,),
          const Divider(height: 0.5, color: Colors.grey,),
          const SizedBox(height: 10,),

            contactUsCard(
            icon: Image.asset(
              'assets/location.png',
              height: 25,
              color: Color(0xFFEbfbfbf),
            ), 
            title: 'One Look Corp.', 
            onTap: (){
             
              
            }
            
          ),

        const  Center(
            child: SizedBox(
              width: 220,
              child: Text(
                '1277 Saige Point Apt. 14065479 West Shaun,Oklahoma',
                   style:const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
              ),
            ),
          )

          
        ],
      ),

    );

  }
}