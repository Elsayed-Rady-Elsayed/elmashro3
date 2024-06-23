import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/checkOutScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../constants/links.dart';
import '../main.dart';
import '../widgets/TapBar.dart';
import '../widgets/orWidget.dart';

class orderSummary extends StatefulWidget {
  static const routeName = "/orderSummary";

  @override
  State<orderSummary> createState() => _orderSummaryState();
}

class _orderSummaryState extends State<orderSummary> {
  var controller = TextEditingController();
  String ptsValue = "";
  double? avilable;
  double price = 53;
  crud c = crud();
  bool isLoading = true;
  bool ShowErr = false;
  getuser()async{
    setState(() {
      isLoading = false;
    });
    var response = await c.postRequest( getUserLink,{
      "userId":sharedPreferences.getString("id"),
    });
    response = jsonDecode(response);
    avilable= double.parse(response["data"][0]["active_points"]);
    setState(() {
    });
    return response;
  }
  var listObj = [
    {
      "image": "assets/apples.jpg",
      "title": "fresh apples",
      "quantity": "100gr",
      "price": "200 EGP"
    },
  ];
  var arguments;
  var UsedPoints;
  // addOrder()async{
  //   var res = await c.postRequest(addOrderLink, {
  //     "product_id":arguments["item"]["id"],
  //     "order_id":arguments["quantity"],
  //     "total_price":(int.parse(arguments["item"]["price"])*int.parse(arguments["quantity"]))+25,
  //     "order_id":""
  //   });
  //   //print(res);
  // }
  double PointsChangedWithMoney = 0;
  @override
  bool checkPage = true;
  var idLists = [];
  dynamic TotalPrice = 0 ;
  editPend(uid,pp)async{
    var user =await c.postRequest(getSpecificUser, {
      "userId":uid,
    });
    user = jsonDecode(user);
    print(user["data"][0]["active_points"]);
    var oldPoints = user["data"][0]["active_points"];
    var totalPoints = int.parse(oldPoints) - pp;
    print(totalPoints);
    var editPoints = await c.postRequest(activePointsEdit, {
      "activePoints":totalPoints.toString(),
      "user_id":uid
    });
  }
  Widget build(BuildContext context) {
    getuser();
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ScreenUtils().init(context);
    if(arguments["singleItem"] == "1") {
      checkPage = false;
      print("yyyyyy");
    }
    if(checkPage){
      // arguments["item"] = jsonDecode(arguments["item"]);
      // print("this is data ${arguments["item"]
      // }" );
      // print("this iiiii ${arguments["item"][0]}");
      TotalPrice = 0;
      for (var i in arguments["item"]) {
        idLists.add(i["id"]);
        TotalPrice += int.parse(i["price"]);
      }
    }else{
      TotalPrice= int.parse(arguments["item"]["price"]) * int.parse(arguments["quantity"]);
    }
    //print(idLists);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // addOrder();
            editPend(sharedPreferences.getString("id"),UsedPoints);
            Navigator.of(context).pushNamed(CheckOutScreen.routeName,arguments: {
              "orderDetails":arguments,
              "tPrice":((TotalPrice+25)-PointsChangedWithMoney).toString(),
              "idList":idLists
            });
          },
          backgroundColor: kPrimaryGreen,
          label: Text("Check out",style: TextStyle(color: Colors.white),)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(12)
            ),
            child: Column(
              children: [
                featuredHeader("order summary", Icons.summarize),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height:200,
                        child: ListView.builder(
                            itemCount:checkPage? arguments["item"].length:1,itemBuilder: (xtx,idx){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OrderSummaryWidget(
                                checkPage? arguments["item"][idx]["price"]:arguments["item"]["price"],
                                arguments["quantity"],
                                checkPage?arguments["item"][idx]["name"]:arguments["item"]["title"],
                                checkPage?"${imgRoute}/${arguments["item"][idx]["image"]}":"${arguments["item"]["image"]}",
                                true
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Divider(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                      "points to use",
                      style: TextStyle(color: kTextColorAccent, fontSize: 17),
                    ),
                    Spacer(),
                    Text("${avilable==null?"":avilable} point available"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: controller,
                  onChanged: (v) {
                    setState(() {
                      ShowErr = false;
                      if(double.parse(v) <= avilable!) {
                        ptsValue = v;
                        UsedPoints = int.parse(controller.text);
                        PointsChangedWithMoney = int.parse(controller.text) /
                            10;
                      }else{
                        ShowErr = true;
                      }
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: kGreyShade3)),
                      hintText: "enter number of points",
                      suffixText: "apply",
                      suffixStyle: TextStyle(color: kPrimaryGreen)),
                ),
                ShowErr? Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("invalid value of points",style: TextStyle(color: Colors.red,fontSize: 12),),
                ):Container(),
                Divider(
                  height: 33,
                ),
                 subtitleandPrice("sub total price", "${TotalPrice} EGP"),
                subtitleandPrice("deliver fee", "25 EGP"),
                subtitleandPrice("${ptsValue } used points", "${PointsChangedWithMoney}EGP"),
                // subtitleandPrice("total price in points", "${TotalPrice / PointsChangedWithMoney} point"),
                Divider(
                  height: getProportionateScreenHeight(30),
                ),
                subtitleandPrice("total price", "${((TotalPrice+25)-PointsChangedWithMoney)}EGP"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSummaryWidget extends StatefulWidget {
  bool isFromOrderSummary = false;
  String title;
  String price;
  String quantity;
  String img;
  OrderSummaryWidget(this.price, this.quantity, this.title, this.img,this.isFromOrderSummary);

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState(qu: int.parse(quantity));
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  _OrderSummaryWidgetState({required this.qu});
  int qu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(100),
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          shadows: [
            BoxShadow(
                color: kShadowColor, offset: Offset(25, 45), blurRadius: 80)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.network(
                widget.img,
                fit: BoxFit.fill,
              ),
              width: getProportionateScreenWidth(70),
              decoration: ShapeDecoration(
                  color: kGreyShade5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  qu.toString(),
                  style: TextStyle(color: kTextColorAccent, fontSize: 12),
                ),
                Text(
                  widget.price.toString(),
                  style: TextStyle(color: kTextColorAccent, fontSize: 12),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
