import 'dart:convert';

import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/forgotPassword.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/signUpScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/links.dart';
import '../controller/crud.dart';
import '../main.dart';
import '../widgets/backBtn.dart';
import '../widgets/elevatedWidget.dart';
import '../widgets/orWidget.dart';
import '../widgets/textFieldWidget.dart';
class loginScreen extends StatefulWidget {
  static const routName = "/loginScreen";

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GlobalKey<FormState>key = GlobalKey();

  crud c = crud();

  login()async{
    if(email.text.isNotEmpty && password.text.isNotEmpty) {
      var res = await c.postRequest(loginLink, {
        "email": email.text,
        "password": password.text
      });
      res = await jsonDecode(res);
      if (res["status"] == "success") {

        sharedPreferences.setString("id", res['data']['id'].toString());
        sharedPreferences.setString("name", res['data']['username'].toString());
        sharedPreferences.setString("email", res['data']['email'].toString());
        print("hello");

        Navigator.of(context).pushNamedAndRemoveUntil(
            MainPage.routeName, (route) => false);
      } else {
        print("hello");
        Fluttertoast.showToast(
          msg: "email or password is wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,

        );
      }
    }else{
      Fluttertoast.showToast(
        msg: "please enter your email and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,

      );
    }
  }
  var uid;
  lll()async{
    var res =await c.getRequest(getAllUsersLink);
    if(res["status"] == "failed"){
      uid = 0;
    }else{
      var l =int.parse(res["data"][res["data"].length-1]["id"]) + 1;
      uid = l;
    }
    print(uid);
  }
  @override
  Widget build(BuildContext context) {
    lll();
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
                        child: Text("Log in Continue",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)),
                    Spacer(),
                    elevatedButton("Log in with facebook",(){}),
                    SizedBox(height: getProportionateScreenHeight(12),),
                    elevatedButton("Log in with google",(){}),
                    Spacer(),
                    orWidget(),
                    Spacer(),
                    Form(
                        child: Column(
                      children: [
                        TextFieldWidget("Email",Icons.email,email),
                        SizedBox(height: getProportionateScreenHeight(16),),
                        TextFieldWidget("Password",Icons.visibility_sharp,password),
                      ],
                    )),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap:(){
                            Navigator.of(context).pushNamed(ForgotPassword.routName);
                          },
                          child: Text("Forgot Password?",style: TextStyle(color: kPrimaryGreen,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      print("g");
                      login();
                      // Navigator.of(context).pushNamed(MainPage.routeName);
                    }, child: Text("Login")),
                    Spacer(flex: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(registerScreen.routeName);
                      },
                      child: RichText(
                          text: TextSpan(text: "Don't have an account?",style: Theme.of(context).textTheme.bodyText2,children: [
                        TextSpan(text: "Register",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kPrimaryGreen,fontWeight: FontWeight.bold))
                      ])
                      ),
                    ),
                    Spacer(),
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





