import 'package:cutlist/purchasecredit/containers/credittypes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_utils/bloc/app_bloc.dart';
import '../main_utils/bloc/server.dart';
import '../main_utils/models/urls.dart';



class PurchaseCreditPage extends StatefulWidget {
  const PurchaseCreditPage({super.key});

  @override
  PurchaseCreditPageState createState() => PurchaseCreditPageState();
}

class PurchaseCreditPageState extends State<PurchaseCreditPage> {

  final CreditTypeContainer  creditType = CreditTypeContainer();
  late AppBloc appBloc;
  late bool isLoading = false;

  
    loadCreditPackage()async{
      await Server().getAction(appBloc:appBloc, url: Urls.cutCreditPackages); 
      appBloc.cutCreditPackage = appBloc.mapSuccess; 
      print(appBloc.cutAllTask);
    }


  @override
  Widget build(BuildContext context) {
    appBloc = Provider.of<AppBloc>(context);
    if(!isLoading){
      loadCreditPackage();
      isLoading = true;
    }
    return Scaffold(
      backgroundColor:Color(0xFFEfafaff) ,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                     Navigator.of(context).pop();
                },
            child:   Image.asset(
                'assets/arrow_left.png',
                height: 30,
              ),
              ),
       const SizedBox(height: 10,),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:  Color(0xFFE838383),
                      ),
                      child: Center(
                  child:   Image.asset(
                      'assets/cart.png',
                      height: 30,
                    )
                    )
                    ),
               const SizedBox(height: 10,),
                   const Text(
                      'Purchase Credits ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE0f2851),
                      ),
                    ),
                    const SizedBox(height: 5,),
                  const   Text(
                      'Select the number of credits you want to purchase',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFE0f2851),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),

              Padding(
                padding: EdgeInsets.symmetric(vertical:10),
              child:   ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appBloc.cutCreditPackage.length,
                  itemBuilder: (cxt,i){
                    return  creditType.creditType(
                      creditAmount: appBloc.cutCreditPackage['data'][i]['amount'], 
                      price: appBloc.cutCreditPackage['data'][i]['price'],
                      ontap: (){
                        
                      }

                    );
                  }
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}