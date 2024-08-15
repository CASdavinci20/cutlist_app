import 'package:cutlist/home/containers/addingtask.dart';
import 'package:cutlist/home/homepage.dart';
import 'package:cutlist/mylist/mylistpage.dart';
import 'package:cutlist/notifications/notificationpage.dart';
import 'package:cutlist/profile/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav {
  

  Widget bottomNave(context) {
    return ClipRRect(
      borderRadius:const BorderRadius.vertical(top: Radius.circular(50)),
  child:   BottomAppBar(
      height: 70,
      color: Colors.white,
      shape:const CircularNotchedRectangle(
      ),
      notchMargin: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            child: Image.asset(
              'assets/home.png',
              height: 25,
              ),
            onTap:() {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const HomePage(),
                      ),
                  ); 
            },
          ),
          GestureDetector(
            child:Image.asset(
              'assets/policy.png',
              height: 25,
              color: Color(0xFFEb0b2c3),
              ),
            onTap: ()async {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const MyListPage(),
                      ),
                  ); 
            
            },
          ),
          const SizedBox(width: 40), 
          GestureDetector(
            child: Image.asset(
              'assets/notification.png',
              height: 25,
              ),
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const NotificationPage(),
                      ),
                  ); 
            },
          ),
          GestureDetector(
            child: Image.asset(
              'assets/username.png',
              height: 25,
              ),
            onTap: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                            builder: (context) =>const ProfilePage(),
                      ),
                  ); 

            },
          ),
        ],
      ),
  )
    );
  }
}