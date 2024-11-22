import 'package:flutter/material.dart';

class UserContainer {
  Widget userContainer({
    required String userName,
  }) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      color: Color(0xFFE0f2851),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Color(0xFFE0f2851),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ])
              ],
            ),
          ),
          // Container(
          //     height: 45,
          //     width: 45,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(7),
          //         color: Color(0xFFEf9f9f9)),
          //     child: Center(
          //         child: GestureDetector(
          //             onTap: () {},
          //             child: Image.asset(
          //               'assets/notification.png',
          //               height: 30,
          //             ))))
        ],
      ),
    );
  }
}
