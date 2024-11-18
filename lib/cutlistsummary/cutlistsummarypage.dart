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



  
  

  @override
  Widget build(BuildContext context){
    appBloc =Provider.of<AppBloc>(context);
    print(widget.cutData);
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

                  ],
          
                ),
              ),

             const SizedBox(height: 20,),

            ListView.builder(
  physics: ScrollPhysics(),
  shrinkWrap: true,
  itemCount: widget.cutData["cutlist"].length,
  itemBuilder: (context, i) {
    final cutItem = widget.cutData["cutlist"][i];
    print("this is it ${cutItem}");
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
            ],
          ),
          ),
      ),
    );
      }
}