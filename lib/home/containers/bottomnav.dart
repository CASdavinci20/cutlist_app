import 'package:cutlist/home/containers/addingtask.dart';
import 'package:flutter/material.dart';
// import 'package:cutlist/home/containers/addingtask.dart';

import '../../mylist/mylistpage.dart';
import '../../notifications/notificationpage.dart';
import '../../profile/profilepage.dart';
import '../homepage.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  final pageIndex;
  const BottomNav({super.key, this.pageIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final AddTask addTask = AddTask();
  TextEditingController _controllerProjectName = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
 GlobalKey _fabKey = GlobalObjectKey("fab");
  final PageStorageBucket bucket =PageStorageBucket();
  late Widget currentPage;
  List bottomItems =[
    {'icons': Icons.home,'text': "Home"},
    {'icons': Icons.folder,'text': "List"},
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
    return  Scaffold(
      key: _scaffoldKey,
      body: PageStorage(
        bucket: bucket, 
      child: currentPage
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
          Navigator.of(context).pop();
          context;
             addTask.addTask(
              projectName: _controllerProjectName, 
              context: context
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






