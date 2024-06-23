import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../constants/links.dart';
import '../../controller/crud.dart';
class recyclingScreen extends StatefulWidget {
  static const route = "/recyclingScreen";

  @override
  State<recyclingScreen> createState() => _recyclingScreenState();
}

class _recyclingScreenState extends State<recyclingScreen> {
  crud c = crud();
  var process = [];
  getProducts()async{
    var response = await c.getRequest(viewAllprocess);
    // response = jsonDecode(response);
    process = response["data"];
    setState(() {

    });
    print(process);
  }
  removeFromPend(uid,pp)async{
    var user =await c.postRequest(getSpecificUser, {
      "userId":uid,
    });
    user = jsonDecode(user);
    print(user["data"][0]["pending_points"]);
    var oldPoints = user["data"][0]["pending_points"];
    var totalPoints = int.parse(oldPoints)-pp;
    print(totalPoints);
    var editPoints = await c.postRequest(pendingPoints, {
      "pending_points":totalPoints.toString(),
      "user_id":uid
    });
  }
  editPend(uid,pp)async{
    var user =await c.postRequest(getSpecificUser, {
      "userId":uid,
    });
    user = jsonDecode(user);
    print(user["data"][0]["active_points"]);
    var oldPoints = user["data"][0]["active_points"];
    var totalPoints = int.parse(oldPoints)+pp;
    print(totalPoints);
    var editPoints = await c.postRequest(activePointsEdit, {
      "activePoints":totalPoints.toString(),
      "user_id":uid
    });
  }
  editProcessFunc(var id)async{
    var res = await c.postRequest(editProcess, {
     "id":id,
     "recived_items":"1"
    });
    print(res);
  }
  @override
  Widget build(BuildContext context) {
    getProducts();
    return ListView.builder(
        itemCount: process.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
            },
            child: Container(
              margin: EdgeInsets.all(10),
              color: kGreyShade5,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("items points ${process[index]["item_points"]}"),
                    Text("process points ${process[index]["process_points"]}"),
                    Text("customer id ${process[index]["customer_id"]}"),
                    Text("items ${process[index]["items"]}"),
                    MaterialButton(color: kPrimaryGreen,onPressed: (){
                      editProcessFunc(process[index]["id"]);
                      editPend(process[index]["customer_id"],int.parse(process[index]["process_points"]));
                      removeFromPend(process[index]["customer_id"],int.parse(process[index]["process_points"]));
                    },child: Text(process[index]["recived_items"] == '0'?"not accepted":"accepted"),)
                  ],
                ),
                // leading: Image.network("${imgRoute}/${products[index]["image"]}",width: 100,fit: BoxFit.fill,),
              ),
            ),
          );
        });  }
}
