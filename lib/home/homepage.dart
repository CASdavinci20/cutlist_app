import 'package:cutlist/home/containers/addingtask.dart';
import 'package:cutlist/home/containers/bottomnav.dart';
import 'package:cutlist/home/containers/projects.dart';
import 'package:cutlist/home/containers/todolist.dart';
import 'package:cutlist/home/containers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class HomePage extends StatefulWidget {
  const HomePage ({super.key});

  @override
  HomePageState createState()=> HomePageState();
}

class HomePageState extends State<HomePage>{

  final UserContainer userContainer = UserContainer();
  final Projects  projects =Projects();
  final ToDoList   todoList = ToDoList();
  final BottomNav   bottomNav = BottomNav();
  final AddTask addTask = AddTask();

  TextEditingController _controllerProjectName = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFEf1f1fc),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
          child: Column(
            children: [
            userContainer.userContainer(
              userName: 'Kelechi Onaha'
              ),
            
           SizedBox(height: 40,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text(
                    'Recent Projects',
                    style:  TextStyle(
              color:  Color(0xFFE0f2851),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ), 
                  ),

                  SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            'assets/calendar.png',
                            height: 20,
                          )
                        ),
                       const SizedBox(width: 10,),

                       const Text(
                          'Weekly',
                          style:  TextStyle(
                        color:  Color(0xFFE0828282),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ), 
                        )
                      ],
                    ),
                  )
                ],
              ),
           const SizedBox(height: 10,),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             projects.projects(
              projectName: 'Housing project', 
              totalproject: 56,
              backgroundColor: Color(0xFFE0fbecc4),
              iconBackgroundColor: Color(0xFFE0f2d382) 
              ),
              const SizedBox(width: 20,),
              projects.projects(
              projectName: 'Housing project', 
              totalproject: 56,
              backgroundColor: Color(0xFFE0c9ebed),
              iconBackgroundColor: Color(0xFFE099d7db) 
              ),
              const SizedBox(width: 20,),
              projects.projects(
              projectName: 'Housing project', 
              totalproject: 56,
              backgroundColor: Color(0xFFE0f7ecef),
              iconBackgroundColor: Color(0xFFE0f4c3c5)  
              )
              ]
             ),
            
           ),
           const SizedBox(height: 30,),

           SizedBox(
            width: 300,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Text(
                  'To-do list',
              style:  TextStyle(
              color:  Color(0xFFE0f2851),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
                ),


            GestureDetector(
              onTap: (){
             addTask.addTask(
              projectName: _controllerProjectName, 
              context: context
              );

              },
             child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Image.asset(
                      'assets/add.png',
                      height: 15,
                      ),
                      SizedBox(width: 5,),

                    const  Text(
                        'Add project',
                         style:  TextStyle(
                          color:  Color(0xFFE0333333),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                ]
                  )
              )
              ],
            ),
           ),
           
           todoList.todoListCard(
            todoTitle: 'Omega 3', 
            todoTotal: 65, 
            onTap: (){

            }
            ),

            const SizedBox(height: 10,),

             
           todoList.todoListCard(
            todoTitle: 'Femi Oluye Zone', 
            todoTotal: 65, 
            onTap: (){
              
            }
            )
                    
            ]
        ),

      ) ,
      ),
      bottomNavigationBar:bottomNav.bottomNave(context) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context;
             addTask.addTask(
              projectName: _controllerProjectName, 
              context: context
              );
        },
        child: const Icon(Icons.add,size: 30,),
        backgroundColor: Color(0xFFE0f2c94c),
        shape: CircleBorder()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
    );
    
  }
}