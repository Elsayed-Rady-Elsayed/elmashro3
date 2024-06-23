import 'package:elmashro3/screens/profileServices.dart';
import 'package:elmashro3/screens/uplodeOrTakePictureScreen.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/cardWidget.dart';
class recyclingMainPage extends StatelessWidget {
  const recyclingMainPage({super.key});
  static const routeName = "/recyclingMainPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              featuredHeader("recycling page", Icons.recycling),
              selectServicesWidget(icon: Icons.image,title: "uplode image",tapHandler: (){
                Navigator.of(context).pushNamed(uplodeOrTakePictrureScreen.routeName);
              },color: kAccentGreen,),
              //selectServicesWidget(icon: Icons.camera,title: "taking live photo",tapHandler: (){},color: kAccentRed,),
              Spacer(),
              // Container(
              //   padding: EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color:kPrimaryGreen,
              //     boxShadow: [
              //       BoxShadow(color: kShadowColor,blurRadius: 10,spreadRadius: 5)
              //     ]
              //   ),
              //   child: Row(
              //     children: [
              //       Text("your pending points",style: TextStyle(color: Colors.white),),
              //       Spacer(),
              //       Text("40",style: TextStyle(color: Colors.white),),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class selectServicesWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? tapHandler;
  final Color? color;
  selectServicesWidget({
    this.title,
    this.icon,
    this.tapHandler,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
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
              padding:EdgeInsets.all(12),
              decoration:ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ),
              child: Icon(icon),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Text(title!,style: Theme.of(context).textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.w700),)),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
