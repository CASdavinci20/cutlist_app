 import 'package:cutlist/cutlist/cutlistpage.dart';
import 'package:cutlist/cutlist/mylistpage.dart';
import 'package:cutlist/home/containers/addingtask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main_utils/bloc/app_bloc.dart';
import '../../main_utils/bloc/server.dart';
import '../../main_utils/models/PublicVar.dart';
import '../../main_utils/models/urls.dart';
import '../../main_utils/utils/app_actions.dart';
import '../../main_utils/utils/next_page.dart';
 import '../../notifications/notificationpage.dart';
import '../../profile/profilepage.dart';
import '../homepage.dart';

class BottomNav extends StatefulWidget {
  final pageIndex;
  const BottomNav({super.key, this.pageIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final AddTask addTask = AddTask();
  TextEditingController _controllerProjectName = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppBloc appBloc;

   createProject()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

     if (await AppActions().checkInternetConnection()) {
      sendToSever();
     }else{
      AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
   }


  sendToSever() async {
    Map projectName = {
      "name": '${_controllerProjectName.text}',
      "userId": "${PublicVar.userAppID}"
    };

    if (await Server().postAction(
        url: Urls.cutCreateProject, data: projectName, bloc: appBloc)) {
      var projectID = appBloc.mapSuccess["project"]["_id"];
      await Server().loadMyProject(appBloc: appBloc, context: context);
      await Server().loadAllTask(appBloc: appBloc, context: context, projectID: projectID);
      Navigator.pop(context);
      AppActions().showAppDialog(context,
          title: "Project Saved",
          descp: "Click the Add button below to start creating your List.",
          singlAction: true,
          okText: "Okay", okAction: () {
            Navigator.pop(context);
            NextPage().nextRoute(
                context,
                CutListPage(
                  projectName: _controllerProjectName.text,
                  projectID: projectID,
                ));
            _controllerProjectName.text="";
            setState(() {});
          });
    } else {
      Navigator.pop(context);
      AppActions().showAppDialog(context,
          title: "An Error occurred",
          descp: appBloc.errorMsg + "....Please try again.",
          singlAction: true,
          okText: "Okay", okAction: () {
            Navigator.pop(context);
          });
    }
  }






  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
 GlobalKey _fabKey = GlobalObjectKey("fab");
  final PageStorageBucket bucket =PageStorageBucket();
  late Widget currentPage;
  List bottomItems =[
    {'icons': Icons.home,'text': "Home"},
    {'icons': Icons.folder,'text': "Project"},
    {'icons': Icons.notifications,'text': "Notification"},
    {'icons': Icons.person,'text': "Profile"},
  ];

  int currentIndex = 0;
  final Key key1 = PageStorageKey('page1');
  final Key key2 = PageStorageKey('page2');
  final Key key3 = PageStorageKey('page3');
  final Key key4 = PageStorageKey('page4');
  final navigationIconSize =25.0;
  late HomePage  page1;
  late MyListPage page2;
  late NotificationPage page3;
  late ProfilePage page4;
  List<Widget> pages =[];

  @override
  void initState(){
    page1 =HomePage(
      scaffoldKey: _scaffoldKey,
      key: key1
    );

     page2 =MyListPage(
      scaffoldKey: _scaffoldKey,
      key: key2
    );

     page3 =NotificationPage(
      scaffoldKey: _scaffoldKey,
      key: key3
    );

     page4 =ProfilePage(
      scaffoldKey: _scaffoldKey,
      key: key4
    );

    pages = [page1, page2, page3, page4];
    if (widget.pageIndex != null) {
      currentIndex = widget.pageIndex;
      switch (widget.pageIndex) {
        case 0:
          currentPage = page1;
          break;
        case 1:
          currentPage = page2;
          break;
        case 2:
          currentPage = page3;
          break;
        case 3:
          currentPage = page4;
          break;
      }
    } else {
      currentPage = page1;
    }
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
     appBloc = Provider.of<AppBloc>(context);
    return  Scaffold(
      key: _scaffoldKey,
      body: PageStorage(
        bucket: bucket, 
        child:Form(
          key: _formKey,
      child: currentPage
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: _fabKey,
        backgroundColor:Colors.white, 
        showSelectedLabels:true ,
        selectedItemColor: Color(0xFFE0f2c94c),
        unselectedItemColor:Color(0xFFEb0b2c3) ,
        showUnselectedLabels:true,
        elevation: 2.5,
        unselectedFontSize: 10,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        iconSize: navigationIconSize,
        currentIndex: currentIndex,
        onTap: (int index){
          setState(() {
            currentIndex =index;
            currentPage = pages[index];
          });
        },
        items:List.generate(bottomItems.length, (i){
          return BottomNavigationBarItem(
            icon: Icon(bottomItems[i]['icons']),
            label: bottomItems[i]["text"]
            );
        }
        )
        ),
          floatingActionButton: FloatingActionButton(
        onPressed: () {
        
        
          context;
             addTask.addTask(
              projectName: _controllerProjectName, 
              context: context,
              onTap: (){
               createProject();
              }
              );
        },
        child: const Icon(Icons.add,size: 30,),
        backgroundColor: Color(0xFFE0f2c94c),
        shape: CircleBorder()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}






