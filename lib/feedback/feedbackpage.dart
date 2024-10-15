import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/PublicVar.dart';
import '../main_utils/models/urls.dart';
import '../main_utils/utils/app_actions.dart';
import '../main_utils/utils/next_page.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  FeedBackPageState createState() => FeedBackPageState();
}

class FeedBackPageState extends State<FeedBackPage> {
  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppBloc appBloc;



  bool isChecked = false;

  
  validateFeedback()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(await AppActions().checkInternetConnection()){
        saveFeedback();
      }else{
         AppActions().showErrorToast(
        text: PublicVar.checkInternet,
        context: context,
      );
     }
    }
  }

  saveFeedback()async{
    var feedbackId = PublicVar.userAppID;
  Map feedBackData ={
      "feedbackId": feedbackId,
      "message": _controllerMessage.text,
      "files": [
        "string"
  ]

};
print('all cutlisdata:${feedBackData}');
if(await Server().postAction(url:Urls.cutFeedback ,data: feedBackData,bloc: appBloc)){
  //  print("my all things ${PublicVar.allList}");
  //  NextPage().nextRoute(context, CutListSummaryPage(cutData: PublicVar.allList,));
}
  }
  


  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFFEffffff),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/arrow_left.png',
                        height: 30,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Provide Feedback',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0f2851),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50,),

              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _controllerMessage,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Describe your issue or suggestion',
                        fillColor: Color(0xFFE0fafaff),
                        filled: true,
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFE0cacacf),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE0b1b2b4), width: 2.0),
                            borderRadius: BorderRadius.circular(15)),
                        hintStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Please enter at least 10 characters',
                      style: TextStyle(
                        color: Color(0xFFE0cacacf),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/feedbutton.png',
                        height: 50,
                      )),
                    const  SizedBox(width: 10,),
                  const Text(
                    'Upload a screenshot (optional)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0cacacf),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
               const SizedBox(
                width: 270,
                    child: Text(
                        'By continuing you accept our Privacy Policy and Term of Use'),
                  )
                ],
              ),
             const SizedBox(height: 30,),

             InkWell(
              onTap: (){
                validateFeedback();
              },
            child:   Image.asset(
                'assets/submitbutton.png',
                height: 60,
              )
             )
            ],
          ),
      ),
      ),
      )
    );
  }
}
