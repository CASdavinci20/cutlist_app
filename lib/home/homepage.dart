import 'package:cutlist/home/containers/addingtask.dart';
import 'package:cutlist/home/containers/projects.dart';
import 'package:cutlist/home/containers/todolist.dart';
import 'package:cutlist/home/containers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cutlist/cutlistpage.dart';
import '../cutlistsummary/cutlistsummarypage.dart';
import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

class HomePage extends StatefulWidget {
  final scaffoldKey;
  const HomePage({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final UserContainer userContainer = UserContainer();

  final Projects projects = Projects();
  final ToDoList todoList = ToDoList();

  final AddTask addTask = AddTask();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppBloc appBloc;
  late bool isloading = false;
  late bool loading = false;

  TextEditingController _controllerProjectName = TextEditingController();

  createProject() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    showLoading();
      if (await AppActions().checkInternetConnection()) {
        sendToSever();
      } else {
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
      print(appBloc.mapSuccess);

      var projectID = appBloc.mapSuccess["project"]["_id"];

      await loadMyProject();
      await Server().loadAllTask( appBloc: appBloc, context: context, projectID: projectID);
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
      // AppActions().showSuccessToast(context: context, text: "Project Saved");
      // await Server().loadAllTask(appBloc: appBloc, context: context, projectID: projectID);
      //   Navigator.pop(context);
      // AppActions().showAppDialog(
      //   context,
      //   title: "Project Saved",
      //   descp: "You can now create your cutlist.",
      //   okText: "Confirm",
      //   cancleText: "Cancel",
      //   danger: false,
      //   singlAction: true,
      //   okAction: () async {
      //      Navigator.pop(context);
      //     NextPage().nextRoute(
      //         context,
      //         CutListPage(
      //           projectName: _controllerProjectName.text,
      //           projectID: projectID,
      //         ));
      //   },
      // );

     

    }
  }

  loadMyProject() async {
    await Server().loadMyProject(appBloc: appBloc, context: context);
  }

  loadAllTask() async {
    await Server().loadAllTask(appBloc: appBloc, context: context);
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

  
  showLoading() {
    if (loading) {
      loading = false;
    } else {
      loading = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    if (!isloading) {
      loadMyProject();
      loadAllTask();
      isloading = true;
    }
    return Scaffold(
        backgroundColor: const Color(0xFFEf1f1fc),
        body: SingleChildScrollView(

        child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(children: [
                userContainer.userContainer(userName: '${PublicVar.userName}'),
                SizedBox(
                  height: 20,
                ),
                // BgPattern(child: Container(

                // )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Projects',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
                 
                  ),
                 child:   SizedBox(
                    width: 350,
                    child: appBloc.hasProjects == false
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          )
                        : appBloc.cutProject.isEmpty
                            ? const Center(
                                child: Text(
                                    'No project, please create one'),
                              )
                            : ListView.builder(
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: appBloc.cutProject.length,
                                itemBuilder: (cxt, i) {
                                  var project = appBloc.cutProject[i];
                                  var tasks = project['tasks'] as List<dynamic>;
                                  return projects.projects(
                                      projectName: project['name'],
                                      totalproject: tasks.length,
                                      backgroundColor: Color(0xFFE0fbecc4),
                                      iconBackgroundColor: Color(0xFFE0f2d382),
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
                                      });
                                },
                              ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent list',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          addTask.addTask(
                              projectName: _controllerProjectName,
                              context: context,
                              onTap: (showLoading) async{
                                // AppActions().showLoadingToast(context: context, text: "Creating Project ...");
                                // Navigator.pop(context);
                                // showLoading();
                               await createProject();
                              });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/add.png',
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Add project',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ]))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 320,
                    child: appBloc.hasTasks == false
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.grey,
                          ))
                        : appBloc.cutAllTask.isEmpty
                            ? const Center(
                                child: Text('No list'),
                              )
                            : SingleChildScrollView(
                                child: Column(children: [
                                todoList.todoListCard(
                                  todoTitle: appBloc.cutAllTask[0]['name'],
                                  todoTotal:
                                      appBloc.cutAllTask[0]['cutlist'].length,
                                  onTap: () {
                                    NextPage().nextRoute(
                                      context,
                                      CutListSummaryPage(
                                          cutData: appBloc.cutAllTask[0]),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                appBloc.cutAllTask.length > 1
                                    ? todoList.todoListCard(
                                        todoTitle: appBloc.cutAllTask[1]
                                            ['name'],
                                        todoTotal: appBloc
                                            .cutAllTask[1]['cutlist'].length,
                                        onTap: () {
                                          NextPage().nextRoute(
                                            context,
                                            CutListSummaryPage(
                                                cutData: appBloc.cutAllTask[1]),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                appBloc.cutAllTask.length > 2
                                    ? todoList.todoListCard(
                                        todoTitle: appBloc.cutAllTask[2]
                                            ['name'],
                                        todoTotal: appBloc
                                            .cutAllTask[2]['cutlist'].length,
                                        onTap: () {
                                          NextPage().nextRoute(
                                            context,
                                            CutListSummaryPage(
                                                cutData: appBloc.cutAllTask[2]),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                appBloc.cutAllTask.length > 3
                                    ? todoList.todoListCard(
                                        todoTitle: appBloc.cutAllTask[3]
                                            ['name'],
                                        todoTotal: appBloc
                                            .cutAllTask[3]['cutlist'].length,
                                        onTap: () {
                                          NextPage().nextRoute(
                                            context,
                                            CutListSummaryPage(
                                                cutData: appBloc.cutAllTask[3]),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                appBloc.cutAllTask.length > 4
                                    ? todoList.todoListCard(
                                        todoTitle: appBloc.cutAllTask[4]
                                            ['name'],
                                        todoTotal: appBloc
                                            .cutAllTask[4]['cutlist'].length,
                                        onTap: () {
                                          NextPage().nextRoute(
                                            context,
                                            CutListSummaryPage(
                                                cutData: appBloc.cutAllTask[4]),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                              ])))
              ]),
            ),
          ),
        
        )
        );
  }



}


// class BgPattern extends StatelessWidget {
//   const BgPattern({super.key, this.child});
//   final child;
//   @override
//   Widget build(BuildContext context) {
//     return  
//     Container(
//         width: 40.0,
//         height: 40.0,
//         decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage("assets/back-4.png"),fit: BoxFit.cover)
//         ),
//         child:child
//         );
//   }
// }
