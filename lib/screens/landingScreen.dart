import 'package:elmashro3/screens/introScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:elmashro3/constants/colors.dart';
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const routeName = "/landingScreen";
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/landing.png",fit: BoxFit.cover,),
              Expanded(child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: Text("Welcome to Green Market",style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: kTextColor,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                        Spacer(),
                      ],
                    ),
                    // Text("we have more than 500 product that you can replace with some plastic or cans",style: Theme.of(context).textTheme.headline4,),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamed(IntroScreen.routeName);
                    }, child: Text("Get Started")),
                    Spacer(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
