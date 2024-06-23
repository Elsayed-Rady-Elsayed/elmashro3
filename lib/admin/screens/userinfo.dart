import 'dart:io';

import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/widgets/backBtn.dart';
import 'package:elmashro3/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';
import '../../constants/links.dart';
import '../../utils/screenUtils.dart';
class userinfo extends StatefulWidget {
  static const route = "/userinfo";

  @override
  State<userinfo> createState() => _userinfoState();
}

class _userinfoState extends State<userinfo> {
  var rcvdData;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController creditcard = TextEditingController();
  TextEditingController activep = TextEditingController();
  TextEditingController ispverf = TextEditingController();
  TextEditingController pendingp = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController createdat = TextEditingController();
  TextEditingController updatedat = TextEditingController();

  @override
  void setData(){
    fname.text = rcvdData["data"]["first_name"];
    lname.text = rcvdData["data"]["last_name"];
    email.text = rcvdData["data"]["email"];
    password.text = rcvdData["data"]["password"];
    gender.text = rcvdData["data"]["gender"].toString();
    birthdate.text = rcvdData["data"]["birthdate"];
    phone.text = rcvdData["data"]["phone"];
    creditcard.text = rcvdData["data"]["creditcard"];
    activep.text = rcvdData["data"]["active_points"];
    ispverf.text = rcvdData["data"]["is_points_verified"];
    pendingp.text = rcvdData["data"]["pending_points"];
    status.text = rcvdData["data"]["status"];
    createdat.text = rcvdData["data"]["created_at"];
    updatedat.text = rcvdData["data"]["updated_at"];

    setState(() {

    });
  }
  crud c = crud();
  late var mfile;

  editUser()async{
    var res = await c.postRequstWithFile(adminEditUser, {
      "firstName":fname.text,
      "lastName":lname.text,
      "email":email.text,
      "phone":phone.text,
      "gender":gender.toString(),
      "birthdate":birthdate.text,
      "creditcard":creditcard.text,
      "active_points":activep.text,
      "is_points_vreified":ispverf.text,
      "pending_points":pendingp.text,
      "status":status.text,
      "created_at":createdat.text,
      "updated_at":updatedat.text,
      "user_id":rcvdData["data"]["id"],
    },mfile);
    print(res);
  }

  GetFile(s){
    return File(s);
  }
  @override
  Widget build(BuildContext context) {
    rcvdData = ModalRoute.of(context)!.settings.arguments;
    setData();
    return Scaffold(
      appBar: AppBar(
        leading: backBtn(),
        title: Text("user information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text("first name"),
            TextFieldWidget("first name", Icons.person, fname),
            SizedBox(height: 14,),
            Text("last name"),
            TextFieldWidget("last name", Icons.person, lname),
            SizedBox(height: 14,),
            Text("email"),
            TextFieldWidget("email", Icons.email, email),
            SizedBox(height: 14,),
            Text("passwrod"),
            TextFieldWidget("password", Icons.visibility, password),
            SizedBox(height: 14,),
            Text("gender"),
            TextFieldWidget("gender", Icons.person, gender),
            SizedBox(height: 14,),
            Text("birthdate"),
            TextFieldWidget("birthdate", Icons.calendar_month, birthdate),
            SizedBox(height: 14,),
            Text("phone"),
            TextFieldWidget("phone", Icons.phone, phone),
            SizedBox(height: 14,),
            Text("creditcard"),
            TextFieldWidget("creditcard", Icons.credit_card_rounded, creditcard),
            SizedBox(height: 14,),
            Text("active points"),
            TextFieldWidget("active points", Icons.point_of_sale, activep),
            SizedBox(height: 14,),
            Text("pending points"),
            TextFieldWidget("pending points", Icons.point_of_sale, pendingp),
            SizedBox(height: 14,),
            Text("is pending points"),
            TextFieldWidget("is pending points", Icons.point_of_sale, ispverf),
            SizedBox(height: 14,),
            Text("status"),
            TextFieldWidget("status", Icons.save, status),
            SizedBox(height: 14,),
            Text("created at"),
            TextFieldWidget("created at", Icons.calendar_month, createdat),
            SizedBox(height: 14,),
            Text("updated at"),
            TextFieldWidget("updated at", Icons.calendar_month, updatedat),
            SizedBox(height: 14,),
            MaterialButton(onPressed: ()async{
              XFile? xfile = await ImagePicker().pickImage(source:ImageSource.gallery);
              mfile =GetFile(xfile!.path);
            },child: Text("uplode image"),color: Colors.blue,),
            MaterialButton(onPressed: (){
              editUser();
            },child: Text("Edit user info"),minWidth: double.infinity,color: Colors.green,),


          ],
        ),
      ),
    );
  }
}
