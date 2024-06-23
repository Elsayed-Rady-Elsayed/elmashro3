import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/constants/links.dart';
import 'package:elmashro3/main.dart';
import 'package:elmashro3/model/userModel.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/crud.dart';
import '../widgets/ImageSelctionWidget.dart';
import '../widgets/infoWidget.dart';
class myProfileScreen extends StatefulWidget {
  static const routeName = "/myProfileScreen";

  @override
  State<myProfileScreen> createState() => _myProfileScreenState();
}

class _myProfileScreenState extends State<myProfileScreen> {
  crud c = crud();
  TextEditingController firstname = TextEditingController();
  TextEditingController secondname = TextEditingController();
  String gender = "";
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  var isLoading = true;
  bool selectedItem = false;
  var selectedItemToUp;
  TextEditingController activePoints = TextEditingController();
  TextEditingController pendingPoints = TextEditingController();
  getuser()async{
    setState(() {
      isLoading = false;
    });
    var response = await c.postRequest( getUserLink,{
        "userId":sharedPreferences.getString("id"),
    });
    response = jsonDecode(response);
    firstname.text= response["data"][0]["first_name"];
    secondname.text = response["data"][0]["last_name"];
    email.text = response["data"][0]["email"];
    phone.text = response["data"][0]["phone"];
    gender = response["data"][0]["gender"];
    activePoints.text = response["data"][0]["active_points"];
    pendingPoints.text = response["data"][0]["pending_points"];

    return response;
  }
  editUser()async{
    var res = await c.postRequest(editUserLink, {
      "firstName":firstname.text,
      "lastName":secondname.text,
      "email":email.text,
      "phone":phone.text,
      "gender":selectedItemToUp.toString(),
      "user_id":sharedPreferences.getString("id"),
    });
    print(res);
  }
  @override
  Widget build(BuildContext context) {
    getuser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:isLoading? Center(child: CircularProgressIndicator(),):SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              featuredHeader("my profile", Icons.save),
              SizedBox(height: getProportionateScreenHeight(10),),
              ImageSelection(),
              Divider(
                height: getProportionateScreenHeight(20),
              ),
              InfoLine("first NAME",firstname,false),
              InfoLine("second NAME",secondname,false),
              InfoLine("email",email,false),
              InfoLine("phone number",phone,false),
              DropdownButton(
                  icon: Icon(Icons.arrow_circle_down_rounded),
                  isExpanded: true,
                  value: selectedItem == false?false:selectedItem,
                  items: [
                    DropdownMenuItem(child: Text("male"),value: true,),
                    DropdownMenuItem(child: Text("female"),value:false),
                  ], onChanged: (selected){
                setState(() {
                  selectedItem = selected==false?false:true;
                  selectedItemToUp = selected == false?"0":"1";
                });
              }),
              InfoLine("active points",activePoints,true),
              InfoLine("pending points",pendingPoints,true),
              MaterialButton(color: Colors.green,minWidth: double.infinity,onPressed: (){
                editUser();
              },child: Text("save",style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),
      ),
    );
  }
}

