import 'package:covid_app/utils/model_text.dart';
import 'package:flutter/material.dart';

class ReuseableContainer extends StatelessWidget {
  double height;
  double weight;
  String text1;
  String text2;
  double size;
  Color color;
  ReuseableContainer({super.key,
    required this.height,
    required this.weight,
    required this.text1,
    required this.text2,
    required this.size,
  required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
         height: height,
         width:  weight,
       decoration: BoxDecoration(
        color:  color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ModelText(text: text1, size: size),
              ModelText(text: text2, size: size),
            ],
          )),
    );
  }
}
