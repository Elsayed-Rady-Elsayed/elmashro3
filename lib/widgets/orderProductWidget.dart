import 'package:elmashro3/controller/crud.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/links.dart';
import '../utils/screenUtils.dart';

class OrderProductWidget extends StatefulWidget {
  String image;
  String title;
  String quantity;
  String price;
  var id;
  String desc;
  OrderProductWidget(
      this.desc,
      {required this.id,required this.image,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  State<OrderProductWidget> createState() => _OrderProductWidgetState();
}

class _OrderProductWidgetState extends State<OrderProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: getProportionateScreenHeight(130),
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          shadows: [
            BoxShadow(
                color: kShadowColor, offset: Offset(25, 45), blurRadius: 80)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.network(
                widget.image,
                fit: BoxFit.fill,
              ),
              width: getProportionateScreenWidth(80),
              decoration: ShapeDecoration(
                  color: kGreyShade5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(
                  widget.desc,
                  style: TextStyle(color: kTextColorAccent, fontSize: 12),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.quantity,
                      style: TextStyle(color: kTextColorAccent, fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "${widget.price} EGP",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
