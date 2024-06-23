import 'package:flutter/material.dart';

import '../model/categories.dart';
import '../utils/screenUtils.dart';
class CategoryCard extends StatelessWidget {
  late CategoryModel c;
  CategoryCard(this.c);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(22)),
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenWidth(28),
            backgroundColor: c.color,
            child: Container(
                width: getProportionateScreenWidth(32),
                child: Image.network(c.catImg,fit: BoxFit.cover,)),
          ),
          Text(c.cateName)
        ],
      ),
    );
  }
}