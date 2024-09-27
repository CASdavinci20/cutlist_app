import 'package:cutlist/addcutlist/addcutlistpage.dart';
import 'package:cutlist/mylist/containers/mylist.dart';
import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget{
  final scaffoldKey;
  const MyListPage ({super.key, this.scaffoldKey});
  
  @override
  MyListPageState createState()=> MyListPageState();
}

class MyListPageState  extends State<MyListPage>{
  final MyList myList =MyList();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My List',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:Color(0xFFE0f2851), 
              ),
              ),
              SizedBox(height: 20,),
              myList.myListCard(
                todoTitle: 'Dele Bungalow', 
                todoTotal: 0, 
                onTap: (){

                }
                ),

                 SizedBox(height: 20,),
              myList.myListCard(
                todoTitle: 'Dele Bungalow', 
                todoTotal: 0, 
                onTap: (){
                    context;
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddCutListPage()),
                            );
                                  
                }
                ),

            ],
          ),
          ),
      ),
    );
  }

}