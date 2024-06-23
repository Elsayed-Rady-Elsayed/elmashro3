import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/model/address.dart';
import 'package:elmashro3/screens/add_address.dart';
import 'package:elmashro3/screens/changeAddress.dart';
import 'package:elmashro3/screens/landingScreen.dart';
import 'package:elmashro3/screens/myProfileScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';

import '../constants/links.dart';
import '../controller/crud.dart';
import '../main.dart';
import '../widgets/ImageSelctionWidget.dart';
import '../widgets/cardWidget.dart';
class ProfileServices extends StatefulWidget {
  @override
  State<ProfileServices> createState() => _ProfileServicesState();
}

class _ProfileServicesState extends State<ProfileServices> {
  crud c = crud();

  String city = "";

  String email = "";

  bool isLoading = true;

  getcity()async{
    var response = await c.postRequest( getcityLink,{
      "userId": sharedPreferences.getString("id"),
    });
    response = jsonDecode(response);
     city ="${response["data"][0]["name"]} ";
      email = sharedPreferences.getString("email")!;
    isLoading = false;
    return response;
  }

  String fullAddress = "";

  getregion()async{
    var response = await c.postRequest( getregionLink,{
      "userId":sharedPreferences.getString("id"),
    });
    response = jsonDecode(response);
      fullAddress = "${city},${response["data"][0]["name"]}";
    isLoading = false;
    setState(() {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    getcity();
    getregion();
    ScreenUtils().init(context);
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImageSelection(),
              Text("${fullAddress}",style: Theme.of(context).textTheme.headline3!
                  .copyWith(fontWeight: FontWeight.w700),),
              Text("${email}",style: Theme.of(context).textTheme.headline4!.copyWith(
                color: kTextColorAccent
              ),),
              Divider(height: getProportionateScreenHeight(33),),
              CardServices("my profile","assets/profile_user.png",kAccentGreen,(){
                Navigator.of(context).pushNamed(myProfileScreen.routeName);
              }),
              CardServices("my address","assets/map_user.png",kAccentTosca,(){
                Navigator.of(context).pushNamed(editAddressScreen.routeName);
              }),
              CardServices("help center","assets/check_user.png",kAccentPurple,(){}),
              CardServices("log out","assets/Trash Bin.png",kAccentRed,(){
                Navigator.of(context).pushNamed(LandingScreen.routeName);
                sharedPreferences.clear();
              }),

            ],
          ),
        ),
      ),
    );
  }
}
