// import 'package:cutlist/addcutlist/addcutlistpage.dart';
// import 'package:cutlist/createcutlist/containers/createcutlistinput.dart';
// import 'package:cutlist/createcutlist/containers/cuttypecard.dart';
// import 'package:cutlist/createcutlist/containers/explanation.dart';
import 'package:cutlist/cutlist/containers/createcutlistinput.dart';
import 'package:cutlist/cutlist/containers/cuttypecard.dart';
import 'package:cutlist/cutlist/containers/explanation.dart' show Explanation;
import 'package:cutlist/main_utils/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

class CreateCutListPage extends StatefulWidget {
  final projectID;
  const CreateCutListPage({super.key, this.projectID});

  @override
  CreateCutListPageState createState() => CreateCutListPageState();
}

class CreateCutListPageState extends State<CreateCutListPage> {
  final CutTypeCard cutTypeCard = CutTypeCard();
  final CreateCutListInput cutListInput = CreateCutListInput();
  final Explanation explanation = Explanation();
  late AppBloc appBloc;
  late bool hasLoaded = false;
  late String categoryName="";
  late String categoryId;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<String> cutList = [];
  late bool loading=false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _width = TextEditingController();
  final TextEditingController _depth = TextEditingController();

  loadAllCategories() async {
    await Server().getAction(appBloc: appBloc, url: Urls.cutCategories);
    appBloc.cutCategories = appBloc.mapSuccess;
    print(appBloc.cutCategories);
  }

  validateCutForm() async {
    if(categoryId==null){
      AppActions().showErrorToast(
        text: "Select the list category at the top",
        context: context,
      );
    }else{
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoading();
      if (await AppActions().checkInternetConnection()) {
        cutPreview();
      } else {
        AppActions().showErrorToast(
          text: PublicVar.checkInternet,
          context: context,
        );
      }
    }
    }
  }

  cutPreview() async {
    Map cutListData = {
      "projectId": '${widget.projectID}',
      "categoryId": categoryId,
      "name": _name.text,
      "measurement": {
        "height": double.parse(_height.text),
        "width": double.parse(_width.text),
        "depth": double.parse(_depth.text)
      },
      "material": "Plywood"
    };

    print('all cutlisdata:${cutListData}');
    if (await Server().postAction(
        url: Urls.createCutlist, data: cutListData, bloc: appBloc)) {
      print(' map success${appBloc.mapSuccess}');
      AppActions().showSuccessToast(context: context, text: "Door Saved");

        await Server().getAction(appBloc: appBloc, url: Urls.allCutList);
        appBloc.cutlistData = appBloc.mapSuccess.where((item) {
          return item['project'] == widget.projectID;
        }).toList();
        print(appBloc.cutlistData);

      Navigator.pop(context);
    }else{
      showLoading();
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
    if (!hasLoaded) {
      loadAllCategories();
      hasLoaded = true;
    }
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 30,
              )),
          title: Text(
            'Create New Door',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: 350,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cut Type',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFE0f2851),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  appBloc.cutCategories.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.grey),
                                        )
                                      : SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                appBloc.cutCategories.length,
                                            itemBuilder: (ctx, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: cutTypeCard.cutTypeCard(
                                                  selected:categoryName ,
                                                  title:
                                                      '${appBloc.cutCategories[i]['name']}',
                                                  onTap: () {
                                                    setState(() {
                                                      categoryName =
                                                          '${appBloc.cutCategories[i]['name']}';
                                                      categoryId =
                                                          '${appBloc.cutCategories[i]['_id']}';
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            //  Row(children: [
                               cutListInput.createCutListCard(
                                tag: 'Door name',
                                explaination: '',
                                 title: 'Door Name',
                                 cutData: _name,
                                 keyboardType: "text"
                               ),
                            //  ],),
                              SizedBox(height: 20,),
                              const SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              const Text(
                                'All measurement should be in c.m',
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    cutListInput.createCutListCard(
                                      tag: 'Height of Door',
                                      explaination: 'Measure the height of the doorway on the Left and Right. Input the higher figure.',
                                        title: 'Height(cm)', cutData: _height),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    cutListInput.createCutListCard(
                                      tag: 'Width of door',
                                      explaination: 'Measure the width of the doorway at the Top, Middle and Bottom. Input the highest figure.',
                                        title: 'Width(cm)', cutData: _width),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    cutListInput.createCutListCard(
                                      tag: 'Wall thickness',
                                      explaination: 'Measure the wall thickness of the doorway at the Top, Middle and Bottom on both sides of the doorway (Left and Right) and input the highest figure',
                                      title: 'Wall Thickness(cm)',
                                      cutData: _depth,
                                    )
                                  ]),
                              SizedBox(
                                height: 50,
                              ),
                              Divider(height: 5, color: Color(0xFFE0b1b2b4)),
                              const SizedBox(
                                height: 10,
                              ),
                              explanation.explaination(),
                              SizedBox(
                                height: 30,
                              ),


                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: ButtonWidget(
                              onPress: () {
                                if (!loading) {
                                  validateCutForm();
                                }
                              },
                              width: double.infinity,
                              height: 50.0,
                              txColor: Colors.black,
                              bgColor: Color(PublicVar.primaryColor),
                              loading: loading,
                              text: "Create",
                              addIconBG: false,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
