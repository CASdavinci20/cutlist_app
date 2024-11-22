import 'package:cutlist/addcutlist/addcutlistpage.dart';
import 'package:cutlist/main_utils/utils/next_page.dart';
import 'package:cutlist/mylist/containers/mylist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  loadMyProject() async {
    await Server().getAction(appBloc: appBloc, url: Urls.cutProjects);
    appBloc.cutProject = appBloc.mapSuccess;
    print(appBloc.cutProject);
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
        title: Text(
          'My List',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              appBloc.cutProject.isEmpty
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
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: myList.myListCard(
                              todoTitle: project['name'],
                              todoTotal: '${tasks.length}',
                              onTap: () {
                                NextPage().nextRoute(
                                    context,
                                    AddCutListPage(
                                      projectName: project['name'],
                                      projectID: project['_id'],
                                    ));
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
