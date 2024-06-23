import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class TextFieldWidget extends StatelessWidget {
  var controller;
  String hint;
  var icon;
  TextFieldWidget(this.hint,this.icon,this.controller);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
          borderSide: BorderSide(color: kGreyShade3),
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
          borderSide: BorderSide(color: kGreyShade3),
        ),
        suffixIcon: Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: kGreyShade3)
    ),

    );
  }
}