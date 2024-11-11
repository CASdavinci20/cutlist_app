

import 'package:cutlist/addcutlist/addcutlistpage.dart';
import 'package:cutlist/createcutlist/containers/cuttypecard.dart';
import 'package:cutlist/createcutlist/containers/createcutlistinput.dart';
import 'package:cutlist/createcutlist/containers/explanation.dart';
import 'package:cutlist/cutlistsummary/cutlistsummarypage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

class CreateCutListPage extends StatefulWidget {
  final  projectID;
  const CreateCutListPage({super.key, this.projectID});

  @override
  CreateCutListPageState createState() => CreateCutListPageState();
}

class CreateCutListPageState extends State<CreateCutListPage> {

  final CutTypeCard cutTypeCard =  CutTypeCard();
  final CreateCutListInput   cutListInput = CreateCutListInput();
  final Explanation  explanation = Explanation();
  late AppBloc appBloc;
  late bool hasLoaded= false;
  late String categoryName;
  late String categoryId;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<String> cutList = [];

  final TextEditingController  _height = TextEditingController();
  final TextEditingController  _width= TextEditingController();
  final TextEditingController  _depth = TextEditingController();



  
  loadAllCategories() async {
    await Server().getAction(appBloc: appBloc, url: Urls.cutCategories);
    appBloc.cutCategories = appBloc.mapSuccess;
    print(appBloc.cutCategories);
  }



  validateCutForm()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(await AppActions().checkInternetConnection()){
        cutPreview();
      }else{
         AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
  }

  cutPreview()async{
  Map cutListData ={
    "projectId": '${widget.projectID}',
    "categoryId": categoryId,
    "name": categoryName,
    "measurement": {
        "height":double.parse(_height.text),
        "width": double.parse(_width.text),
        "depth": double.parse(_depth.text)
    },
    "material": "Plywood"
};
print('all cutlisdata:${cutListData}');
if(await Server().postAction(url:Urls.cutPreview ,data: cutListData,bloc: appBloc)){
   print(appBloc.mapSuccess);
   PublicVar.allList = appBloc.mapSuccess;
   print("my all things ${PublicVar.allList}");
   NextPage().nextRoute(context, AddCutListPage(cutData: PublicVar.allList,));
    // NextPage().nextRoute(context, CutListSummaryPage(cutData: PublicVar.allList,));
}
  }

  
  


  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    if (!hasLoaded) {
      loadAllCategories();
      hasLoaded = true;
    }
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child:Form(
            key: _formKey,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration:const BoxDecoration(
                  color: Color(0xFFf0f1f9),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child:const Center(
                  child: Text(
                    'X',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           const   SizedBox(height: 70), 
           const   Center(
                child: Text(
                  'Create New Door',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE0f2851),
                  ),
                ),
              ),
              SizedBox( height: 10,),

              SizedBox(
                width: 350,
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                const  Text(
                    'Cut Type',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0f2851),
                  ),
                  ),
                  SizedBox(height: 10,),
     
     appBloc.cutCategories.isEmpty 
    ? const Center(
        child: CircularProgressIndicator(color: Colors.grey),
      ) 
    : SizedBox(
        height: 40, 
        child: ListView.builder(
          scrollDirection: Axis.horizontal, 
          itemCount: appBloc.cutCategories.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0), 
              child: cutTypeCard.cutTypeCard(
                title: '${appBloc.cutCategories[i]['name']}',
                onTap: () {
                  setState(() {
                     categoryName = '${appBloc.cutCategories[i]['name']}';
                   categoryId = '${appBloc.cutCategories[i]['_id']}';
                  });
                 
  
                },
              ),
            );
          },
        ),
      ),
                ],
              )
              ),

   const   SizedBox(height: 20,),
             SizedBox(
                width: 350,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              const    SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Measurement',
                   style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0f2851),
                  ),
                        ),

                          Text(
                          '(2 long)',
                   style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEf5af71),
                  ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
               const   Text(
                    'All measurement should be in c.m',
                    style: TextStyle(
                      fontSize: 10
                    ),
                  ),

                  const SizedBox(height: 5),
                    Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [   
            cutListInput.createCutListCard(
                title: 'Height', 
                cutData: _height
                ),
                const SizedBox(width: 10,),
                cutListInput.createCutListCard(
                title: 'Width', 
                cutData: _width
                ),  

                 const SizedBox(width: 10,),

                  cutListInput.createCutListCard(
                title: 'Dept',
                cutData: _depth ,
                  )
                ]
      ),
                   SizedBox(height: 200,),

                   Divider(height: 5,color: Color(0xFFE0b1b2b4)),

                   const SizedBox(height: 10,),
                   explanation.explaination(),
                   SizedBox(height: 30,),

                   Center(
                    child: GestureDetector(
                      onTap: (){
                        validateCutForm();
                      },
                      child: Image.asset(
                        'assets/previewbutton.png',
                        height: 50,

                      ),
                    ),
                   )
                  ],
                ),
              ),
        
            ],
          ),
        ],
      ),
      )
      )
      )
    );
  }
}

