import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  FeedBackPageState createState() => FeedBackPageState();
}

class FeedBackPageState extends State<FeedBackPage> {
  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerinfo = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEffffff),
      body: SingleChildScrollView(
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
                      controller: _controlleremail,
                      decoration: InputDecoration(
                        labelText: 'Your email*',
                        fillColor: Color(0xFFE0fafaff),
                        filled: true,
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFE0cacacf),
                            fontWeight: FontWeight.w700),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE0b1b2b4), width: 2.0),
                            borderRadius: BorderRadius.circular(15)),
                        hintStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      '*This is a required field',
                      style: TextStyle(
                        color: Color(0xFFE0cacacf),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
               const SizedBox(height: 20,),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _controllerinfo,
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
    );
  }
}
