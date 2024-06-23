import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';

class OfferWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  String img;
  OfferWidget(this.title, this.subtitle, this.img);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
      width: getProportionateScreenWidth(280),
      height: getProportionateScreenHeight(250),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(15))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              img,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(30)),
                    color: Colors.red),
                child: Text(
                  "on sale",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "available quantity ${subtitle}",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
