import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ProfileDetailsInput {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUseName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  Widget profileDetailsInputCard({
    required String title,
    required TextEditingController profileData
  }){
    return SizedBox(
      height: 100,
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:const TextStyle(
                      color:  Color(0xFFE0f2851),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ), 
          ),
           TextFormField(
                    controller: profileData,
                    decoration:const  InputDecoration(
                      fillColor:Color(0xFFEffffff), 
                      filled: true,
                      labelStyle:const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ), 
                     border: InputBorder.none,  
                    ),
                ),
        ],
      ),
    );

  }


  Widget  profilDetailsInput(){
    return Column(
      children: [
        profileDetailsInputCard(
          title: 'Name', 
          profileData: _controllerName
          ),

          const SizedBox(height: 10,),

           profileDetailsInputCard(
          title: 'Username', 
          profileData: _controllerUseName
          ),

           const SizedBox(height: 10,),

            profileDetailsInputCard(
          title: 'Email', 
          profileData: _controllerEmail
          ),

           const SizedBox(height: 10,),

            profileDetailsInputCard(
          title: 'Phone Number', 
          profileData: _controllerPhone
          ),
      ],
    );
  }
}