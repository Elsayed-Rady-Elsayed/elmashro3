import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screenUtils.dart';
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: kFillColorThird,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)),borderSide: BorderSide(color: Colors.transparent) ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)),borderSide: BorderSide(color: Colors.transparent) ),
          hintText: "search",
          hintStyle: TextStyle(color: kGreyShade2,fontSize: getProportionateScreenWidth(17))
      ),
    );
  }
}