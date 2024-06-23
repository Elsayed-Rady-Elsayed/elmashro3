import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomeAppBar.dart';
class vegetableScreen extends StatelessWidget {
  static final routeName ="/vegetableScreen";
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(12),),
            featuredHeader("Featured vegetables",Icons.search),
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                FeaturedWidget(),
                FeaturedWidget(),
                FeaturedWidget(),
                FeaturedWidget(),
                FeaturedWidget(),
                FeaturedWidget(),
                FeaturedWidget(),

              ],
            )),
          ],
        ),
      ),
    );
  }
}

class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
      padding:EdgeInsets.all(8),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
        ),
        shadows: [
          BoxShadow(
            color: kShadowColor,
            offset: Offset(
              getProportionateScreenWidth(24),
              getProportionateScreenWidth(40),
            ),
            blurRadius: 80,
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: getProportionateScreenHeight(80),
              decoration: BoxDecoration(
                color: kGreyShade5,
                borderRadius: BorderRadius.circular(getProportionateScreenWidth(8))
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10),),
          Expanded(
              flex:2,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getProportionateScreenWidth(30)),
                  color: Colors.red
                ),
                child:Text("Disc 40%",style: TextStyle(color: Colors.white),),
              ),
              Text("Dragon fruit",style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),),
              Text("200gr",style: TextStyle(fontSize: getProportionateScreenWidth(10),color: kTextColorAccent),),
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$90",style: TextStyle(color: kTextColorAccent,decoration: TextDecoration.lineThrough,fontSize: getProportionateScreenWidth(10)),),
              Text("\$45",style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.w700),),
            ],
          ),

        ],
      ),
    );
  }
}


class BackbtnWithtext extends StatelessWidget {
  const BackbtnWithtext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios,color: kPrimaryGreen,),
          Text("Back",style: Theme.of(context).textTheme.headline4!.copyWith(color: kPrimaryGreen),)
        ],
      ),
    );
  }
}
