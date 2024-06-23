import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/vegetableScreen.dart';
import '../utils/screenUtils.dart';
class featuredHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  featuredHeader(this.title,this.icon);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackbtnWithtext(),
        Spacer(),
        Text(title,style: TextStyle(fontSize: getProportionateScreenWidth(17),fontWeight: FontWeight.w600),),
        Spacer(),
        Icon(icon,color: kPrimaryGreen,),
        SizedBox(width: getProportionateScreenWidth(12),)
      ],
    );
  }
}