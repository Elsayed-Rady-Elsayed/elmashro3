import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class backBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return RawMaterialButton(
      onPressed: (){Navigator.of(context).pop();},
      child: Icon(Icons.arrow_back_ios,color: kPrimaryGreen,),
      constraints: BoxConstraints.tightFor(width: getProportionateScreenWidth(30),
          height: getProportionateScreenHeight(40)),
    );
  }
}