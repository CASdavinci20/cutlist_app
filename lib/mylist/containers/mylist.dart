import 'package:flutter/material.dart';

class MyList {
  Widget myListCard(
      {required String todoTitle,
      required String todoTotal,
      required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //    boxShadow:[
              //   // BoxShadow(
              //   //   color: Colors.grey.withOpacity(0.5),
              //   //   spreadRadius: 5,
              //   //   blurRadius: 10,
              //   //   offset: Offset(0, 3),
              //   // ),
              // ],
              color: const Color(0xFFEf9f9f9),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/policy.png',
                                height: 30,
                              ),
                              SizedBox(
                                height: 55,
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      todoTitle,
                                      style: const TextStyle(
                                        color: Color(0xFFE0f2851),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '$todoTotal List',
                                      style: const TextStyle(
                                        color: Color(0xFFE0000000),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Color(0xFFE0c1c3d0), width: 1.0)),
                      child: Center(
                        child: Icon(Icons.chevron_right),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
