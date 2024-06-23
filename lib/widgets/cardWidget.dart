import 'package:flutter/material.dart';

import '../constants/colors.dart';
class CardServices extends StatelessWidget {
  final String title;
  final String img;
  final Color color;
  final Function() TapHandler;
  const CardServices(
      this.title,
      this.img,
      this.color,
      this.TapHandler
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: TapHandler,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            shadows: [
              BoxShadow(offset: Offset(0,2),blurRadius: 10,color: kShadowColor.withOpacity(.1))
            ]
        ),
        child: Row(
          children: [
            Container(
              padding:EdgeInsets.all(8),
              decoration:ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ),
              child: Image.asset(img),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Text(title,style: Theme.of(context).textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.w700),)),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

