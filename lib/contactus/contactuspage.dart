import 'package:cutlist/contactus/containers/contactmenu.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  ContactUsPageState createState() => ContactUsPageState();
}

class ContactUsPageState extends State<ContactUsPage> {
  final ContactUs contactUs = ContactUs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFFEfafaff),
       body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child:  Row(
              children: [
                InkWell(
                  onTap: (){
                     Navigator.of(context).pop();

                  },
              child:   Image.asset(
                  'assets/arrow_left.png',
                  height: 30,
                )
                ),
                const SizedBox(width: 10,),
                const  Text(
                  'Contact Us',
                  style:TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE0f2851),
                      ), 
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),

          contactUs.contactUs()
        ],
       ),

    );
  }
}