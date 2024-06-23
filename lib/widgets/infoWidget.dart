import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
class InfoLine extends StatelessWidget {
   String title;
   TextEditingController controller;
   var onTap;
   bool readOnly;
  InfoLine(
      this.title,
      this.controller,
      this.readOnly,
      [
        this.onTap,
      ]
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title,textAlign: TextAlign.start,style: TextStyle(
            fontSize: 17,
            color: kTextColorAccent
        ),)),
        Flexible(
          child: TextFormField(
            onTap: onTap,
             readOnly:readOnly? true:false,
            // initialValue: value,
            controller: controller,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
