import 'package:flutter/material.dart';

import 'containers/profiledetail.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileDetailsInput _profileTile = ProfileDetailsInput();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            backgroundColor:Color(0xFFEfafaff),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    
                  },
               child:  Image.asset(
                  'assets/arrow_left.png',
                  height: 30,
                )
                ),

                Center(
                  child: Column(
                    children: [
               const   Text(
                    'Profile Setting',
                    style: TextStyle(
                      color: Color(0xFFE0f2851),
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),

                  Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Optional: Add behavior when the image itself is tapped
          },
          child:Image.asset(
              'assets/Ellipse.png', 
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            )
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
          onTap: (){

           },
            child:const CircleAvatar(
              radius: 20,
              backgroundColor:Color(0xFFEf2d382),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),

    _profileTile.profileTile(
      title: 'Name :', 
      value: ''),

          _profileTile.profileTile(
      title: 'Email :', 
      value: ''),
      
          _profileTile.profileTile(
      title: 'Phonenumber :', 
      value: ''),
                    ]
                  )
                )
              ]
            )
          )
        )

    );
  }
}
