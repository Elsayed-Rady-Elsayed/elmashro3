import 'package:flutter/material.dart';

import '../utils/screenUtils.dart';
import 'offerWidget.dart';

class specialOffer extends StatelessWidget {
  var specialdeal = [
    {
      "title": "you will find greet offers here",
      "img": "assets/offer2.jpg",
      "desc":
          "if you are searching for special offers to buy products with more than half the price then here you will find it"
    },
    {
      "title": "you will find greet offers here",
      "img": "assets/offer1.jpg",
      "desc":
          "if you are searching for special offers to buy products with more than half the price then here you will find it"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Special Deals For You",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(16)),
              )),
              TextButton(onPressed: () {}, child: Text("See All"))
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OfferWidget(specialdeal[0]["title"]!, specialdeal[0]["desc"]!,
                    specialdeal[0]["img"]!),
                OfferWidget(specialdeal[1]["title"]!, specialdeal[1]["desc"]!,
                    specialdeal[1]["img"]!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// into
//brop statment
// objectives