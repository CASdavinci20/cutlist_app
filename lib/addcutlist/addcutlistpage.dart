
import 'package:cutlist/createcutlist/createcutlistpage.dart';
import 'package:cutlist/main_utils/models/PublicVar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../cutlistsummary/cutlistsummarypage.dart';
import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/next_page.dart';
import '../mylist/containers/mylist.dart';


class AddCutListPage extends StatefulWidget{
  final projectName;
  final projectID;
  final projectIndex;
  final cutData;
  const AddCutListPage({super.key, this.projectName, this.projectID, this.projectIndex, this.cutData});
   

   @override
   AddCutListPageState createState()=> AddCutListPageState();
}
class AddCutListPageState  extends State<AddCutListPage>{
  final MyList myList = MyList();
  late AppBloc appBloc;
  late bool isloading = false;


  loadAllTask()async{
     await Server().getAction(appBloc:appBloc, url: Urls.allCutList); 
          appBloc.cutAllTask = appBloc.mapSuccess.where((item) {
      return item['project'] == widget.projectID;
    }).toList();
      print(appBloc.cutAllTask);
    
  }


  
  @override
  Widget build(BuildContextcontext){
    appBloc = Provider.of<AppBloc>(context);
    if(!isloading){
      loadAllTask();
      isloading = true;
    }
    return Scaffold(
      backgroundColor:const Color(0xFFffffff), 

      body: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  GestureDetector( 
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/arrow_left.png',
                      height: 50,
                    ),
                  ),
               const  SizedBox(width: 20,),
                  Text(
                    '${widget.projectName} ',
                    style:const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0f2851),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20,),

            appBloc.cutAllTask.isEmpty ? const Center(child:CircularProgressIndicator(color: Colors.grey,),)
            :ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: appBloc.cutAllTask.length,
              itemBuilder:(cxt,i){
                 var tasks = appBloc.cutAllTask[i]['cutlist'] as List<dynamic>;
                 var cutData= appBloc.cutAllTask[i];
                 var cutList = cutData ['cutlist'];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
              child:   myList.myListCard(
                  todoTitle:cutData['name'],   
                  todoTotal: "${tasks.length}",
                  onTap:(){
                  NextPage().nextRoute(context, CutListSummaryPage(cutData: PublicVar.allList));
                  }
              )
                  );
              } 
              )
          ],
        ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          context;
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CreateCutListPage(projectID: widget.projectID,)),
            );
            
        },
        child:  Icon(Icons.add,size: 30,),
        backgroundColor: Color(0xFFE0f2c94c),
        shape:const CircleBorder()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

}