import 'dart:convert';

import 'package:elmashro3/admin/screens/home.dart';
import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/forgotPassword.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/signUpScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/links.dart';
import '../../controller/crud.dart';
import '../../main.dart';
import '../../widgets/backBtn.dart';
import '../../widgets/elevatedWidget.dart';
import '../../widgets/orWidget.dart';
import '../../widgets/textFieldWidget.dart';
class loginScreenAdmin extends StatefulWidget {
  static const routName = "/loginScreenAdmin";

  @override
  State<loginScreenAdmin> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreenAdmin> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GlobalKey<FormState>key = GlobalKey();

  crud c = crud();

  login()async{
    if(email.text.isNotEmpty && password.text.isNotEmpty) {
      var res = await c.postRequest(loginAdminLink, {
        "email": email.text,
        "password": password.text
      });
      res = await jsonDecode(res);
      print(res);

      if (res["status"] == "success") {
        sharedPreferences.setString("id", res['data']['id'].toString());
        sharedPreferences.setString("name", res['data']['username'].toString());
        sharedPreferences.setString("email", res['data']['email'].toString());
        // Navigator.pushNamedAndRemoveUntil(context, "/adminHomePage", (route) => false);
       Navigator.push(context, MaterialPageRoute(builder: (context){return homeScreen();}));
      } else {
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

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    Spacer(flex: 2,),
                    Form(
                        child: Column(
                          children: [
                            TextFieldWidget("Email",Icons.email,email),
                            SizedBox(height: getProportionateScreenHeight(16),),
                            TextFieldWidget("Password",Icons.visibility_sharp,password),
                          ],
                        )),
                    SizedBox(height: getProportionateScreenHeight(18),),
                    ElevatedButton(onPressed: (){
                      login();
                      // Navigator.of(context).pushNamed(MainPage.routeName);
                    }, child: Text("Login")),
                    Spacer(flex: 3,),
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





