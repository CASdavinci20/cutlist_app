import 'package:app_framework/utils/sharedStore.dart';
import 'package:cutlist/cutlist/cutlistpage.dart';
import 'package:cutlist/main_utils/utils/app_actions.dart';
import 'package:cutlist/main_utils/utils/next_page.dart';
import 'package:cutlist/cutlist/containers/mylist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/urls.dart';

class MyListPage extends StatefulWidget {
  final scaffoldKey;
  const MyListPage({super.key, this.scaffoldKey});

  @override
  MyListPageState createState() => MyListPageState();
}

class MyListPageState extends State<MyListPage> {
  final MyList myList = MyList();
  late AppBloc appBloc;
  late bool isloading = false;

  
  GlobalKey  projectsFloder = GlobalKey();
  

  List <TargetFocus> myTarget = [];

  TutorialCoachMark? tutorialCoachMark;


   void initState(){
      super.initState();
      allTargets();
      WidgetsBinding.instance.addPostFrameCallback(startTime);
    }

    startTime(_) async {
  bool hasShownTutorial = SharedStore().getData( type: 'bool',key: 'hasShownTutorial') ?? false;
  if (!hasShownTutorial) {
    await Future.delayed(Duration(seconds: 2));
    tutorialCoachMark = TutorialCoachMark(targets: myTarget)..show(context: context);
    await SharedStore().setData(type: true,key: 'hasShownTutorial');
  }
}


 allTargets(){
    myTarget.add(
      TargetFocus(
        keyTarget: projectsFloder,
        
        identify: 'myProject',
        contents: [
          TargetContent(
            builder: (context, controller){
               return  Column(
              children: [
                  Text(
              '${Icon(Icons.arrow_left)}Tap here to view projects',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
              ],
            );

            }
         
           
          )
        ]
      )
    );

      // myTarget.add(
      // TargetFocus(
      //   keyTarget: text,
        
      //   identify: 'user name',
      //   contents: [
      //     TargetContent(
      //       child: Text(
      //         'your user name here',
      //         style: TextStyle(
      //           color: Colors.grey,
      //         ),
      //       )
      //     )
      //   ]
      // )
    // );
  }



  loadMyProject() async {
    await Server().loadMyProject(appBloc: appBloc, context: context);

  }

  deleteProject({projectID}) async {
    if (await Server().deleteAction(
        appBloc: appBloc,
        url: Urls.cutProjectUrl + "/$projectID",
        data: {"projectId": projectID})) {
      print(appBloc.mapSuccess);
      await Server().loadMyProject(appBloc: appBloc, context: context);
      AppActions().showSuccessToast(context: context, text: "Project Deleted");

    } else {
      AppActions().showErrorToast(context: context, text: appBloc.errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    if (!isloading) {
      loadMyProject();
      isloading = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: SizedBox(),
        title: Container(
          key:projectsFloder ,
         child:    Text(
          'My Projects',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        )
     
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              appBloc.hasProjects==false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    )
                  : ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appBloc.cutProject.length,
                      itemBuilder: (cxt, i) {
                        var project = appBloc.cutProject[i];
                        var tasks = project['tasks'] as List<dynamic>;
                        return Padding(
                          //  key:projectsFloder,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: myList.myListCard(
                              todoTitle: project['name'],
                              todoCat: '${tasks.length}',
                              onTap: () {
                                NextPage().nextRoute(
                                    context,
                                    CutListPage(
                                      projectName: project['name'],
                                      projectID: project['_id'],
                                    ));
                              },
                              onLongPress: () {
                                AppActions().showAppDialog(
                                  context,
                                  title:
                                  "Do you want to delete ${project['name']} - Project",
                                  descp:
                                  "Please note!!! when you delete a project, all data with the project will be lost.",
                                  okText: "Confirm",
                                  cancleText: "Cancel",
                                  danger: true,
                                  okAction: () async {
                                    Navigator.pop(context);
                                    deleteProject(
                                        projectID: project['_id']);
                                  },
                                );
                              },
                            ));
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
