import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import '../constants/links.dart';
class SuccessPaymentScreen extends StatefulWidget {
  static final routeName = "/SuccessPayment";

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  crud c = crud();

  var arguments;

  var oId = 0;

  getOrders()async{
    var res = await c.getRequest(getOrdersLink);
    //res = jsonDecode(res);
    print(res["data"][res["data"].length-1]["id"]);
    setState(() {
      oId =int.parse(res["data"][res["data"].length-1]["id"]);
    });
    // return res;
    print(oId);
  }

  addOrder()async{
    var res = await c.postRequest(addOrderProductLink, {
      "product_id":arguments["data"]["orderDetails"]["item"]["id"],
      "quantity":arguments["data"]["orderDetails"]["quantity"],
      "total_price":(arguments["data"]["tPrice"]).toString(),
      "order_id":oId.toString()
    });
    print(res);
  }
  addMOrder(var i,var p)async{
    var res = await c.postRequest(addOrderProductLink, {
      "product_id":i.toString(),
      "quantity":"1",
      "total_price":p.toString(),
      "order_id":oId.toString()
    });
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(child: Image.asset("assets/wallet_illu.png"),)
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Text("order Successfully",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),),
                      Text("thanks for confitmin the irder please check you message next week it may be ended",
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent),textAlign: TextAlign.center,)
                    ],
                  ),
            )),
            Padding(padding: EdgeInsets.all(10),child: ElevatedButton(
              onPressed: ()async{
                if(arguments["data"]["idList"].isEmpty) {
                   addOrder();
                }else{
                  for(var i in arguments["data"]["orderDetails"]["item"]){
                    addMOrder(i["id"],i["price"]);
                  }
                }
                 Navigator.of(context).pushNamed(MainPage.routeName);
              },
              child: Text("Continue Shopping"),
            ),)
          ],
        ),
      ),
    );
  }
}
