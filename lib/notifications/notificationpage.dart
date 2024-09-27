import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:cutlist/notifications/containers/notifications.dart';
import 'package:cutlist/home/containers/addingtask.dart';

class NotificationPage extends StatefulWidget{
  final scaffoldKey;
  const NotificationPage ({super.key,  this.scaffoldKey});


  @override
  NotificationPageState createState()=> NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>{
  final  TextEditingController __controllerProjectName = TextEditingController();

  final Notifications notification =  Notifications();
  final BottomNav   bottomNav = BottomNav();
  final AddTask addTask = AddTask();

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Color(0xFFfffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE0f2851),
              ),
             ),
             const SizedBox(height: 10,),

             notification.notifications(
              notifications: 'You have achieved your Step Goal for today',
              )
             
            ],
          ),
          ),
      ),
    );
  }

}