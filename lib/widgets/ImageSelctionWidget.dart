import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class ImageSelection extends StatelessWidget {
  const ImageSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(110),
      width: getProportionateScreenWidth(110),
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: kGreyShade5
            ),
          ),
        ],
      ),
    );
  }
}
