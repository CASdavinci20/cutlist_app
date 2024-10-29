import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:cutlist/notifications/containers/notifications.dart';
import 'package:cutlist/home/containers/addingtask.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/urls.dart';

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
  late AppBloc appBloc;
  late bool isLoading = false;

  
    loadFeedback()async{
      await Server().getAction(appBloc:appBloc, url: Urls.cutMyNotifacions); 
      appBloc.cutNotifications = appBloc.mapSuccess; 
      print(appBloc.cutAllTask);
    }

  @override
  Widget build(BuildContext context){
      appBloc =Provider.of(context);
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
            appBloc.cutNotifications.isEmpty ? Center(child: Text('no notifications found'))
            : ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: appBloc.cutNotifications.length,
              itemBuilder: (cxt,i){
                return   notification.notifications(
              notifications: appBloc.cutNotifications['feedback'][i]['subject'],
              ontap: (){

              }
              );
              }
              )

           
             
            ],
          ),
          ),
      ),
    );
  }

}