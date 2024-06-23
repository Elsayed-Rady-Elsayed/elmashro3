import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class elevatedButton extends StatelessWidget {
  String title;
  final Function() func;
  elevatedButton(this.title,this.func);
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
        data: ElevatedButtonThemeData(style:ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            kAccentGreen,
          ),
          foregroundColor: MaterialStateProperty.all(
            kPrimaryGreen,
          ),
          elevation: MaterialStateProperty.all(
            0,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(4),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(
              double.infinity,
              getProportionateScreenHeight(56),
            ),
          ),
        ),),
        child: ElevatedButton(onPressed: func, child: Text(title)));
  }
}
