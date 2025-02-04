import 'package:cutlist/cutlist/containers/createcutlistinput.dart';
import 'package:cutlist/cutlist/containers/cuttypecard.dart';
import 'package:cutlist/cutlist/containers/explanation.dart';
import 'package:cutlist/cutlist/cutlistpage.dart';

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
  final projectID, catName, catID;
  const CreateCutListPage({super.key, this.projectID, this.catName, this.catID});

  @override
  CreateCutListPageState createState() => CreateCutListPageState();
}

class CreateCutListPageState extends State<CreateCutListPage> {

  final CreateCutListInput cutListInput = CreateCutListInput();
  final Explanation explanation = Explanation();
  late AppBloc appBloc;
  late bool hasLoaded = false;


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<String> cutList = [];
  late bool loading=false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _width = TextEditingController();
  final TextEditingController _depth = TextEditingController();



  validateCutForm() async {
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

  cutPreview() async {
    Map cutListData = {
      "projectId": '${widget.projectID}',
      "categoryId": widget.catID,
      "name": _name.text,
      "measurement": {
        "height": double.parse(_height.text),
        "width": double.parse(_width.text),
        "depth": double.parse(_depth.text)
      },
      "material": "Plywood"
    };

    if (await Server().postAction(
        url: Urls.createCutlist, data: cutListData, bloc: appBloc)) {
      if(appBloc.mapSuccess["error"]!=null){
        showLoading();
        AppActions().showErrorToast(context: context, text: appBloc.mapSuccess["error"]);
      }else{
        print('Map success ${appBloc.mapSuccess}');
        AppActions().showSuccessToast(context: context, text: "Item Saved");
        await Server().loadMyProject(appBloc: appBloc, context: context);
        await Server().loadAllTask(appBloc: appBloc, context: context, projectID: widget.projectID);
        print(appBloc.cutlistData);
        Navigator.pop(context);
      }

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 30,
              )),
          title: Text(
            'Create new ${widget.catName}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
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
            text: "Save ${widget.catName}",
            addIconBG: false,
          ),
        ),

        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Row(children: [
                               cutListInput.createCutListCard(
                                 title: 'Door Name',
                                 cutData: _name,
                                 keyboardType: "text"
                               ),
                             ],),
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
                              Container(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      cutListInput.createCutListCard(
                                          title: 'Height(cm)', cutData: _height),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      cutListInput.createCutListCard(
                                          title: 'Width(cm)', cutData: _width),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      cutListInput.createCutListCard(
                                        title: 'Wall (cm)',
                                        cutData: _depth,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Divider(height: 5, color: Color(0xFFE0b1b2b4)),
                              const SizedBox(
                                height: 10,
                              ),
                              explanation.explaination(),
                              SizedBox(
                                height: 300,
                              ),


                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
