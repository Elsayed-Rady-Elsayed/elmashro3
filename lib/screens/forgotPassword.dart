import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/changePassword.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/signUpScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:elmashro3/constants/colors.dart';
import '../widgets/backBtn.dart';
import '../widgets/elevatedWidget.dart';
import '../widgets/orWidget.dart';
import '../widgets/textFieldWidget.dart';
class ForgotPassword extends StatelessWidget {
  static const routName = "/forgotPassword";
  TextEditingController code= TextEditingController();
  TextEditingController email= TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backBtn(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth((16))),
                child: Column(
                  children: [
                    Align(
                        alignment:Alignment.centerLeft,
                        child: Text("restore password",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)),
                    Spacer(),
                    TextFieldWidget("Email",Icons.email,email),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamed(MainPage.routeName);
                    }, child: Text("send code")),
                    Spacer(),
                    TextFieldWidget("Code",Icons.visibility_sharp,code),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamed(changePassword.routeName);
                    }, child: Text("check")),
                    Spacer(flex: 5,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





