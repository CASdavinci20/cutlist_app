import 'package:cutlist/cutlistsummary/containers/mesurmentcontainer.dart';
import 'package:cutlist/mylist/mylistpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


import '../createcutlist/createcutlistpage.dart';
import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

 class CutListSummaryPage extends StatefulWidget{
  final  cutData;
  const CutListSummaryPage({super.key,this.cutData});

  @override
  CutListSummaryPageState  createState()=> CutListSummaryPageState();

}

class CutListSummaryPageState extends State<CutListSummaryPage>{
  final MesurementContainer  mesurement = MesurementContainer();
  late AppBloc appBloc;

   validateTaskList()async{
    FocusScope.of(context).unfocus();
    if(widget.cutData != null){
      if(await AppActions().checkInternetConnection()){
        saveTask();
      }else{
         AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
  }

  saveTask()async{
  Map cutListData ={
    "projectId": widget.cutData['task']['projectId'],
    "categoryId": widget.cutData['task']['categoryId'],
    "name": widget.cutData['task']['name'],
    "measurement": {
        "height":widget.cutData['task']['measurement']['height'],
        "width":widget.cutData['task']['measurement']['width'],
        "depth": widget.cutData['task']['measurement']['depth'],
    },
    "material": "Plywood"
};
print('all cutlisdata:${cutListData}');
if(await Server().postAction(url:Urls.createCutlist ,data: cutListData,bloc: appBloc)){
   print(appBloc.mapSuccess);
   NextPage().nextRoute(context, MyListPage());
}
  }
 


  
  

  @override
  Widget build(BuildContext context){
    appBloc =Provider.of<AppBloc>(context);
    return Scaffold(
          backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            children: [
              SizedBox(
                width: 320,
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                               Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/arrow_left.png',
                              height: 30,
                            ),
                          ),
                       const   SizedBox(width: 10,),

                         const Text(
                            'Cut List Summary',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE0f2851),
                            ),
                          )
                        ],
                      ),
                    ),
 

                  SizedBox(
                    height: 35,
                    width: 35,
                 child: ElevatedButton(
                  
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEf2c94c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),   
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4)
                  ),  
                    onPressed: (){
                      NextPage().nextRoute(context, CreateCutListPage());

                    }, 
                    child:const Center(
                  child:   Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                      ),
                    )
                    )
                    )
                  )
                  ],
                ),
              ),

             const SizedBox(height: 20,),

            ListView.builder(
  physics: ScrollPhysics(),
  shrinkWrap: true,
  itemCount:widget.cutData['task']['cutlist'].length,
  itemBuilder: (context, i) {
    final cutItem = widget.cutData['task']['cutlist'][i];
    print("this is it ${widget.cutData}");
    if (cutItem != null) {
      return mesurement.mesurementContainer(
        cutType: cutItem["part"].toString(), 
        long: cutItem["length"].toString(), 
        width: cutItem["width"].toString(), 
        quantity: cutItem["quantity"].toString(),
      );
    }
  },
),

            const  SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                validateTaskList();
              },

           child:  Image.asset(
              'assets/savebutton.png',
              height: 70,
              width: 300,
            )
            )

            ],
          ),
          ),
      ),
    );
      }
}