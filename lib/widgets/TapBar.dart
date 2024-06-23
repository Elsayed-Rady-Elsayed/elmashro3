import 'package:flutter/material.dart';

import '../constants/colors.dart';
class subtitleandPrice extends StatelessWidget {
  final String title;
  final String price;
  subtitleandPrice(

      this.title,
      this.price
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent),),
        Spacer(),
        Text(price,style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColor,fontWeight: FontWeight.w700),)
      ],
    );
  }
}