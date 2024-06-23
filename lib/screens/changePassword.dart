import 'package:elmashro3/screens/MainPage.dart';
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
class changePassword extends StatelessWidget {
  static const routeName = "/changePassword";
  TextEditingController re_npass= TextEditingController();
  TextEditingController nPass= TextEditingController();
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
                        child: Text("change password",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)),
                    Spacer(),
                    TextFieldWidget("new password",Icons.email,nPass),
                    Spacer(),
                    TextFieldWidget("re-enter new password",Icons.visibility_sharp,re_npass),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamed(MainPage.routeName);
                    }, child: Text("change")),
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





