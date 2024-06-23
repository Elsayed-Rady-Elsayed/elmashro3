import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            color: kGreyShade5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: kGreyShade1,
                    radius: getProportionateScreenWidth(4),
                  ),
                  SizedBox(width: 8,),
                  CircleAvatar(
                    backgroundColor: kGreyShade1,
                    radius: getProportionateScreenWidth(4),
                  ),
                  SizedBox(width: 8,),
                  CircleAvatar(
                    backgroundColor: kGreyShade1,
                    radius: getProportionateScreenWidth(4),
                  ),
                  SizedBox(width: 8,),
                  CircleAvatar(
                    backgroundColor: kGreyShade1,
                    radius: getProportionateScreenWidth(4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
