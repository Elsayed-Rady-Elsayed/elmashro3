import 'dart:convert';

import 'package:elmashro3/admin/screens/userinfo.dart';
import 'package:elmashro3/model/userModel.dart';
import 'package:flutter/material.dart';

import '../../constants/links.dart';
import '../../controller/crud.dart';
class usersViewScreen extends StatefulWidget {
  static const route = "/usersViewScreen";

  @override
  State<usersViewScreen> createState() => _usersViewScreenState();
}

class _usersViewScreenState extends State<usersViewScreen> {
  crud c = crud();
  var users = [];
  getUsers()async{
    var response = await c.getRequest(ViewUsersAdmin);
    // response = jsonDecode(response);
    users = response["data"];
    setState(() {

    });
    print(users);
  }
  @override
  Widget build(BuildContext context) {
    getUsers();
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(userinfo.route,arguments: {
            "data":users[index]
          });
        },
        child: ListTile(
          title: Text("${users[index]["first_name"]} ${users[index]["last_name"]}"),
          leading:users[index]["image"]=="not selected" ? Text(""): Image.network("${imgRoute}/${users[index]["image"]}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("active points ${users[index]["active_points"]}"),
              SizedBox(width: 10,),
              Text("pending points ${users[index]["pending_points"]}"),
              SizedBox(width: 10,),
              Text("is point verified ${users[index]["is_points_verified"]}"),
            ],
          ),
        ),
      );
    });
  }
}
