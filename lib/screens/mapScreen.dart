import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/backBtn.dart';
import 'package:elmashro3/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class mapScreen extends StatelessWidget {
  static var routeName = "/mapScreen";
  @override
  Widget build(BuildContext context) {

    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backBtn(),
                Text("choose your address",style: TextStyle(fontWeight: FontWeight.w600,fontSize: getProportionateScreenWidth(17)),),
                SizedBox(width: getProportionateScreenWidth(32),)
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left:0,
                      right: 0,
                      child: Image.asset("assets/curLoc.png"),
                  ),
                Container(
                  width:double.infinity,
                  child: Image.asset("assets/map_pattern.jpg")
              ),
              bottomCard()
            ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class bottomCard extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(onPressed: (){},child: Icon(Icons.gps_fixed),),
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular( getProportionateScreenWidth(8)),
                  topRight:Radius.circular( getProportionateScreenWidth(8)) ),
              color: Colors.white
            ),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("toukh,benha",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),),
                      Spacer(),
                      Icon(Icons.search),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(12),),
                  Text("Norriston, pennsylavinan,19302",style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent),),
                  SizedBox(height: getProportionateScreenHeight(7),),
                  Text("Detail Address",style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent)),
                  SizedBox(height: getProportionateScreenHeight(12),),
                  TextFieldWidget("write down the building number ", Icons.place,controller),
                  SizedBox(height: getProportionateScreenHeight(12),),
                  ElevatedButton(onPressed: (){}, child: Text("add address"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
