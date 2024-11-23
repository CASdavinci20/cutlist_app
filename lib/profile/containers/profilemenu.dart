import 'package:app_framework/app_framework.dart';
import 'package:cutlist/SplashScreen.dart';
import 'package:cutlist/contactus/contactuspage.dart';
import 'package:cutlist/creditsub/creditsubpage.dart';
import 'package:cutlist/feedback/feedbackpage.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:cutlist/mylist/mylistpage.dart';
import 'package:cutlist/profilesetting/profilesettingpage.dart';
import 'package:cutlist/singin_secuirity/signinaecuiritypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main_utils/utils/next_page.dart';

class ProfileMenu {


  Widget  profileMenuCard({
    required Image icon,
    required String title,
    required VoidCallback onTap
  }){

    return SizedBox(
      width: 350,
      child: GestureDetector(
        onTap: onTap,
      child: Column(
        children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFE0f2851),
                  ),
                )  
              ],
            ),
          ),
    
     
        const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          )
       
        ],
      ),
      ),

     const Divider(height: 0.5, color: Colors.grey,)
        ]
      )
      )

    );

  }


  Widget  profileMenu({required BuildContext context}){
    return Container(
      height:550,
       decoration: BoxDecoration(
      color:Color(0xFFEffffff) ,
      borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          profileMenuCard(
            icon: Image.asset(
              'assets/username.png',
              height: 30,
            ), 
            title: 'Personal Data', 
            onTap: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const ProfileSettingPage(),
                      ),
                  ); 

            }
          ),

            profileMenuCard(
            icon: Image.asset(
              'assets/policy.png',
              height: 30,
              color: Color(0xFFEb0b2c3),
            ), 
            title: 'Project', 
            onTap: (){
               NextPage().nextRoute(context, MyListPage());

            }
          ),


            profileMenuCard(
            icon: Image.asset(
              'assets/contact.png',
              height: 30,
            ), 
            title: 'Credit Subscription', 
            onTap: (){
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const CreditSubPage(),
                      ),
                  ); 
              
            }
          ),

            profileMenuCard(
            icon: Image.asset(
              'assets/support.png',
              height: 30,
            ), 
            title: 'Sign-in & Secuirity', 
            onTap: (){
              context;
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const SigninAndSecurityPage(),
                      ),
                  ); 
              
              
            }
          ),

            profileMenuCard(
            icon: Image.asset(
              'assets/policy.png',
              height: 30,
              color: Color(0xFFEb0b2c3),
            ), 
            title: 'FeedBack', 
            onTap: (){
              context;
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const FeedBackPage(),
                      ),
                  ); 
              
            }
          ),

            profileMenuCard(
            icon: Image.asset(
              'assets/contact.png',
              height: 30,
            ), 
            title: 'Contact Us', 
            onTap: (){
               context;
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const ContactUsPage(),
                      ),
                  ); 
              
            }
          ),

           profileMenuCard(
            icon: Image.asset(
              'assets/username.png',
              height: 30,
            ), 
            title: 'Log Out', 
            onTap: ()async{
              PublicVar.appToken = "";
              PublicVar.userAppID = "";
              PublicVar.userPhone = "";
              await SharedStore().removeData( key: 'accountApproved');
              await SharedStore().removeData( key: "user_id");
              await SharedStore().removeData( key: "access_token");



              NextPage().nextRoute(context, SplashScreen());
            }
          )
        ],
      ),

    );
  }
}