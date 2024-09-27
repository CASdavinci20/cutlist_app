import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:cutlist/profile/containers/creditcontainer.dart';
import 'package:cutlist/profile/containers/profilemenu.dart';
import 'package:cutlist/home/containers/addingtask.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  final scaffoldKey;
  const ProfilePage({super.key, this.scaffoldKey});
  
  @override
  ProfilePageState createState()=> ProfilePageState();
}

class ProfilePageState  extends State<ProfilePage>{

  final CreditContainer  credit =CreditContainer();
  final ProfileMenu  profileMenu = ProfileMenu();
  final BottomNav  bottomNav = BottomNav();
    final AddTask addTask = AddTask();
    TextEditingController _controllerProjectName = TextEditingController();

  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEfafaff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              child: Row(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                         GestureDetector(
                      onTap: (){
                           
                      },
                      child: Image.asset(
                              'assets/Ellipse.png', 
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                    ),
                   const  SizedBox( width: 10,),
                       const SizedBox(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kelechi',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFE0f2851),
                                ),
                              ),

                               Text(
                                '0702344556677',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),

                              
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                ],
              ), 
              ),

            const  SizedBox(height: 10,),

              credit.credit(
                context: context,
                numCoin: 45
                ),

               const SizedBox(height: 20,),

               profileMenu.profileMenu(context: context)


            ],
          ),
          ),
      ),
    );
  }
}