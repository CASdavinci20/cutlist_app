import 'package:flutter/material.dart';


class Explanation {
  Widget explainationCard({
    required String word,
    required String meaning,
  }){
    return SizedBox(
      child: Row(
        children: [
          RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: word,
                style:const TextStyle(
                  fontSize: 16, 
                  color: Color(0xFFEf5af71),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: meaning,
                style:const TextStyle(
                  fontSize: 12, 
                  color: Color(0xFFE0f2851),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }


  Widget explaination(){
    return Column(
      children: [
        explainationCard(
          word: 'Height ', 
          meaning: '- Means(height of the door way).'
          ),
          const SizedBox(height: 10,),
       
        explainationCard(
          word: 'Width ', 
          meaning: '- Means(Width of the door way),'
          ),
          const SizedBox(height: 10,),

           explainationCard(
          word: 'Depth ', 
          meaning: '- Means(Wall thickness).'
          ),
          const SizedBox(height: 10,),
      ],
    );
  }
}