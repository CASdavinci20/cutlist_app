
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
          appBloc.cutlistData = appBloc.mapSuccess.where((item) {
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
      backgroundColor:const Color(0xFFEf1f1fc),

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
                      height: 40,
                    ),
                  ),
               const  SizedBox(width: 20,),
                  Text(
                    '${widget.projectName} ',
                    style:const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0f2851),
                    ),
                  ),

                

                ],
              ),
            ),

        
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                            SizedBox(
                    height: 30,
                    width: 60,
                 child: ElevatedButton(
                  
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEf2c94c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),   
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4)
                  ),  
                    onPressed: (){
                    

                    }, 
                    child:const Center(
                  child:   Text(
                      'Export',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                      ),
                    )
                    )
                    )
                  )
            ],),
          

            const SizedBox(height: 20,),

            appBloc.cutlistData == null ? const Center(child:CircularProgressIndicator(color: Colors.grey,),)
            : appBloc.cutlistData.isEmpty ? const Center(child: Text('No list created'),)
            :ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: appBloc.cutlistData.length,
              itemBuilder:(cxt,i){
                 var tasks = appBloc.cutlistData[i]['cutlist'] as List<dynamic>;
                 var cutData= appBloc.cutlistData[i];
                 var cutList = cutData ['cutlist'];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
              child:   myList.myListCard(
                  todoTitle:cutData['name'],   
                  todoTotal: "${tasks.length}",
                  onTap:(){
                  NextPage().nextRoute(context, CutListSummaryPage(cutData: cutData));
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