
import 'package:cutlist/createcutlist/createcutlistpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AddCutListPage extends StatefulWidget{
  const AddCutListPage({super.key});
   

   @override
   AddCutListPageState createState()=> AddCutListPageState();
}

class AddCutListPageState  extends State<AddCutListPage>{

  
  @override
  Widget build(BuildContextcontext){
    return Scaffold(
      backgroundColor: Color(0xFFffffff), 

      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
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
                 SizedBox(width: 20,),
                  Text(
                    'Dele Bungalow ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0f2851),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          context;
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCutListPage()),
            );
            
        },
        child: const Icon(Icons.add,size: 30,),
        backgroundColor: Color(0xFFE0f2c94c),
        shape: CircleBorder()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}