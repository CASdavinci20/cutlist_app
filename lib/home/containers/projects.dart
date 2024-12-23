import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Projects {
  Widget projects(
      {required String projectName,
      required int totalproject,
      required Color backgroundColor,
      required Color iconBackgroundColor,
      required VoidCallback onTap, onLongPress}) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
                height: 150,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: backgroundColor,
                ),
                child: GestureDetector(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: iconBackgroundColor,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/policy.png',
                                    height: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/arrow_right.png',
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 100,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${projectName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "$totalproject List",
                                  style: TextStyle(
                                    color: Color(0xFFE0f2851),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]))
                    ],
                  ),
                ))));
  }
}
