import 'package:flutter/material.dart';

class MyList {
  Widget myListCard(
      {required String todoTitle,
      required String todoCat,
      required VoidCallback onTap, onLongPress}) {
    return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

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
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      todoTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                    Text(
                                      '$todoCat',
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])),
                    // Container(
                    //   height: 30,
                    //   width: 30,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(30),
                    //       border: Border.all(
                    //           color: Color(0xFFE0c1c3d0), width: 1.0)),
                    //   child: Center(
                    //     child: Icon(Icons.check),
                    //   ),
                    // )
                  ],
                ),
              ),
            )));
  }
}
