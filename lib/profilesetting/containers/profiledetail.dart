import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ProfileDetailsInput {


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


  Widget profileTile({
    required String title,
    required String value
  }){

    return SizedBox(
      height: 100,
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                      color:  Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ), 
          ),
          Text(
            value,
            style:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE0f2851),
            ),
          )
        ],
      ),
    );

  }
}